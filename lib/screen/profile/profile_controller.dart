import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/app_controller.dart';
import 'package:pecunia/controllers/storage_controller.dart';

class ProfileController extends GetxController {
  final AppController _appController = Get.find();
  final StorageController _storageController = Get.find();

  final Rx<ThemeMode> darkTheme = Rx(Get.isDarkMode ? ThemeMode.dark : ThemeMode.light);

  final Rxn<Currency> _currency = Rxn();
  Currency? get currency => _currency.value ?? _storageController.currency;
  set currency(Currency? currency) {
    _currency.value = currency;
    _storageController.currency = currency;
  }

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    darkTheme.addListener(() => Get.changeThemeMode(darkTheme.value));
  }

  // -----------NAVIGATION-----------------------------------------------------------------------

  void goToBackup() => _appController.goToScreen(AppScreens.backup);

  void goToWallets() => _appController.goToScreen(AppScreens.wallets);
}
