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
    refreshWallets();
  }

  // -----------SQL------------------------------------------------------------------------------

  Future<void> addSQL(Wallet wallet) async {
    isLoading = true;
    error = null;
    try {
      await _sqlController.wallets.add(value: wallet);
      await refreshWallets();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> updateSQL(Wallet wallet) async {
    isLoading = true;
    error = null;
    try {
      await _sqlController.wallets.update(value: wallet);
      await refreshWallets();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteSQL(int id) async {
    if (wallets.length == 1) return;
    isLoading = true;
    error = null;
    try {
      await _sqlController.wallets.delete(id: id);
      await refreshWallets();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> refreshWallets() async =>
      wallets.value = await _sqlController.wallets.selectAll();
}
