import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/widgets/fields/category_field.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => SettingTransaction.setting(TransactionType.income, transaction),
        child: Dismissible(
            key: Key(transaction.id.toString()),
            onDismissed: (direction) => Get.find<TransactionController>().deleteSQL(transaction.id),
            confirmDismiss: _confirmDismiss,
            background: Container(color: Colors.red),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white10,
                  child: transaction.amount > 0
                      ? const Icon(Icons.attach_money, color: Colors.green)
                      : const Icon(Icons.money_off, color: Colors.red),
                ),
                AppSpaces.h24,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            text: transaction.amount > 0
                                ? "tran_item_income".tr
                                : "tran_item_expense".tr,
                            style: AppTextStyle.text12w400(),
                          ),
                          TextSpan(
                            text: " ${transaction.category}",
                            style: AppTextStyle.text14w600(),
                          ),
                        ],
                      )),
                      Text(
                        transaction.amount.formatSum,
                        style: AppTextStyle.text16w400(),
                      ),
                      _description(),
                    ],
                  ),
                ),
                _date(),
              ],
            ).paddingAll(16)),
      );

  // --------------------------------------------------------------------------------------------

  Widget _description() {
    if (transaction.description.isEmpty) return const SizedBox.shrink();
    var chars = transaction.description.substring(0, min(transaction.description.length, 25));
    chars = chars + (chars.length < transaction.description.length ? "..." : "");
    return Text(chars, style: AppTextStyle.text12w400());
  }

  Widget _date() {
    if (transaction.createdAt.isToday) {
      return Text("${"tran_item_today".tr} ${transaction.createdAt.formatHourMin}");
    } else if (transaction.createdAt.isYesterday) {
      return Text("${"tran_item_yesterday".tr} ${transaction.createdAt.formatHourMin}");
    } else {
      return Text(transaction.createdAt.formatDDMMSYYYY);
    }
  }

  // --------------------------------------------------------------------------------------------

  Future<bool?> _confirmDismiss(DismissDirection direction) async => await Get.defaultDialog(
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
