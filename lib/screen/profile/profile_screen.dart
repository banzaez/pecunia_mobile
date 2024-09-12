import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pecunia/screen/profile/profile_controller.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/currency_field.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_constants.dart';
import 'package:pecunia/util/app_spaces.dart';
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

  Widget _body() => GetX<ProfileController>(
        builder: (controller) => Column(
          children: [
            AppSpaces.v16,
            _settings(),
            AppSpaces.v32,
            _buttons(),
            AppSpaces.v16,
            const Spacer(),
            SwitchLanguage(),
            const Spacer(),
            TextButton(
              onPressed: _launchUrl,
              child: const Text(AppConstants.supportEmail),
            ),
            Text("profile_support".tr, style: AppTextStyle.text12w400(color: AppColors.disable)),
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
            AppSpaces.v64,
          ],
        ),
      );

  // --------------------------------------------------------------------------------------------

  Widget _settings() => Column(
        children: [
          AppSwitch<ThemeMode>(
            onChange: (value) => controller.darkTheme.value = value,
            values: [
              AppSwitchValue(label: "light".tr, value: ThemeMode.light),
              AppSwitchValue(label: "dark".tr, value: ThemeMode.dark),
            ],
            value: controller.darkTheme.value,
          ),
          Text("profile_theme".tr),
          AppSpaces.v16,
          CurrencyField(
            onChange: (value) => controller.currency = value,
            currency: controller.currency,
          ),
          Text("profile_main_currency".tr),
        ],
      ).paddingSymmetric(horizontal: 32);

  Widget _buttons() => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 256,
            child: ElevatedButton(
              onPressed: controller.goToWallets,
              child: Text("wallets_button".tr),
            ),
          ),
          AppSpaces.v16,
          SizedBox(
            width: 256,
            child: ElevatedButton(
              onPressed: controller.goToBackup,
              child: Text("backup_button".tr),
            ),
          ),
        ],
      );

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse("mailto:${AppConstants.supportEmail}");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
