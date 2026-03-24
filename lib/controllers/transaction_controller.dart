import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/models/analytics_total.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/provider/sql_provider.dart';

class TransactionController extends BaseController {
  final SQLProvider _sqlProvider = Get.find();

  final RxInt _walletId = RxInt(0);

  int get walletId => _walletId.value;

  Future<void> changeWallet(int id) async {
    _walletId.value = id;
    await refreshAll();
  }

  final Rx<AnalyticsTotal> analyticsTotal = AnalyticsTotal(0, 0, 0).obs;

  final RxList<Transaction> transactions = <Transaction>[].obs;

  // -----------SQL------------------------------------------------------------------------------

  Future<void> refreshAll() async {
    isLoading = true;
    error = null;
    try {
      await Future.wait([refreshTransactions(), refreshTotal()]);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> refreshTransactions() async =>
      transactions.assignAll(await _sqlProvider.transactions.selectByWalletId(_walletId.value));

  Future<void> refreshTotal() async =>
      analyticsTotal.value = await _sqlProvider.transactions.selectTotalByWallet(_walletId.value);

  Future<void> addSQL(Transaction transaction) async {
    isLoading = true;
    error = null;
    try {
      if (transaction.walletId == 0) transaction.walletId = _walletId.value;
      await _sqlProvider.transactions.add(value: transaction);
      await refreshAll();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> updateSQL(Transaction transaction) async {
    isLoading = true;
    error = null;
    try {
      if (transaction.walletId == 0) transaction.walletId = _walletId.value;
      await _sqlProvider.transactions.update(value: transaction);
      await refreshAll();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteSQL(int id) async {
    isLoading = true;
    error = null;
    try {
      await _sqlProvider.transactions.delete(id: id);
      await refreshAll();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> addTransferSQL(Transaction from, Transaction to) async {
    isLoading = true;
    error = null;
    try {
      await _sqlProvider.transactions.addBatch(values: [from, to]);
      await refreshAll();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
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
