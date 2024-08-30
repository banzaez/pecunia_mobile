import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/widgets/app_botton_sheet.dart';

class ButtonAddWallet extends GetWidget<WalletController> {
  const ButtonAddWallet({super.key});

  @override
  Widget build(BuildContext context) => TextButton.icon(
    onPressed: _bottomSheet,
    icon: const Icon(Icons.add_circle),
    label: Text(
      "profile_button_add_wallet".tr,
      style: AppTextStyle.text14w400(),
    ),
  );

  // --------------------------------------------------------------------------------------------

  Future<void> _bottomSheet() => appBottomSheet(
    children: [

    ]
  );
}
