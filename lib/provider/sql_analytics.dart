import 'package:pecunia/models/analytics.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLAnalytics {
  SQLAnalytics(this._database);

  final sql.Database _database;

  Future<List<Analytics>> analyticsById(int walletId, String formatDate) async {
    final maps = await _database.rawQuery("with preresult as ("
        "SELECT "
        "_id as id, "
        "strftime('$formatDate', created_at) as date_group, "
        "date(created_at, 'start of day') as date, "
        "amount FROM transactions "
        "WHERE wallet_id = $walletId)"
        ""
        "SELECT "
        "date_group as 'group', "
        "MIN(date) as date, "
        "COUNT(id) as id, "
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
        "_id as id, "
        "strftime('$formatDate', created_at) as date_group, "
        "date(created_at, 'start of day') as date, "
        "category, "
        "amount FROM transactions "
        "WHERE wallet_id = $walletId)"
        ""
        "SELECT date_group as 'group', "
        "category, "
        "date, "
        "COUNT(id) as id, "
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
      analyticsCategoryById(walletId, "%m"),
      analyticsById(walletId, "%d"),
      analyticsCategoryById(walletId, "%d"),
    ]);

    return results;
  }
}