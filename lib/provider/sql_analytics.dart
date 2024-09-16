import 'package:get/get.dart';
import 'package:pecunia/models/analytics.dart';
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
    String formatDate,
    AnalyticsFilter filter, [
    bool detail = false,
  ]) async {
    List<Map<String, Object?>> maps = await _database.query(
      SQLTableTransactions.tableName,
      columns: [
        "${detail ? SQLTableTransactions.columnSubCategoryId : SQLTableTransactions.columnCategoryId} AS category",
        "strftime('$formatDate', ${SQLTableTransactions.columnCreatedAt}) AS year",
        "strftime('$formatDate', ${SQLTableTransactions.columnCreatedAt}) AS month",
        "strftime('$formatDate', ${SQLTableTransactions.columnCreatedAt}) AS day",
        "COUNT(${SQLTableTransactions.columnId}) AS count",
        "MIN(date(${SQLTableTransactions.columnCreatedAt}, 'start of day')) AS date",
        "SUM(${SQLTableTransactions.columnAmount}) AS total",
      ],
      where: "${SQLTableTransactions.columnWalletId} = ? ${_filterByAmount(filter, "AND")}",
      whereArgs: [walletId],
      groupBy: "category_id",
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
      await selectByWalletId(walletId, "%Y", filter, detail);
}

enum AnalyticsFilter {
  income,
  expenses,
  total;

  String get label => switch (this) {
        income => "analytics_income".tr,
        expenses => "analytics_expenses".tr,
        total => "analytics_total".tr,
      };
}
