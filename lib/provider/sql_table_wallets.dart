import 'package:pecunia/models/wallet.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLTableWallets {
  SQLTableWallets(this._database);

  final sql.Database _database;

  static const String tableName = "wallets";

  static const String columnId = '_id';
  static const String columnName = 'name';
  static const String columnCategoryId = 'category_id';
  static const String columnCurrency = 'currency';
  static const String columnDescription = 'description';
  static const String columnShowBalance = 'showBalance';
  static const String columnRound = 'isRoundUp';
  static const String columnSort = 'sort';

  Future<void> add({required Wallet value}) async => await _database.insert(
    tableName,
    value.toJson()..remove("_id"),
  );

  Future<void> update({required Wallet value}) async => await _database.update(
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

  Future<List<Wallet>> selectAll() async {
    List<Map<String, Object?>> maps = await _database.query(
      tableName,
      columns: null,
    );

    return maps.map((e) => Wallet.fromJson(e)).toList();
  }
}