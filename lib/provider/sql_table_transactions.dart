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

  Future<List<Transaction>> selectByWalletId(int walletId) async {
    List<Map<String, Object?>> result = await _database.query(
      tableName,
      columns: null,
      where: "$columnWalletId = ?",
      whereArgs: [walletId],
      orderBy: "$columnCreatedAt DESC",
    );

    return List.generate(result.length, (index) => Transaction.fromJson(result[index]));
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
      where: "$columnWalletId = ? AND $columnCategoryId = ? AND $columnCreatedAt BETWEEN ? AND ?",
      whereArgs: [walletId, categoryId, fromDateTime(startDate), fromDateTime(endDate)],
      orderBy: "$columnCreatedAt DESC",
    );

    return List.generate(result.length, (index) => Transaction.fromJson(result[index]));
  }

  Future<AnalyticsTotal> selectTotalByWallet(int walletId) async {
    final startDate = fromDateTime(DateTime.now().startOfMonth);
    final endDate = fromDateTime(DateTime.now().endOfMonth);

    List<Map<String, Object?>> result = await _database.query(
      tableName,
      columns: [
        "SUM($columnAmount) AS total",
        "SUM(CASE WHEN $columnAmount > 0 AND $columnCreatedAt BETWEEN '$startDate' AND '$endDate' THEN $columnAmount ELSE 0 END) AS income",
        "SUM(CASE WHEN $columnAmount < 0 AND $columnCreatedAt BETWEEN '$startDate' AND '$endDate' THEN $columnAmount ELSE 0 END) AS expense",
      ],
      where: "$columnWalletId = ?",
      whereArgs: [walletId],
    );

    return result.isEmpty ? AnalyticsTotal(0, 0, 0) : AnalyticsTotal.fromJson(result.first);
  }
}
