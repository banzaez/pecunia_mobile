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
            value: total.total.formatSum,
            valueStyle: AppTextStyle.text12w600(),
            label: "total_sum".tr,
            labelStyle: AppTextStyle.text18w700(),
          ),
          _item(
            value: total.income.formatSum,
            label: "incomes_sum".tr,
            hintText: "total_hint".tr.format([DateTime.now().formatMMMM]),
          ),
          _item(
            value: total.expense.formatSum,
            label: "expenses_sum".tr,
            hintText: "total_hint".tr.format([DateTime.now().formatMMMM]),
          ),
        ],
      );

  // --------------------------------------------------------------------------------------------

  Widget _item({
    required String value,
    required String label,
    TextStyle? labelStyle,
    TextStyle? valueStyle,
    String? hintText,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: labelStyle ?? AppTextStyle.text18w400()),
          Text(label, style: valueStyle ?? AppTextStyle.text12w400()),
          if (hintText != null) Text(hintText, style: AppTextStyle.text10w400()),
        ],
      );
}
