import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/models/analytics_total.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/provider/sql_provider.dart';

class TransactionController extends BaseController {
  final SQLProvider _sqlProvider = Get.find();

  final RxInt _walletId = RxInt(0);

  int get walletId => _walletId.value;

  set walletId(int id) {
    _walletId.value = id;
    _refresh();
  }

  final Rx<AnalyticsTotal> analyticsTotal = AnalyticsTotal(0, 0, 0).obs;

  final RxList<Transaction> transactions = RxList();

  // -----------SQL------------------------------------------------------------------------------

  Future<void> _refresh() =>
      Future.wait([refreshTransactions(), refreshTotal()]);

  Future<void> refreshTransactions() async =>
      transactions.value = await _sqlProvider.transactions.selectByWalletId(_walletId.value);

  Future<void> refreshTotal() async =>
      analyticsTotal.value = await _sqlProvider.transactions.selectTotalByWallet(_walletId.value);

  Future<void> addSQL(Transaction transaction) async {
    if (transaction.walletId == 0) transaction.walletId = _walletId.value;
    await _sqlProvider.transactions.add(value: transaction);
    await _refresh();
  }

  Future<void> updateSQL(Transaction transaction) async {
    if (transaction.walletId == 0) transaction.walletId = _walletId.value;
    await _sqlProvider.transactions.update(value: transaction);
    await _refresh();
  }

  Future<void> deleteSQL(int id) async {
    await _sqlProvider.transactions.delete(id: id);
    await _refresh();
  }

  Future<void> addTransferSQL(Transaction from, Transaction to) async {
    await _sqlProvider.transactions.addBatch(values: [from, to]);
    await _refresh();
  }

  Future<List<Transaction>> selectByWalletIdAndCategoryAndByPeriod(
    int walletId,
    int categoryId,
    DateTime startDate,
    DateTime endDate,
  ) async =>
      await _sqlProvider.transactions.selectByWalletIdAndCategoryAndByPeriod(
        walletId,
        categoryId,
        startDate,
        endDate,
      );
}
