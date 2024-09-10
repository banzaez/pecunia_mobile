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
        await db.execute("CREATE TABLE ${SQLTableTransactions.tableName} ("
            "${SQLTableTransactions.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${SQLTableTransactions.columnWalletId} INTEGER NOT NULL,"
            "${SQLTableTransactions.columnAmount} DOUBLE NOT NULL,"
            "${SQLTableTransactions.columnCategory} TEXT(100) NOT NULL,"
            "${SQLTableTransactions.columnCategoryId} INTEGER DEFAULT '-1' NOT NULL,"
            "${SQLTableTransactions.columnCreatedAt} TEXT DEFAULT CURRENT_TIMESTAMP,"
            "${SQLTableTransactions.columnDescription} TEXT(512) NOT NULL)");

        await db.execute("CREATE TABLE ${SQLTableWallets.tableName} ("
            "${SQLTableWallets.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,"
            "${SQLTableWallets.columnName} TEXT(100) DEFAULT 'New' NOT NULL,"
            "${SQLTableWallets.columnCurrency} TEXT(10) DEFAULT 'USD' NOT NULL,"
            "${SQLTableWallets.columnDescription} TEXT(250) DEFAULT '' NOT NULL,"
            "${SQLTableWallets.columnShowBalance} BOOLEAN DEFAULT '1' NOT NULL,"
            "${SQLTableWallets.columnRound} BOOLEAN DEFAULT '1' NOT NULL,"
            "${SQLTableWallets.columnSort} INTEGER DEFAULT '0' NOT NULL)");

        await db.execute("INSERT INTO ${SQLTableWallets.tableName} DEFAULT VALUES");
      },
      onConfigure: (db) {},
      onOpen: (db) async {
        await addColumnIfNotExists(
          db,
          SQLTableTransactions.tableName,
          SQLTableTransactions.columnCategoryId,
          "INTEGER DEFAULT '-1' NOT NULL",
        );

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

  Future<void> addColumnIfNotExists(
    sql.Database db,
    String tableName,
    String columnName,
    String columnType,
  ) async {
    try {
      final alterTableQuery = "ALTER TABLE $tableName ADD COLUMN $columnName $columnType";
      db.execute(alterTableQuery);
    } catch (e) {}
  }

  Future<void> addTableIfNotExists(
    sql.Database db,
    String tableName,
  ) async {
    final columnExistsQuery = "SELECT * FROM sqlite_master WHERE name=$tableName";
    final columns = await db.execute(columnExistsQuery);

    // final columnNames = columns.map((row) => row['name'] as String).toSet();
    //
    // if (!columnNames.contains(columnName)) {
    //   final alterTableQuery = "ALTER TABLE $tableName ADD COLUMN $columnName $columnType";
    //   db.execute(alterTableQuery);
    //   print('Column "$columnName" added to table "$tableName".');
    // } else {
    //   print('Column "$columnName" already exists in table "$tableName".');
    // }
  }
}
