import 'package:pecunia/data/sql/sql_migrations.dart';
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

    final dir = await sql.getDatabasesPath();
    _databasePath = '$dir/$filename';

    final db = await sql.openDatabase(
      _databasePath,
      version: SqlMigrations.currentVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, _) => SqlMigrations.onCreate(db),
      onUpgrade: SqlMigrations.onUpgrade,
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
