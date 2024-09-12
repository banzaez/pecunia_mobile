import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';
import 'package:pecunia/widgets/flex_builder.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet.dart';
import 'package:pecunia/widgets/wallet_item.dart';

class WalletsScreen extends GetWidget<WalletController> {
  const WalletsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(title: "wallets_title".tr),
        body: _body(),
      );

  // --------------------------------------------------------------------------------------------

  Widget _body() => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            AppSpaces.v16,
            _listWallets(),
          ],
        ),
      );

  // --------------------------------------------------------------------------------------------

  Widget _listWallets() => SingleChildScrollView(
        child: Obx(() => FlexBuilder(
            itemCount: controller.wallets.length,
            itemBuilder: (_, index) => Obx(() => WalletItem(
                  wallet: controller.wallets[index],
                  isEditing: controller.isEditing.isTrue,
                )))),
      ).paddingSymmetric(horizontal: 16);
}
