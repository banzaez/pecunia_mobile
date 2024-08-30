import 'package:get/get.dart';
import 'package:pecunia/controllers/sql_controller.dart';
import 'package:pecunia/models/wallet.dart';

class WalletController extends GetxController {
  final SQLController sqlController = Get.find<SQLController>();

  final RxList<Wallet> wallets = RxList();

  Future<void> addWallet() async {
    var newWallet = Wallet(
      name: "Новый",
      description: "",
      currency: "1",
      showBalance: true,
      isRoundUp: true,
    );

    await sqlController.walletAdd(wallet: newWallet);

    wallets.value = await sqlController.walletList();
  }

  Future<void> updateWallet() async => wallets.value = await sqlController.walletList();

}