import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/storage_controller.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';

class SettingWalletController extends BaseController {
  SettingWalletController({required this.wallet});

  final StorageController _storageController = Get.find();

  final Wallet? wallet;
  final WalletController _walletController = Get.find();

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

    if(wallet == null) {
      currency.value = _storageController.currency;
      return;
    }

    nameController.text = wallet!.name;
    descriptionController.text = wallet!.description;
    currency.value = CurrencyService().findByCode(wallet!.currency);
    showBalance.value = wallet!.showBalance;
    isRoundUp.value = wallet!.isRoundUp;
  }

  // ----------VALUES----------------------------------------------------------------------------

  void updateValues(Wallet wallet) {
    wallet.name = nameController.text;
    wallet.description = descriptionController.text;
    wallet.currency = currency.value!.code;
    wallet.showBalance = showBalance.value;
    wallet.isRoundUp = isRoundUp.value;
  }

  bool isOk() {
    errorName.value = nameController.text.isEmpty ? "setting_wallet_error_name".tr : null;
    errorCurrency.value = currency.value == null ? "setting_wallet_error_currency".tr : null;

    return errorName.value == null && errorCurrency.value == null;
  }

  // ----------SQL-------------------------------------------------------------------------------

  void addSettings() {
    final wallet = Wallet.empty();
    updateValues(wallet);
    _walletController.addSQL(wallet);
  }

  void updateSettings(Wallet wallet) {
    updateValues(wallet);
    _walletController.updateSQL(wallet);
  }
}
