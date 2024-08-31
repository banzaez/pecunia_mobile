import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/profile/profile_controller.dart';
import 'package:pecunia/screen/profile/widgets/setting_wallet/setting_wallet.dart';
import 'package:pecunia/screen/profile/widgets/wallet_item.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_constants.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/fields/bool_switch.dart';
import 'package:pecunia/widgets/flex_builder.dart';
import 'package:pecunia/widgets/switch_language.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: _body(),
      );

  // --------------------------------------------------------------------------------------------

  AppBar _appBar() => AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("profile_title".tr),
      );

  // --------------------------------------------------------------------------------------------

  Widget _body() => SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => BoolSwitch(
                  onChange: (value) => controller.darkTheme.value = value,
                  textPrimary: "light".tr,
                  textSecond: "dark".tr,
                  value: controller.darkTheme.value,
                )),
            Text("profile_theme".tr),
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
            Text("profile_my_wallets".tr),
            AppSpaces.v16,
            Obx(() => FlexBuilder(
                itemCount: controller.wallets.length,
                itemBuilder: (_, index) => WalletItem(
                      wallet: controller.wallets[index],
                    ))),
            AppSpaces.v16,
            Text("profile_support".tr),
            TextButton(
              onPressed: _launchUrl,
              child: const Text(AppConstants.supportEmail),
            ),
            AppSpaces.v16,
            SwitchLanguage(),
          ],
        ).paddingAll(16),
      );

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse("mailto:${AppConstants.supportEmail}");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
