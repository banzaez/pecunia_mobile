import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/provider/sql_analytics.dart';
import 'package:pecunia/provider/sql_table_transactions.dart';
import 'package:pecunia/provider/sql_table_wallets.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLProvider {
  late final sql.Database _database;

  late final SQLAnalytics analytics;
  late final SQLTableTransactions transactions;
  late final SQLTableWallets wallets;

  final String _filename = "pecunia.db";
  String get filename => _filename;

  String get databasePath => _database.path;

  bool isLoading = false;

  Future<void> init() async {
    isLoading = true;

    // Get a location using getDatabasesPath
    final dir = await sql.getDatabasesPath();
    final path = '$dir/$filename';

    // // Delete the database
    // await sql.deleteDatabase(path);

    // open the database
    await sql.openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
      },
      onCreate: (sql.Database db, int version) async {
        await db.execute(
          "CREATE TABLE ${SQLTableTransactions.tableName} ("
          "${SQLTableTransactions.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${SQLTableTransactions.columnWalletId} INTEGER NOT NULL,"
          "${SQLTableTransactions.columnAmount} DOUBLE NOT NULL,"
          "${SQLTableTransactions.columnCategoryId} INTEGER NOT NULL,"
          "${SQLTableTransactions.columnSubCategoryId} INTEGER,"
          "${SQLTableTransactions.columnCreatedAt} TEXT DEFAULT CURRENT_TIMESTAMP,"
          "${SQLTableTransactions.columnDescription} TEXT(250) NOT NULL)",
        );

        await db.execute(
          "CREATE TABLE ${SQLTableWallets.tableName} ("
          "${SQLTableWallets.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${SQLTableWallets.columnName} TEXT(100) DEFAULT 'New' NOT NULL,"
          "${SQLTableWallets.columnCategoryId} INTEGER,"
          "${SQLTableWallets.columnCurrency} TEXT(10) DEFAULT 'USD' NOT NULL,"
          "${SQLTableWallets.columnDescription} TEXT(250) DEFAULT '' NOT NULL,"
          "${SQLTableWallets.columnShowBalance} BOOLEAN DEFAULT '1' NOT NULL,"
          "${SQLTableWallets.columnRound} BOOLEAN DEFAULT '1' NOT NULL,"
          "${SQLTableWallets.columnSort} INTEGER DEFAULT '0' NOT NULL)",
        );

        await db.execute(
          "INSERT INTO ${SQLTableWallets.tableName} DEFAULT VALUES",
        );
      },
      onOpen: (db) async {
        _database = db;

        analytics = SQLAnalytics(_database);
        transactions = SQLTableTransactions(_database);
        wallets = SQLTableWallets(_database);

        Get.put(TransactionController());
        Get.put(WalletController());
      },
    );

    isLoading = false;
  }
}
