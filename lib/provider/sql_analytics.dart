import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/models/analytics_filter.dart';
import 'package:pecunia/provider/sql_table_transactions.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLAnalytics {
  SQLAnalytics(this._database);

  final sql.Database _database;

  // ----------FILTERS---------------------------------------------------------------------------

  String _filterByAmount(AnalyticsFilter filter, String operator) => switch (filter) {
        AnalyticsFilter.income => "$operator ${SQLTableTransactions.columnAmount} > 0",
        AnalyticsFilter.expenses => "$operator ${SQLTableTransactions.columnAmount} < 0",
        AnalyticsFilter.total => "",
      };

  // ----------QUERY-----------------------------------------------------------------------------

  Future<List<Analytics>> selectByWalletId(
    int walletId,
    AnalyticsFilter filter, [
    bool detail = false,
  ]) async {
    final categoryColumn = detail
        ? SQLTableTransactions.columnSubCategoryId
        : SQLTableTransactions.columnCategoryId;

    final List<Map<String, Object?>> maps = await _database.query(
      SQLTableTransactions.tableName,
      columns: [
        "$categoryColumn AS category",
        "strftime('%Y', ${SQLTableTransactions.columnCreatedAt}) AS year",
        "strftime('%m', ${SQLTableTransactions.columnCreatedAt}) AS month",
        "strftime('%d', ${SQLTableTransactions.columnCreatedAt}) AS day",
        "COUNT(${SQLTableTransactions.columnId}) AS count",
        "MIN(date(${SQLTableTransactions.columnCreatedAt}, 'start of day')) AS date",
        "SUM(${SQLTableTransactions.columnAmount}) AS total",
      ],
      where: "${SQLTableTransactions.columnWalletId} = ? ${_filterByAmount(filter, "AND")}",
      whereArgs: [walletId],
      groupBy: categoryColumn,
      orderBy: "category DESC",
    );

    return List.generate(maps.length, (index) => Analytics.fromJson(maps[index]));
  }

  // --------------------------------------------------------------------------------------------

  Future<List<Analytics>> allAnalytics({
    required int walletId,
    required AnalyticsFilter filter,
    required bool detail,
  }) async =>
      await selectByWalletId(walletId, filter, detail);
}
