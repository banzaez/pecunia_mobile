import 'package:get/get.dart';
import 'package:pecunia/controllers/sql_controller.dart';
import 'package:pecunia/models/wallet.dart';

class ProfileController extends GetxController {
  final SQLController sqlController = Get.find<SQLController>();

  final RxList<Wallet> wallets = RxList();

  void addWallet() async {
    var newWallet = Wallet(
      id: 1,
      name: "Новый",
      description: "",
      currency: "1",
      showBalance: true,
      isRoundUp: true,
    );

    await sqlController.walletAdd(wallet: newWallet);
    
    wallets.value = await sqlController.walletList();
  }
}
