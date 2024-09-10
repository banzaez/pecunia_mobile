import 'package:pecunia/models/transaction.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLTableTransactions {
  SQLTableTransactions(this._database);

  final sql.Database _database;

  static const tableName = "transactions";

  static const String columnId = '_id';
  static const String columnWalletId = 'wallet_id';
  static const String columnAmount = 'amount';
  static const String columnCategory = 'category';
  static const String columnCategoryId = 'category_id';
  static const String columnCreatedAt = 'created_at';
  static const String columnDescription = 'description';

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

  Future<List<Transaction>> selectAllByWalletId(int walletId) async {
    List<Map<String, Object?>> maps = await _database.query(
      tableName,
      columns: null,
      where: "$columnWalletId = ?",
      whereArgs: [walletId],
      orderBy: "$columnCreatedAt DESC",
    );

    return List.generate(maps.length, (index) => Transaction.fromJson(maps[index]));
  }
}
