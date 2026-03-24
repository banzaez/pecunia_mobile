import 'dart:math';

import 'package:get/get.dart';
import 'package:pecunia/controllers/app_controller.dart';
import 'package:pecunia/provider/settings_provider.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/analytics_total.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/models/wallet.dart';

class HomeController extends BaseController {
  final AppController _appController = Get.find();
  final TransactionController _transactionController = Get.find();
  final WalletController _walletController = Get.find();

  final Rxn<Wallet> _currentWallet = Rxn<Wallet>();
  Wallet get currentWallet => _currentWallet.value!;

  set currentWallet(Wallet? wallet) {
    Get.find<SettingsProvider>().isRoundUp.value = wallet?.isRoundUp ?? false;
    _currentWallet.value = wallet;
    _transactionController.changeWallet(wallet?.id ?? 0);
  }

  List<Wallet> get wallets => _walletController.wallets.value;
  AnalyticsTotal get total => _transactionController.analyticsTotal.value;
  List<Transaction> get transactions => _transactionController.transactions.value;

  bool get isInitializing => _currentWallet.value == null;

  int get currentIndex => _walletController.wallets.indexWhere((e) => e.id == currentWallet.id);

  // ----------INIT-------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    ever(_walletController.wallets, _onWalletsChanged);

    if (_walletController.wallets.isNotEmpty) {
      currentWallet = _walletController.wallets.first;
    }
  }

  void _onWalletsChanged(List<Wallet> wallets) {
    if (wallets.isEmpty) {
      _currentWallet.value = null;
      return;
    }

    final currentId = _currentWallet.value?.id;
    final stillExists = currentId != null && wallets.any((w) => w.id == currentId);

    if (!stillExists) {
      currentWallet = wallets.first;
    } else {
      currentWallet = wallets.firstWhere((w) => w.id == currentId);
    }
  }

  // ----------SWIPE-LEFT-RIGHT------------------------------------------------------------------

  void swipeWallet(int offset) {
    var index = currentIndex - offset;
    index = max(0, index);
    index = min(index, _walletController.wallets.length - 1);
    currentWallet = _walletController.wallets[index];
  }

  // ----------NAVIGATION------------------------------------------------------------------------

  void goToAnalytics() => _appController.goToScreen(AppScreens.analytics);

  void goToProfile() => _appController.goToScreen(AppScreens.profile);
}
