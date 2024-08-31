import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/screen/profile/profile_controller.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';

class WalletItem extends GetWidget<ProfileController> {
  const WalletItem({super.key, required this.wallet});

  final Wallet wallet;

  @override
  Widget build(BuildContext context) => Card(
        color: Colors.white10,
        child: ListTile(
            leading: Text(wallet.currency),
            title: Text.rich(TextSpan(
              children: [
                TextSpan(text: "${"wallet_item_name".tr}: ", style: AppTextStyle.text12w400()),
                TextSpan(text: wallet.name),
              ],
            )),
            subtitle: Text.rich(TextSpan(
              children: [
                TextSpan(
                    text: "${"wallet_item_description".tr}: ", style: AppTextStyle.text12w400()),
                TextSpan(text: wallet.description),
              ],
            )),
            trailing: Obx(() => controller.isEditing.value
                ? IconButton(
                    onPressed: () => controller.deleteWallet(wallet.id),
                    icon: const Icon(Icons.close, color: AppColors.edit),
                  )
                : const SizedBox.shrink())),
      );
}
