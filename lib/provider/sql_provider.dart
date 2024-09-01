import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLProvider {
  late final sql.Database _database;

  late final _SQLTableWallets wallets;
  late final _SQLTableTransactions transactions;

  bool isLoading = false;

  Future<void> initAsync() async {
    isLoading = true;

    // Get a location using getDatabasesPath
    var databasesPath = await sql.getDatabasesPath();
    String path = '$databasesPath/pecunia.db';

    // // Delete the database
    // await sql.deleteDatabase(path);

    // open the database
    await sql.openDatabase(
      path,
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await db.execute("CREATE TABLE ${_SQLTableWallets.tableName} ("
            "${_SQLTableWallets.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${_SQLTableWallets.columnName} TEXT(100) DEFAULT 'New' NOT NULL,"
            "${_SQLTableWallets.columnCurrency} TEXT(10) DEFAULT 'USD' NOT NULL,"
            "${_SQLTableWallets.columnDescription} TEXT(250) DEFAULT '' NOT NULL,"
            "${_SQLTableWallets.columnShowBalance} BOOLEAN DEFAULT '1' NOT NULL,"
            "${_SQLTableWallets.columnRound} BOOLEAN DEFAULT '1' NOT NULL,"
            "${_SQLTableWallets.columnSort} INTEGER DEFAULT '0' NOT NULL)");

        await db.execute("CREATE TABLE ${_SQLTableTransactions.tableName} ("
            "${_SQLTableTransactions.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${_SQLTableTransactions.columnWalletId} INTEGER NOT NULL,"
            "${_SQLTableTransactions.columnAmount} DOUBLE NOT NULL,"
            "${_SQLTableTransactions.columnCategory} TEXT(100) NOT NULL,"
            "${_SQLTableTransactions.columnCreatedAt} TEXT DEFAULT CURRENT_TIMESTAMP)");

        await db.execute("INSERT INTO ${_SQLTableWallets.tableName} DEFAULT VALUES");
      },
      onOpen: (db) {
        _database = db;

        wallets = _SQLTableWallets(_database);
        transactions = _SQLTableTransactions(_database);

        Get.put(TransactionController());
        Get.put(WalletController());
      },
    );

    isLoading = false;
  }
}

class _SQLTableWallets {
  _SQLTableWallets(this._database);

  final sql.Database _database;

  static const String tableName = "wallets";

  static const String columnId = '_id';
  static const String columnName = 'name';
  static const String columnCurrency = 'currency';
  static const String columnDescription = 'description';
  static const String columnShowBalance = 'showBalance';
  static const String columnRound = 'isRoundUp';
  static const String columnSort = 'sort';

  Future<void> add({required Wallet value}) async => await _database.insert(
        tableName,
        value.toJson()..remove("_id"),
      );

  Future<void> update({required Wallet value}) async => await _database.update(
        tableName,
        value.toJson(),
        where: '$columnId = ?',
        whereArgs: [value.id],
      );

  Future<void> delete({required int id}) async => await _database.delete(
        tableName,
        where: '$columnId = ?',
        whereArgs: [id],
      );

  Future<List<Wallet>> selectAll() async {
    List<Map<String, Object?>> maps = await _database.query(
      tableName,
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

class _SQLTableTransactions {
  _SQLTableTransactions(this._database);

  final sql.Database _database;

  static const tableName = "transactions";

  static const String columnId = '_id';
  static const String columnWalletId = 'wallet_id';
  static const String columnAmount = 'amount';
  static const String columnCategory = 'category';
  static const String columnCreatedAt = 'created_at';

  Future<void> add({required Transaction value}) async => await _database.insert(
        tableName,
        value.toJson()..remove("_id"),
      );

  Future<void> update({required Transaction value}) async => await _database.update(
        tableName,
        value.toJson(),
        where: '$columnId = ?',
        whereArgs: [value.id],
      );

  Future<void> delete({required int id}) async => await _database.delete(
        tableName,
        where: '$columnId = ?',
        whereArgs: [id],
      );

  Future<List<Transaction>> selectAllByWalletId(int walletId) async {
    List<Map<String, Object?>> maps = await _database.query(
      tableName,
      columns: [
        columnId,
        columnWalletId,
        columnAmount,
        columnCategory,
        columnCreatedAt,
      ],
      where: "$columnWalletId = ?",
      whereArgs: [walletId],
      orderBy: "$columnCreatedAt DESC",
    );

    return List.generate(maps.length, (index) => Transaction.fromJson(maps[index]));
  }
}
