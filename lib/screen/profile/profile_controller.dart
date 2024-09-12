import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/app_controller.dart';
import 'package:pecunia/controllers/storage_controller.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';

class ProfileController extends GetxController {
  final AppController _appController = Get.find();
  final StorageController _storageController = Get.find();
  final WalletController _walletController = Get.find();

  final Rx<ThemeMode> darkTheme = Rx(Get.isDarkMode ? ThemeMode.dark : ThemeMode.light);

  final Rxn<Currency> _currency = Rxn();

  final RxBool isEditing = RxBool(false);

  Currency? get currency => _currency.value ?? _storageController.currency ;
  set currency(Currency? currency) {
    _currency.value = currency;
    _storageController.currency = currency;
  }

  List<Wallet> get wallets => _walletController.wallets.value;

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    _walletController.refreshWallets();

    darkTheme.addListener(() => Get.changeThemeMode(darkTheme.value));
  }

  // -----------NAVIGATION-----------------------------------------------------------------------

  void goToBackup() => _appController.goToScreen(AppScreens.backup);
}
