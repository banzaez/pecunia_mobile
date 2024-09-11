import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pecunia/screen/profile/profile_controller.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/currency_field.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet.dart';
import 'package:pecunia/widgets/wallet_item.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_constants.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/flex_builder.dart';
import 'package:pecunia/widgets/switch_language.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(title: "profile_title".tr),
        body: _body(),
      );

  // --------------------------------------------------------------------------------------------

  Widget _body() => Column(
        children: [
          Obx(() => AppSwitch<ThemeMode>(
                onChange: (value) => controller.darkTheme.value = value,
                values: [
                  AppSwitchValue(label: "light".tr, value: ThemeMode.light),
                  AppSwitchValue(label: "dark".tr, value: ThemeMode.dark),
                ],
                value: controller.darkTheme.value,
              )),
          Text("profile_theme".tr),
          AppSpaces.v16,
          Obx(() => CurrencyField(
                onChange: (value) => controller.currency = value,
                currency: controller.currency,
              )),
          Text("profile_main_currency".tr),
          AppSpaces.v16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SettingWallet(),
              TextButton.icon(
                onPressed: () => controller.isEditing.value = true,
                icon: const Icon(Icons.edit, color: AppColors.edit),
                label: Text(
                  "profile_edit".tr,
                  style: AppTextStyle.text14w600(color: AppColors.edit),
                ),
              ),
            ],
          ),
          Obx(() => FlexBuilder(
              itemCount: controller.wallets.length,
              itemBuilder: (_, index) => Obx(() => WalletItem(
                    wallet: controller.wallets[index],
                    isEditing: controller.isEditing.isTrue,
                  )))),
          AppSpaces.v16,
          Text("profile_my_wallets".tr),
          AppSpaces.v16,
          const Spacer(),
          SwitchLanguage(),
          const Spacer(),
          Text("profile_support".tr),
          TextButton(
            onPressed: _launchUrl,
            child: const Text(AppConstants.supportEmail),
          ),
          AppSpaces.v16,
          FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (_, snapshot) => snapshot.hasData
                ? Text(
                    "${snapshot.data!.packageName} ${snapshot.data!.version}",
                    style: AppTextStyle.text12w400(color: AppColors.disable),
                  )
                : const SizedBox.shrink(),
          ),
          AppSpaces.v32,
        ],
      ).paddingAll(16);

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse("mailto:${AppConstants.supportEmail}");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
