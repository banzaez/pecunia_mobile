import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/widgets/flex_builder.dart';
import 'package:pecunia/widgets/wallet_item.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';

class CurrentWallet extends GetWidget<HomeController> {
  const CurrentWallet({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _onTap,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSpaces.h24,
                Obx(() => Text(controller.currentWallet.name)),
                const Icon(Icons.arrow_drop_down, size: 24),
              ],
            ),
            Text("current_wallet_title".tr, style: AppTextStyle.text12w400()),
          ],
        ),
      );

  // --------------------------------------------------------------------------------------------

  Widget _item(wallet) => GestureDetector(
        onTap: () {
          controller.currentWallet = wallet;
          Get.backLegacy();
        },
        child: WalletItem(wallet: wallet, isEditing: false),
      );

  Future<void> _onTap() => appBottomSheet(
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("current_wallet_bottom_title".tr),
              AppSpaces.v16,
              FlexBuilder(
                mainAxisSize: MainAxisSize.min,
                itemCount: controller.wallets.length,
                itemBuilder: (_, index) => _item(controller.wallets[index]),
              ),
            ],
          ),
        ),
      );
}
