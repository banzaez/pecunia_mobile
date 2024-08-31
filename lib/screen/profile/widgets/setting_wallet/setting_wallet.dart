import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/screen/profile/widgets/setting_wallet/setting_wallet_controller.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/fields/base_field.dart';
import 'package:pecunia/widgets/fields/bool_switch.dart';
import 'package:pecunia/widgets/fields/dropdown_field.dart';

class SettingWallet extends GetWidget {
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
            update == null
                ? Text("setting_wallet_title_add".tr, style: AppTextStyle.text22w400())
                : Text("setting_wallet_title_update".tr, style: AppTextStyle.text22w400()),
            AppSpaces.v16,
            BaseField(
              controller: controller.nameController,
            ),
            Text("setting_wallet_name".tr),
            AppSpaces.v16,
            BaseField(
              controller: controller.descriptionController,
            ),
            Text("setting_wallet_description".tr),
            AppSpaces.v16,
            DropdownField(items: [], hint: "hint"),
            Text("setting_wallet_currency".tr),
            AppSpaces.v16,
            BoolSwitch(
              onChange: (value) => controller.showBalance.value = value,
              textPrimary: "no".tr,
              textSecond: "yes".tr,
              value: controller.showBalance.value,
              width: 256,
            ),
            Text("setting_wallet_show_balance".tr),
            AppSpaces.v16,
            BoolSwitch(
              onChange: (value) => controller.isRoundUp.value = value,
              textPrimary: "no".tr,
              textSecond: "yes".tr,
              value: controller.isRoundUp.value,
              width: 256,
            ),
            Text("setting_wallet_is_round_up".tr),
            AppSpaces.v16,
            ElevatedButton(
              onPressed: () => _save(controller),
              child: Text("setting_wallet_button_save".tr),
            ),
            AppSpaces.v16,
          ],
        ),
    ),
  ));

  void _save(SettingWalletController controller) {
    if (update == null) {
      controller.addSettings();
    } else {
      controller.updateSettings(update!);
    }
    Get.close();
  }
}
