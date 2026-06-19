import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/models/finance_categories.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/data/sql/sql_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' hide Transaction;

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  late SQLProvider sqlProvider;

  setUp(() async {
    sqlProvider = SQLProvider();
    await sqlProvider.init();
  });

  tearDown(() async {
    final path = sqlProvider.databasePath;
    await sqlProvider.close();
    await deleteDatabase(path);
  });

  test('init creates default wallet', () async {
    final wallets = await sqlProvider.wallets.selectAll();
    expect(wallets, hasLength(1));
    expect(wallets.first.id, greaterThan(0));
  });

  test('selectByWalletId supports pagination', () async {
    final walletId = (await sqlProvider.wallets.selectAll()).first.id;

    for (var i = 0; i < 55; i++) {
      await sqlProvider.transactions.add(
        value: Transaction(
          walletId: walletId,
          amount: i.toDouble(),
          category: FinanceCategories.salary,
          createdAt: DateTime(2024, 1, 1, 12, i % 60),
          description: 'tx $i',
        ),
      );
    }

    final firstPage = await sqlProvider.transactions.selectByWalletId(
      walletId,
      limit: 50,
      offset: 0,
    );
    final secondPage = await sqlProvider.transactions.selectByWalletId(
      walletId,
      limit: 50,
      offset: 50,
    );
    final total = await sqlProvider.transactions.countByWalletId(walletId);

    expect(firstPage, hasLength(50));
    expect(secondPage, hasLength(5));
    expect(total, 55);
  });

  test('addBatch inserts transfer atomically', () async {
    final wallets = await sqlProvider.wallets.selectAll();
    final walletId = wallets.first.id;

    final from = Transaction(
      walletId: walletId,
      amount: -100,
      category: FinanceCategories.transfer,
      createdAt: DateTime.now(),
      description: 'transfer out',
    );
    final to = Transaction(
      walletId: walletId,
      amount: 100,
      category: FinanceCategories.transfer,
      createdAt: DateTime.now(),
      description: 'transfer in',
    );

    await sqlProvider.transactions.addBatch(values: [from, to]);

    final list = await sqlProvider.transactions.selectByWalletId(walletId);
    expect(list, hasLength(2));
    expect(list.map((e) => e.amount).toList()..sort(), [-100.0, 100.0]);
  });

  test('createBackupSnapshot produces valid sqlite file', () async {
    final backupPath = await sqlProvider.createBackupSnapshot();
    addTearDown(() => File(backupPath).deleteSync());

    final file = File(backupPath);
    expect(await file.exists(), isTrue);

    final bytes = await file.openRead(0, 16).first;
    final header = String.fromCharCodes(bytes);
    expect(header.startsWith('SQLite format 3'), isTrue);
  });
}
