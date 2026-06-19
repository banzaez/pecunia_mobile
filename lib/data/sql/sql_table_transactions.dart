import 'package:pecunia/models/analytics_total.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/sql_fun.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLTableTransactions {
  SQLTableTransactions(this._database);

  final sql.Database _database;

  static const tableName = "transactions";

  static const String columnId = '_id';
  static const String columnWalletId = 'wallet_id';
  static const String columnAmount = 'amount';
  static const String columnCategoryId = 'category_id';
  static const String columnSubCategoryId = 'subcategory_id';
  static const String columnCreatedAt = 'created_at';
  static const String columnDescription = 'description';

  // ----------CRUD-----------------------------------------------------------------------------

  Future<void> add({required Transaction value}) async => await _database.insert(
        tableName,
        value.toJson()..remove("_id"),
      );

  Future<void> addBatch({required List<Transaction> values}) async {
    await _database.transaction((txn) async {
      for (final value in values) {
        await txn.insert(tableName, value.toJson()..remove("_id"));
      }
    });
  }

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

  // ----------QUERY-----------------------------------------------------------------------------

  Future<List<Transaction>> selectByWalletId(
    int walletId, {
    int? limit,
    int? offset,
  }) async {
    List<Map<String, Object?>> result = await _database.query(
      tableName,
      columns: null,
      where: "$columnWalletId = ?",
      whereArgs: [walletId],
      orderBy: "$columnCreatedAt DESC",
      limit: limit,
      offset: offset,
    );

    return result.map((e) => Transaction.fromJson(e)).toList();
  }

  Future<int> countByWalletId(int walletId) async {
    final result = await _database.rawQuery(
      'SELECT COUNT(*) AS count FROM $tableName WHERE $columnWalletId = ?',
      [walletId],
    );
    return (result.first['count'] as int?) ?? 0;
  }

  Future<List<Transaction>> selectByWalletIdAndCategoryAndByPeriod(
    int walletId,
    int categoryId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    List<Map<String, Object?>> result = await _database.query(
      tableName,
      columns: null,
      where: "$columnWalletId = ? AND ($columnCategoryId = ? OR $columnSubCategoryId = ?) AND $columnCreatedAt BETWEEN ? AND ?",
      whereArgs: [walletId, categoryId, categoryId, fromDateTime(startDate), fromDateTime(endDate)],
      orderBy: "$columnCreatedAt DESC",
    );

    return result.map((e) => Transaction.fromJson(e)).toList();
  }

  // ----------AVAILABLE DATES------------------------------------------------------------------

  Future<List<int>> availableYears(int walletId) async {
    final result = await _database.rawQuery(
      "SELECT DISTINCT CAST(strftime('%Y', $columnCreatedAt) AS INTEGER) AS y "
      "FROM $tableName WHERE $columnWalletId = ? ORDER BY y DESC",
      [walletId],
    );
    return result.map((r) => r['y'] as int).toList();
  }

  Future<List<int>> availableMonths(int walletId, int year) async {
    final result = await _database.rawQuery(
      "SELECT DISTINCT CAST(strftime('%m', $columnCreatedAt) AS INTEGER) AS m "
      "FROM $tableName WHERE $columnWalletId = ? "
      "AND CAST(strftime('%Y', $columnCreatedAt) AS INTEGER) = ? ORDER BY m",
      [walletId, year],
    );
    return result.map((r) => r['m'] as int).toList();
  }

  Future<List<int>> availableDays(int walletId, int year, int month) async {
    final paddedMonth = month.toString().padLeft(2, '0');
    final result = await _database.rawQuery(
      "SELECT DISTINCT CAST(strftime('%d', $columnCreatedAt) AS INTEGER) AS d "
      "FROM $tableName WHERE $columnWalletId = ? "
      "AND strftime('%Y-%m', $columnCreatedAt) = ? ORDER BY d",
      [walletId, '$year-$paddedMonth'],
    );
    return result.map((r) => r['d'] as int).toList();
  }

  // --------------------------------------------------------------------------------------------

  Future<AnalyticsTotal> selectTotalByWallet(int walletId) async {
    final now = DateTime.now();
    final startDate = fromDateTime(now.startOfMonth);
    final endDate = fromDateTime(now.endOfMonth);

    final List<Map<String, Object?>> result = await _database.rawQuery(
      '''
      SELECT
        SUM($columnAmount) AS total,
        SUM(CASE WHEN $columnAmount > 0 AND $columnCreatedAt BETWEEN ? AND ?
            THEN $columnAmount ELSE 0 END) AS income,
        SUM(CASE WHEN $columnAmount < 0 AND $columnCreatedAt BETWEEN ? AND ?
            THEN $columnAmount ELSE 0 END) AS expense
      FROM $tableName
      WHERE $columnWalletId = ?
      ''',
      [startDate, endDate, startDate, endDate, walletId],
    );

    return result.isEmpty ? AnalyticsTotal(0, 0, 0) : AnalyticsTotal.fromJson(result.first);
  }
}
