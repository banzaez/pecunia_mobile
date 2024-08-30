import 'package:get/get.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';

class ProfileController extends GetxController {
  final WalletController walletController = Get.find<WalletController>();

  List<Wallet> get wallets => walletController.wallets.value;

}
