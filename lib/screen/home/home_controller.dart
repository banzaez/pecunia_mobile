import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/app_controller.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';

class HomeController extends BaseController {
  final AppController _appController = Get.find();
  final WalletController _walletController = Get.find();

  final TextEditingController controllerSumma = TextEditingController();
  final TextEditingController controllerCategory = TextEditingController();

  final Rxn<Wallet> currentWallet = Rxn<Wallet>();

  List<Wallet> get wallets => _walletController.wallets.value;

  // ----------INIT-------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    currentWallet.value = _walletController.wallets.first;
  }

  // ----------NAVIGATION------------------------------------------------------------------------

  void goToProfile() => _appController.goToScreen(AppScreens.profile);

}
