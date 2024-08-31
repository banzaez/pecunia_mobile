import 'dart:math';

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

  // ----------SWIPE-LIFT-RIGHT------------------------------------------------------------------

  void swipeWallet(int offset) {
    var index = _walletController.wallets.indexWhere((e) => e.id == currentWallet.value!.id) - offset;
    index = max(0, index);
    index = min(index, _walletController.wallets.length - 1);
    currentWallet.value = _walletController.wallets[index];
  }

  // ----------NAVIGATION------------------------------------------------------------------------

  void goToProfile() => _appController.goToScreen(AppScreens.profile);

}
