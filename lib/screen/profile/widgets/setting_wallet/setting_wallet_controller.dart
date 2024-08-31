import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';

class SettingWalletController extends BaseController {
  SettingWalletController({required this.wallet});

  final Wallet? wallet;
  final WalletController _walletController = Get.find();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final currency = Rxn<Currency>();
  final showBalance = RxBool(true);
  final isRoundUp = RxBool(true);

  // ----------INIT------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    if(wallet == null) return;

    nameController.text = wallet!.name;
    descriptionController.text = wallet!.description;
    currency.value = CurrencyService().findByCode(wallet!.currency);
    showBalance.value = wallet!.showBalance;
    isRoundUp.value = wallet!.isRoundUp;
  }

  void updateValues(Wallet wallet) {
    wallet.name = nameController.text;
    wallet.description = descriptionController.text;
    wallet.currency = currency.value!.code;
    wallet.showBalance = showBalance.value;
    wallet.isRoundUp = isRoundUp.value;
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
