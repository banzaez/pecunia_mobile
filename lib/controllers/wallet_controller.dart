import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/provider/sql_provider.dart';

class WalletController extends BaseController {
  final SQLProvider _sqlController = Get.find();

  final RxList<Wallet> wallets = RxList();

  final RxBool isEditing = RxBool(false);

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();
    _loadWallets();
  }

  Future<void> _loadWallets() => refreshWallets();

  // -----------SQL------------------------------------------------------------------------------

  Future<void> addSQL(Wallet wallet) async {
    await _sqlController.wallets.add(value: wallet);
    await refreshWallets();
  }

  Future<void> updateSQL(Wallet wallet) async {
    await _sqlController.wallets.update(value: wallet);
    await refreshWallets();
  }

  Future<void> deleteSQL(int id) async {
    if (wallets.length == 1) return;
    await _sqlController.wallets.delete(id: id);
    await refreshWallets();
  }

  Future<void> refreshWallets() async =>
      wallets.value = await _sqlController.wallets.selectAll();
}
