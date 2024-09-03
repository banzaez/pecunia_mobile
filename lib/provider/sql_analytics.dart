import 'package:get/get.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLAnalytics {
  SQLAnalytics(this._database);

  final sql.Database _database;

  // ----------FILTERS---------------------------------------------------------------------------

  String _filterByAmount(AnalyticsFilter filter, String operator) => switch (filter) {
        AnalyticsFilter.income => "$operator amount > 0",
        AnalyticsFilter.expenses => "$operator amount < 0",
        AnalyticsFilter.total => "",
      };

  // ----------QUERY-----------------------------------------------------------------------------

  String _preQuery(
    int walletId,
    String formatDate,
    AnalyticsFilter filter,
  ) =>
      "with preresult as ("
      "SELECT "
      "_id as id, "
      "strftime('$formatDate', created_at) as date_group, "
      "date(created_at, 'start of day') as date, "
      "category, "
      "amount "
      "FROM transactions "
      "WHERE wallet_id = $walletId ${_filterByAmount(filter, "AND")})";

  // --------------------------------------------------------------------------------------------

  Future<List<Analytics>> queryById(
    int walletId,
    String formatDate,
    AnalyticsFilter filter,
  ) async {
    final maps = await _database.rawQuery(""
        "${_preQuery(walletId, formatDate, filter)}"
        ""
        "SELECT "
        "date_group as 'group', "
        "MIN(date) as date, "
        "COUNT(id) as id, "
        "SUM(amount) as amount "
        "FROM preresult "
        "GROUP BY date_group "
        "ORDER BY date_group DESC");

    return List.generate(maps.length, (index) => Analytics.fromJson(maps[index]));
  }

  Future<List<Analytics>> queryCategoryById(
    int walletId,
    String formatDate,
    AnalyticsFilter filter,
  ) async {
    final maps = await _database.rawQuery(""
        "${_preQuery(walletId, formatDate, filter)}"
        ""
        "SELECT date_group as 'group', "
        "category, "
        "date, "
        "COUNT(id) as id, "
        "SUM(amount) as amount "
        "FROM preresult "
        "GROUP BY date_group, category "
        "ORDER BY SUM(amount)");

    return List.generate(maps.length, (index) => Analytics.fromJson(maps[index]));
  }

  // --------------------------------------------------------------------------------------------

  Future<List<List<Analytics>>> allAnalytics({
    required int walletId,
    required AnalyticsFilter filter,
  }) async {
    final results = await Future.wait([
      queryById(walletId, "%Y", filter),
      queryCategoryById(walletId, "%Y", filter),
      queryById(walletId, "%Y%m", filter),
      queryCategoryById(walletId, "%Y%m", filter),
      queryById(walletId, "%Y%m%d", filter),
      queryCategoryById(walletId, "%Y%m%d", filter),
    ]);

    return results;
  }
}

enum AnalyticsPeriod {
  year,
  month,
  day,
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
