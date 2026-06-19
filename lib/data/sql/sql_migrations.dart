import 'package:sqflite/sqflite.dart' as sql;

import 'package:pecunia/data/sql/sql_table_transactions.dart';
import 'package:pecunia/data/sql/sql_table_wallets.dart';

/// Текущая версия схемы БД. При изменении схемы увеличить и добавить шаг в [_migrateTo].
abstract final class SqlMigrations {
  static const int currentVersion = 1;

  static Future<void> onCreate(sql.Database db) async {
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
  }

  static Future<void> onUpgrade(
    sql.Database db,
    int oldVersion,
    int newVersion,
  ) async {
    for (var version = oldVersion + 1; version <= newVersion; version++) {
      await _migrateTo(db, version);
    }
  }

  static Future<void> _migrateTo(sql.Database db, int version) async {
    switch (version) {
      case 1:
        break;
      // case 2:
      //   await db.execute('ALTER TABLE ...');
    }
  }
}
