import 'dart:math';

import 'package:get/get.dart';
import 'package:pecunia/controllers/app_controller.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/models/wallet.dart';

class HomeController extends BaseController {
  final AppController _appController = Get.find();
  final TransactionController _transactionController = Get.find();
  final WalletController _walletController = Get.find();

  final Rxn<Wallet> _currentWallet = Rxn<Wallet>();
  Wallet get currentWallet => _currentWallet.value!;
  set currentWallet(Wallet? wallet) {
    _currentWallet.value = wallet;
    _transactionController.walletId = wallet?.id ?? 0;
  }

  List<Wallet> get wallets => _walletController.wallets.value;
  List<Transaction> get transactions => _transactionController.transactions.value;

  bool get isInitializing => _currentWallet.value == null;

  int get currentIndex => _walletController.wallets.indexWhere((e) => e.id == currentWallet.id);

  // ----------INIT-------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    currentWallet = _walletController.wallets.firstOrNull;

    _walletController.addListenerSQL((String type) {
      switch (type) {
        case "init": currentWallet = _walletController.wallets.first;
        case "delete": currentWallet = _walletController.wallets.first;
      }
    });
  }

  void refreshWallet() => _currentWallet.refresh();

  // ----------SWIPE-LIFT-RIGHT------------------------------------------------------------------

  void swipeWallet(int offset) {
    var index = currentIndex - offset;
    index = max(0, index);
    index = min(index, _walletController.wallets.length - 1);
    currentWallet = _walletController.wallets[index];
  }

  // ----------NAVIGATION------------------------------------------------------------------------

  void goToProfile() => _appController.goToScreen(AppScreens.profile);

}
