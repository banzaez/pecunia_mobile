import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/provider/sql_provider.dart';

class TransactionController extends BaseController {
  final SQLProvider _sqlProvider = Get.find();

  final RxInt _walletId = RxInt(0);

  int get walletId => _walletId.value;
  set walletId(int id) {
    _walletId.value = id;
    refreshTransactions();
  }

  final RxList<Transaction> transactions = RxList();

  final List<Function(String type)> _listeners = [];

  // -----------LISTENERS-SQL--------------------------------------------------------------------

  void addListenerSQL(Function(String type) listener) => _listeners.add(listener);

  void notifyListenersSQL(String type) {
    for (var listener in _listeners) {
      listener.call(type);
    }
  }

  // -----------SQL------------------------------------------------------------------------------

  Future<void> addSQL(Transaction transaction) async {
    transaction.id = _walletId.value;
    await _sqlProvider.tableTransactions.add(value: transaction);
    await refreshTransactions();
    notifyListenersSQL("add");
  }

  Future<void> updateSQL(Transaction transaction) async {
    transaction.id = _walletId.value;
    await _sqlProvider.tableTransactions.update(value: transaction);
    await refreshTransactions();
    notifyListenersSQL("add");
  }

  Future<void> deleteSQL(int id) async {
    await _sqlProvider.tableTransactions.delete(id: id);
    await refreshTransactions();
    notifyListenersSQL("add");
  }

  Future<void> refreshTransactions() async => transactions.value =
      await _sqlProvider.tableTransactions.selectAllByWalletId(_walletId.value);
}
