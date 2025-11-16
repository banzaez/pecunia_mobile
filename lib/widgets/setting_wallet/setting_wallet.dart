import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/base_field.dart';
import 'package:pecunia/widgets/fields/currency_field.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet_controller.dart';

class SettingWallet extends StatelessWidget {
  const SettingWallet({super.key, this.update});

  final Wallet? update;

  @override
  Widget build(BuildContext context) => update == null
      ? TextButton.icon(
          onPressed: _setting,
          icon: const Icon(Icons.add_circle),
          label: Text(
            "setting_wallet_button_add".tr,
            style: AppTextStyle.text14w400(),
          ),
        )
      : IconButton(
          onPressed: _setting,
          icon: const Icon(Icons.settings),
        );

  Future<void> _setting() async => appBottomSheet(SingleChildScrollView(
        child: GetX<SettingWalletController>(
          init: SettingWalletController(wallet: update),
          builder: (controller) => Column(
            children: [
              AppSpaces.v8,
              Center(
                child: Text(
                  update == null ? "setting_wallet_title_add".tr : "setting_wallet_title_update".tr,
                  textAlign: TextAlign.center,
                ),
              ),
              AppSpaces.v16,
              BaseField(
                controller: controller.nameController,
                errorText: controller.errorName.value,
              ),
              Text("setting_wallet_name".tr),
              AppSpaces.v16,
              BaseField(
                controller: controller.descriptionController,
              ),
              Text("setting_wallet_description".tr),
              AppSpaces.v16,
              CurrencyField(
                onChange: (value) => controller.currency.value = value,
                currency: controller.currency.value,
                errorText: controller.errorCurrency.value,
              ),
              Text("setting_wallet_currency".tr),
              AppSpaces.v16,
              AppSwitch<bool>(
                onChange: (value) => controller.showBalance.value = value,
                values: [
                  AppSwitchValue(label: "no".tr, value: false),
                  AppSwitchValue(label: "yes".tr, value: true),
                ],
                value: controller.showBalance.value,
                width: 256,
              ),
              Text("setting_wallet_show_balance".tr),
              AppSpaces.v16,
              AppSwitch<bool>(
                onChange: (value) => controller.isRoundUp.value = value,
                values: [
                  AppSwitchValue(label: "no".tr, value: false),
                  AppSwitchValue(label: "yes".tr, value: true),
                ],
                value: controller.isRoundUp.value,
                width: 256,
              ),
              Text("setting_wallet_is_round_up".tr),
              AppSpaces.v32,
              ElevatedButton(
                onPressed: () {
                  if (!controller.isOk()) return;
                  Get.backLegacy(result: controller.save());
                },
                child: Text("setting_wallet_button_save".tr),
              ),
              AppSpaces.v32,
            ],
          ),
        ),
      ));
}
