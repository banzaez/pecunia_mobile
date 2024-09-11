import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/analytics_total.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/util/ext_string.dart';

class TotalHeader extends StatelessWidget {
  const TotalHeader({super.key, required this.total});

  final AnalyticsTotal total;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _item(
              title: "total_sum".tr,
              value: total.total.formatSum,
              titleStyle: AppTextStyle.text18w700(),
            ),
          _item(
            title: "incomes_sum".tr,
            value: total.income.formatSum,
            hintText: "total_hint".tr.format([DateTime.now().formatMMMM]),
          ),
          _item(
            title: "expenses_sum".tr,
            value: total.expense.formatSum,
            hintText: "total_hint".tr.format([DateTime.now().formatMMMM]),
          ),
        ],
      );

  // --------------------------------------------------------------------------------------------


  Widget _item({
    required String title,
    required String value,
    TextStyle? titleStyle,
    String? hintText,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: titleStyle ?? AppTextStyle.text18w400()),
          Text(title, style: AppTextStyle.text12w400()),
          if(hintText != null) Text(hintText, style: AppTextStyle.text10w400()),
        ],
      );
}
