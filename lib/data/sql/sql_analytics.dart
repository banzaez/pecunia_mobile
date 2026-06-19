import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/models/analytics_filter.dart';
import 'package:pecunia/data/sql/sql_table_transactions.dart';
import 'package:pecunia/util/sql_fun.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLAnalytics {
  SQLAnalytics(this._database);

  final sql.Database _database;

  // ----------FILTERS---------------------------------------------------------------------------

  String _filterByAmount(AnalyticsFilter filter) => switch (filter) {
        AnalyticsFilter.income => "AND ${SQLTableTransactions.columnAmount} > 0",
        AnalyticsFilter.expenses => "AND ${SQLTableTransactions.columnAmount} < 0",
        AnalyticsFilter.total => "",
      };

  // ----------QUERY-----------------------------------------------------------------------------

  Future<List<Analytics>> selectByWalletId({
    required int walletId,
    required AnalyticsFilter filter,
    required DateTime startDate,
    required DateTime endDate,
    bool detail = false,
  }) async {
    final categoryColumn = detail
        ? SQLTableTransactions.columnSubCategoryId
        : SQLTableTransactions.columnCategoryId;

    final List<Map<String, Object?>> maps = await _database.rawQuery(
      '''
      SELECT
        $categoryColumn AS category,
        COUNT(${SQLTableTransactions.columnId}) AS count,
        MIN(date(${SQLTableTransactions.columnCreatedAt}, 'start of day')) AS date,
        SUM(${SQLTableTransactions.columnAmount}) AS total
      FROM ${SQLTableTransactions.tableName}
      WHERE ${SQLTableTransactions.columnWalletId} = ?
        AND ${SQLTableTransactions.columnCreatedAt} BETWEEN ? AND ?
        ${_filterByAmount(filter)}
      GROUP BY $categoryColumn
      ORDER BY total DESC
      ''',
      [walletId, fromDateTime(startDate), fromDateTime(endDate)],
    );

    return List.generate(maps.length, (index) => Analytics.fromJson(maps[index]));
  }
}
