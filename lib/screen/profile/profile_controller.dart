import 'package:get/get.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';

class ProfileController extends GetxController {
  final WalletController _walletController = Get.find();

  final RxBool darkTheme = RxBool(true);
  final RxBool isEditing = RxBool(false);

  List<Wallet> get wallets => _walletController.wallets.value;

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    _walletController.refreshWallets();
  }
}
