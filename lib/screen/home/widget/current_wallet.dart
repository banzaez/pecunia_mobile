import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/widgets/dialogs/dialog_choose_wallet.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';

class CurrentWallet extends GetWidget<HomeController> {
  const CurrentWallet({super.key});

  @override
  Widget build(BuildContext context) => DialogChooseWallet(
        onChanged: (value) {
          controller.currentWallet = value;
          Get.backLegacy(result: value);
        },
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
}
