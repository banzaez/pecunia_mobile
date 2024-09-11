import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_double.dart';

class AnalyticsCategoryItem extends StatelessWidget {
  const AnalyticsCategoryItem({
    super.key,
    this.onTap,
    required this.analytics,
    required this.index,
  });

  final VoidCallback? onTap;
  final Analytics analytics;
  final int index;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppBorderStyle.borderRadius,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                analytics.total > 0 ? Colors.green.withOpacity(.25) : Colors.red.withOpacity(.25),
                analytics.total > 0
                    ? Colors.greenAccent.withOpacity(.7)
                    : Colors.redAccent.withOpacity(.7),
              ],
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              Icon(
                Icons.fiber_manual_record,
                color: Colors.primaries[index % Colors.primaries.length],
              ),
              AppSpaces.h24,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(analytics.category?.name ?? ""),
                  Text.rich(TextSpan(
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
                  ))
                ],
              ),
              const Spacer(),
              Text(analytics.total.formatSum, style: AppTextStyle.text16w600())
            ],
          ),
        ),
      );
}
