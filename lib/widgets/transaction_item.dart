import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/ext_double.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) => Card(
      color: Colors.white10,
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
                text:
                    "${transaction.amount > 0 ? "transaction_item_income".tr : "transaction_item_expense".tr}: ",
                style: AppTextStyle.text12w400()),
            TextSpan(text: " ${transaction.category}", style: AppTextStyle.text14w400()),
          ],
        )),
        subtitle: Text(transaction.amount.formatSum, style: AppTextStyle.text16w400()),
        trailing: _date(),
      ));

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
}
