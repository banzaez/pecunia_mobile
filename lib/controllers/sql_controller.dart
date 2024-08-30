import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class SQLController extends BaseController {
  late Database database;

  final tableWallets = "Wallets";
  final tableTransactions = "Transactions";

  @override
  void onInit() {
    super.onInit();

    onInitAsync();
  }

  Future<void> onInitAsync() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/pecunia.db';

    // Delete the database
    await deleteDatabase(path);

    if (io.File(path).existsSync()) return;

    // open the database
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE $tableWallets ('
            'id INTEGER PRIMARY KEY,'
            'name TEXT,'
            'currency TEXT,'
            'description TEXT,'
            'showBalance BOOLEAN,'
            'round BOOLEAN)');
        await db.execute('CREATE TABLE $tableTransactions ('
            'id INTEGER PRIMARY KEY,'
            'walletId INTEGER,'
            'amount DOUBLE,'
            'category TEXT)');
      },
    );
  }

  Future<void> walletAdd({required Wallet wallet}) async => await database.insert(
        tableWallets,
        wallet.toJson() as Map<String, Object?>,
      );

  Future<void> walletUpdate({required Wallet wallet}) async => await database.update(
        tableWallets,
        wallet.toJson() as Map<String, Object?>,
        where: 'id = ?',
        whereArgs: [wallet.id],
      );

  Future<List<Wallet>> walletList(int id) async {
    List<Map> maps = await database.query(tableWallets, columns: [
      "id",
      "name",
      "currency",
      "description",
      "showBalance",
      "round",
    ]);

    return List.generate(
      maps.length,
      (index) => Wallet.fromJson(maps[index] as Map<String, Object?>),
    );
  }
}
