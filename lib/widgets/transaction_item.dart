import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/ext_double.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) => Dismissible(
        key: Key(transaction.id.toString()),
        onDismissed: (direction) => Get.find<TransactionController>().deleteSQL(transaction.id),
        confirmDismiss: _confirmDismiss,
        background: Container(color: Colors.red),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white10,
            child: transaction.amount > 0
                ? const Icon(Icons.attach_money, color: Colors.green)
                : const Icon(Icons.money_off, color: Colors.red),
          ),
          title: Text.rich(TextSpan(
            children: [
              TextSpan(
                  text: transaction.amount > 0
                      ? "transaction_item_income".tr
                      : "transaction_item_expense".tr,
                  style: AppTextStyle.text12w400()),
              TextSpan(text: " ${transaction.category}", style: AppTextStyle.text14w600()),
            ],
          )),
          subtitle: Text(transaction.amount.formatSum, style: AppTextStyle.text16w400()),
          trailing: _date(),
        ),
      );

  // --------------------------------------------------------------------------------------------

  Widget _date() {
    if (transaction.createdAt.isToday) {
      return Text("${"transaction_item_today".tr} ${transaction.createdAt.formatHourMin}");
    } else if (transaction.createdAt.isYesterday) {
      return Text("${"transaction_item_yesterday".tr} ${transaction.createdAt.formatHourMin}");
    } else {
      return Text(transaction.createdAt.formatDDMMSYYYY);
    }
  }

  // --------------------------------------------------------------------------------------------

  Future<bool> _confirmDismiss(DismissDirection direction) async => await Get.defaultDialog(
        title: "transaction_item_dialog_button_title".tr,
        content: Text("transaction_item_dialog_button_content".tr),
        actions: [
          TextButton(
              onPressed: () => Get.backLegacy(result: true),
              child: Text(
                "transaction_item_dialog_button_delete".tr,
                style: AppTextStyle.text16w600(color: Colors.red),
              )),
          TextButton(
            onPressed: () => Get.backLegacy(result: false),
            child: Text(
              "transaction_item_dialog_button_cancel".tr,
              style: AppTextStyle.text16w600(),
            ),
          ),
        ],
      );
}
