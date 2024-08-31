import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/sql_controller.dart';
import 'package:pecunia/models/wallet.dart';

class WalletController extends BaseController {
  final SQLController sqlController = Get.find<SQLController>();

  final RxList<Wallet> wallets = RxList();

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    refreshWallets();
  }

  // -----------SQL------------------------------------------------------------------------------

  Future<void> addSQL(Wallet wallet) async {
    await sqlController.tableWallets.add(wallet: wallet);

    refreshWallets();
  }

  Future<void> updateSQL(Wallet wallet) async {
    await sqlController.tableWallets.update(wallet: wallet);

    refreshWallets();
  }

  Future<void> deleteSQL(int id) async {
    await sqlController.tableWallets.delete(id: id);

    refreshWallets();
  }

  Future<void> refreshWallets() async => wallets.value = await sqlController.tableWallets.getList();
}
