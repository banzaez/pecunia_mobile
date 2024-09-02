import 'package:pecunia/models/analytics.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLAnalytics {
  SQLAnalytics(this._database);

  final sql.Database _database;

  Future<List<Analytics>> analyticsById(int walletId, String formatDate) async {
    final maps = await _database.rawQuery("with preresult as ("
        "SELECT "
        "strftime('%Y', created_at) as date_group, "
        "created_at as date, "
        "amount FROM transactions "
        "WHERE wallet_id = 1)"
        ""
        "SELECT "
        "date_group as 'group', "
        "MIN(date) as date, "
        "SUM(amount) as amount "
        "FROM preresult "
        "GROUP BY date_group "
        "ORDER BY date_group DESC"
    );

    return List.generate(maps.length, (index) => Analytics.fromJson(maps[index]));
  }

  Future<List<Analytics>> analyticsCategoryById(int walletId, String formatDate) async {
    final maps = await _database.rawQuery("with preresult as ("
        "SELECT "
        "strftime('%Y', created_at) as date_group, "
        "created_at as date, category, "
        "amount FROM transactions "
        "WHERE wallet_id = 1)"
        ""
        "SELECT date_group as 'group', "
        "category, "
        "date, "
        "SUM(amount) as amount "
        "FROM preresult "
        "GROUP BY date_group, category "
        "ORDER BY date_group DESC"
    );

    return List.generate(maps.length, (index) => Analytics.fromJson(maps[index]));
  }

  Future<List<List<Analytics>>> analytics(int walletId) async {
    final results = await Future.wait([
      analyticsById(walletId, "%Y"),
      analyticsCategoryById(walletId, "%Y"),
      analyticsById(walletId, "%m"),
      analyticsCategoryById(walletId, "%Y"),
      analyticsById(walletId, "%d"),
      analyticsCategoryById(walletId, "%Y"),
    ]);

    return results;
  }
}