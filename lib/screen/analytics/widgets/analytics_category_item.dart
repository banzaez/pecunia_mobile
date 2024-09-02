import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/ext_double.dart';

class AnalyticsCategoryItem extends StatelessWidget {
  const AnalyticsCategoryItem({super.key, required this.analytics, required this.index});

  final Analytics analytics;
  final int index;

  @override
  Widget build(BuildContext context) => Card(
        color: AppColors.backgroundContent,
        child: ListTile(
          leading: Icon(
            Icons.fiber_manual_record,
            color: Colors.primaries[index % Colors.primaries.length],
          ),
          title: Text(analytics.category ?? ""),
          subtitle: Text.rich(TextSpan(
            children: [
              TextSpan(
                text: "${"analytics_category_item_count".tr} ",
                style: AppTextStyle.text10w400(),
              ),
              TextSpan(
                text: analytics.count.toString(),
                style: AppTextStyle.text12w400(),
              ),
            ],
          )),
          trailing: Text(analytics.amount.formatSum, style: AppTextStyle.text16w600()),
        ),
      );
}
