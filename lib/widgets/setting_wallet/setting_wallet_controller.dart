import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/provider/settings_provider.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';

class SettingWalletController extends BaseController {
  SettingWalletController({required Wallet? wallet}) {
    this.wallet = wallet ?? Wallet.empty();
  }

  final SettingsProvider _settingsProvider = Get.find();
  final WalletController _walletController = Get.find();

  late final Wallet wallet;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final currency = Rxn<Currency>();
  final showBalance = RxBool(true);
  final isRoundUp = RxBool(true);

  final errorName = RxnString();
  final errorCurrency = RxnString();

  // ----------INIT------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    nameController.text = wallet.name;
    descriptionController.text = wallet.description;
    currency.value = wallet.id == 0 ? _settingsProvider.currency : wallet.currency;
    showBalance.value = wallet.showBalance;
    isRoundUp.value = wallet.isRoundUp;
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  // ----------VALUES----------------------------------------------------------------------------

  void updateValues() {
    wallet.name = nameController.text;
    wallet.description = descriptionController.text;
    wallet.currency = currency.value;
    wallet.showBalance = showBalance.value;
    wallet.isRoundUp = isRoundUp.value;
  }

  bool isOk() {
    errorName.value = nameController.text.isEmpty ? "setting_wallet_error_name".tr : null;
    errorCurrency.value = currency.value == null ? "setting_wallet_error_currency".tr : null;

    return errorName.value == null && errorCurrency.value == null;
  }

  // ----------SQL-------------------------------------------------------------------------------

  bool save() {
    if (!isOk()) return false;
    updateValues();

    wallet.id == 0 ? _walletController.addSQL(wallet) : _walletController.updateSQL(wallet);

    return true;
  }
}
