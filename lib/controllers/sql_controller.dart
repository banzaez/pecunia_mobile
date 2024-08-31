import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLController extends BaseController {
  late final sql.Database _database;
  late final _SQLTableWallets tableWallets;

  Future<void> initAsync() async {
    isLoading = true;

    // Get a location using getDatabasesPath
    var databasesPath = await sql.getDatabasesPath();
    String path = '$databasesPath/pecunia.db';

    // // Delete the database
    // await deleteDatabase(path);

    // open the database
    await sql.openDatabase(
      path,
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await db.execute('CREATE TABLE ${_SQLTableWallets.table} ('
            '${_SQLTableWallets.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,'
            '${_SQLTableWallets.columnName} TEXT,'
            '${_SQLTableWallets.columnCurrency} TEXT,'
            '${_SQLTableWallets.columnDescription} TEXT,'
            '${_SQLTableWallets.columnShowBalance} BOOLEAN,'
            '${_SQLTableWallets.columnRound} BOOLEAN)');
        await db.execute('CREATE TABLE ${_SQLTableTransactions.table} ('
            '${_SQLTableTransactions.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,'
            '${_SQLTableTransactions.columnWalletId} INTEGER,'
            '${_SQLTableTransactions.columnAmount} DOUBLE,'
            '${_SQLTableTransactions.columnCategory} TEXT)');
      },
      onConfigure: (db) {
        _database = db;

        tableWallets = _SQLTableWallets(_database);

        Get.put(WalletController());
      },
    );

    isLoading = false;
  }
}

class _SQLTableWallets {
  _SQLTableWallets(this._database);

  final sql.Database _database;

  static const String table = "wallets";

  static const String columnId = '_id';
  static const String columnName = 'name';
  static const String columnCurrency = 'currency';
  static const String columnDescription = 'description';
  static const String columnShowBalance = 'showBalance';
  static const String columnRound = 'isRoundUp';

  Future<void> add({required Wallet wallet}) async => await _database.insert(
        table,
        wallet.toJson()..remove("_id"),
      );

  Future<void> update({required Wallet wallet}) async => await _database.update(
        table,
        wallet.toJson(),
        where: '$columnId = ?',
        whereArgs: [wallet.id],
      );

  Future<void> delete({required int id}) async => await _database.delete(
        table,
        where: '$columnId = ?',
        whereArgs: [id],
      );

  Future<List<Wallet>> getList() async {
    List<Map<String, Object?>> maps = await _database.query(
      table,
      columns: [
        columnId,
        columnName,
        columnCurrency,
        columnDescription,
        columnShowBalance,
        columnRound,
      ],
    );

    return List.generate(maps.length, (index) => Wallet.fromJson(maps[index]));
  }
}

abstract class _SQLTableTransactions {
  static const table = "transactions";

  static const String columnId = '_id';
  static const String columnWalletId = 'walletId';
  static const String columnAmount = 'amount';
  static const String columnCategory = 'category';
}

bool toBoolean(str) => str != 0 || str != '0' && str != 'false' && str != '';

String fromBoolean(value) => value ? "1" : "0";
