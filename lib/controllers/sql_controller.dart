import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class SQLController extends BaseController {
  late Database _database;

  @override
  void onInit() {
    super.onInit();

    _onInitAsync();
  }

  Future<void> _onInitAsync() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/pecunia.db';

    // Delete the database
    await deleteDatabase(path);

    if (io.File(path).existsSync()) return;

    // open the database
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE ${SQLTableWallets.name} ('
            '${SQLTableWallets.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,'
            '${SQLTableWallets.columnName} TEXT,'
            '${SQLTableWallets.columnCurrency} TEXT,'
            '${SQLTableWallets.columnDescription} TEXT,'
            '${SQLTableWallets.columnShowBalance} BOOLEAN,'
            '${SQLTableWallets.columnRound} BOOLEAN)');
        await db.execute('CREATE TABLE ${SQLTableTransactions.name} ('
            '${SQLTableTransactions.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,'
            '${SQLTableTransactions.columnWalletId} INTEGER,'
            '${SQLTableTransactions.columnAmount} DOUBLE,'
            '${SQLTableTransactions.columnCategory} TEXT)');
      },
    );
  }

  Future<void> walletAdd({required Wallet wallet}) async => await _database.insert(
        SQLTableWallets.name,
        wallet.toJson()..remove("_id"),
      );

  Future<void> walletUpdate({required Wallet wallet}) async => await _database.update(
        SQLTableWallets.name,
        wallet.toJson(),
        where: '${SQLTableWallets.columnId} = ?',
        whereArgs: [wallet.id],
      );

  Future<List<Wallet>> walletList() async {
    List<Map<String, Object?>> maps = await _database.query(
      SQLTableWallets.name,
      columns: [
        SQLTableWallets.columnId,
        SQLTableWallets.columnName,
        SQLTableWallets.columnCurrency,
        SQLTableWallets.columnDescription,
        SQLTableWallets.columnShowBalance,
        SQLTableWallets.columnRound,
      ],
    );

    return List.generate(maps.length, (index) => Wallet.fromJson(maps[index]));
  }
}

class SQLTableWallets {
  SQLTableWallets._();

  static const String name = "wallets";

  static const String columnId = '_id';
  static const String columnName = 'name';
  static const String columnCurrency = 'currency';
  static const String columnDescription = 'description';
  static const String columnShowBalance = 'showBalance';
  static const String columnRound = 'isRoundUp';
}

class SQLTableTransactions {
  SQLTableTransactions._();

  static const name = "transactions";

  static const String columnId = '_id';
  static const String columnWalletId = 'walletId';
  static const String columnAmount = 'amount';
  static const String columnCategory = 'category';
}

bool toBoolean(str) => str != 0 || str != '0' && str != 'false' && str != '';

String fromBoolean(value) => value ? "1" : "0";
