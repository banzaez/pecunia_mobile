import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/wallet_controller.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';

class WalletItem extends StatelessWidget {
  const WalletItem({super.key, required this.wallet, required this.isEditing});

  final Wallet wallet;
  final bool isEditing;

  @override
  Widget build(BuildContext context) => Card(
      color: Colors.white10,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white10,
          child: Text(
            wallet.currency?.code ?? "",
            style: AppTextStyle.text14w600(color: Colors.white60),
          ),
        ),
        title: Text.rich(TextSpan(
          children: [
            TextSpan(text: "${"wallet_item_name".tr}: ", style: AppTextStyle.text12w400()),
            TextSpan(text: wallet.name),
          ],
        )),
        subtitle: wallet.description.isNotEmpty
            ? Text.rich(TextSpan(
                children: [
                  TextSpan(
                      text: "${"wallet_item_description".tr}: ", style: AppTextStyle.text12w400()),
                  TextSpan(text: wallet.description),
                ],
              ))
            : null,
        trailing: isEditing
            ? IconButton(
                onPressed: () => _confirmDismiss().then((value) {
                  if (value == true) Get.find<WalletController>().deleteSQL(wallet.id);
                }),
                icon: const Icon(Icons.close, color: AppColors.edit),
              )
            : null,
      ));

  // --------------------------------------------------------------------------------------------

  Future<bool?> _confirmDismiss() async => await Get.defaultDialog(
        title: "dialog_delete_title".tr,
        middleText: "dialog_delete_content".tr,
        confirm: TextButton(
          onPressed: () => Get.backLegacy(result: true),
          child: Text(
            "dialog_delete_delete".tr,
            style: AppTextStyle.text16w600(color: Colors.red),
          ),
        ),
        cancel: TextButton(
          onPressed: () => Get.backLegacy(result: false),
          child: Text(
            "dialog_delete_cancel".tr,
            style: AppTextStyle.text16w600(),
          ),
        ),
      );
}
