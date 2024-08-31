import 'package:get/get.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';

class ProfileController extends GetxController {
  final WalletController walletController = Get.find<WalletController>();

  final RxBool darkTheme = RxBool(true);
  final RxBool isEditing = RxBool(false);

  List<Wallet> get wallets => walletController.wallets.value;

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    walletController.refreshWallets();
  }

  // -----------SQL------------------------------------------------------------------------------

  void deleteWallet(int id) => walletController.deleteSQL(id);
}
