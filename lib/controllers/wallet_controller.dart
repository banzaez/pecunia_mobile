import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/provider/sql_provider.dart';

class WalletController extends BaseController {
  final SQLProvider _sqlController = Get.find();

  final RxList<Wallet> wallets = RxList();

  final List<Function(String type)> _listeners = [];

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    onInitAsync();
  }

  void onInitAsync() async {
    await refreshWallets();
    notifyListenersSQL("init");
  }

  // -----------LISTENERS-SQL--------------------------------------------------------------------

  void addListenerSQL(Function(String type) listener) => _listeners.add(listener);

  void notifyListenersSQL(String type) {
    for(var listener in _listeners) {
      listener.call(type);
    }
  }

  // -----------SQL------------------------------------------------------------------------------

  Future<void> addSQL(Wallet wallet) async {
    await _sqlController.tableWallets.add(value: wallet);
    await refreshWallets();
    notifyListenersSQL("add");
  }

  Future<void> updateSQL(Wallet wallet) async {
    await _sqlController.tableWallets.update(value: wallet);
    await refreshWallets();
    notifyListenersSQL("update");
  }

  Future<void> deleteSQL(int id) async {
    if(wallets.length == 1) return;
    await _sqlController.tableWallets.delete(id: id);
    await refreshWallets();
    notifyListenersSQL("delete");
  }

  Future<void> refreshWallets() async =>
      wallets.value = await _sqlController.tableWallets.selectAll();
}
