import 'package:pecunia/data/sql/sql_analytics.dart';
import 'package:pecunia/data/sql/sql_table_transactions.dart';
import 'package:pecunia/data/sql/sql_table_wallets.dart';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart' as sql;

class SQLProvider {
  late sql.Database _database;
  sql.Database get database => _database;

  late SQLAnalytics analytics;
  late SQLTableTransactions transactions;
  late SQLTableWallets wallets;

  late String _databasePath;
  String get databasePath => _databasePath;

  final String _filename = "pecunia.db";
  String get filename => _filename;

  bool isLoading = false;

  Future<void> init() async {
    isLoading = true;

    // Get a location using getDatabasesPath
    final dir = await sql.getDatabasesPath();
    _databasePath = '$dir/$filename';

    // // Delete the database
    // await sql.deleteDatabase(path);

    // open the database
    final db = await sql.openDatabase(
      _databasePath,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (sql.Database db, int version) async {
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
          "CREATE TABLE ${SQLTableTransactions.tableName} ("
          "${SQLTableTransactions.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${SQLTableTransactions.columnWalletId} INTEGER NOT NULL REFERENCES ${SQLTableWallets.tableName}(${SQLTableWallets.columnId}) ON DELETE CASCADE,"
          "${SQLTableTransactions.columnAmount} DOUBLE NOT NULL,"
          "${SQLTableTransactions.columnCategoryId} INTEGER NOT NULL,"
          "${SQLTableTransactions.columnSubCategoryId} INTEGER,"
          "${SQLTableTransactions.columnCreatedAt} TEXT DEFAULT CURRENT_TIMESTAMP,"
          "${SQLTableTransactions.columnDescription} TEXT(250) NOT NULL)",
        );

        await db.execute(
          "CREATE INDEX idx_transactions_wallet_id "
          "ON ${SQLTableTransactions.tableName} (${SQLTableTransactions.columnWalletId})",
        );

        await db.execute(
          "CREATE INDEX idx_transactions_created_at "
          "ON ${SQLTableTransactions.tableName} (${SQLTableTransactions.columnCreatedAt})",
        );

        await db.execute(
          "INSERT INTO ${SQLTableWallets.tableName} DEFAULT VALUES",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Example: if (oldVersion < 2) { await db.execute('ALTER TABLE ...'); }
      },
    );

    _database = db;
    analytics = SQLAnalytics(_database);
    transactions = SQLTableTransactions(_database);
    wallets = SQLTableWallets(_database);

    isLoading = false;
  }

  Future<void> close() async {
    await _database.close();
  }

  Future<String> createBackupSnapshot() async {
    final tempDir = await io.Directory.systemTemp.createTemp('pecunia_backup');
    final backupPath = '${tempDir.path}/backup_export.db';
    await _database.execute("VACUUM INTO '$backupPath'");
    return backupPath;
  }
}
