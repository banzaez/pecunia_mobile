import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/provider/sql_analytics.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_category_item.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_graph.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/util/ext_string.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date.dart';

class AnalyticsScreen extends GetView<AnalyticsController> {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: _body(),
      );

  // --------------------------------------------------------------------------------------------

  AppBar _appBar() => AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("analytics_title".tr),
        centerTitle: true,
      );

  // --------------------------------------------------------------------------------------------

  Widget _body() => Obx(() => Column(
        children: [
          controller.category.isEmpty
              ? Expanded(
                  child: Center(
                      child: Text("analytics_category_empty".tr.format([controller.periodStr]))),
                )
              : Expanded(
                  child: Column(
                    children: [
                      Text("analytics_category_period".tr.format([controller.periodStr])),
                      Flexible(
                        child: AnalyticsGraph(data: controller.category),
                      ),
                      AppSpaces.v16,
                      _amount(),
                      AppSpaces.v16,
                      _category(),
                      AppSpaces.v16,
                    ],
                  ),
                ),
          Column(
            children: [
              AppSwitch(
                  onChange: (value) => controller.filter = value,
                  values: List.generate(
                    AnalyticsFilter.values.length,
                    (i) => AppSwitchValue(
                        label: AnalyticsFilter.values[i].label,
                        value: AnalyticsFilter.values[i],
                        color: i == 0
                            ? Colors.green
                            : i == 1
                                ? Colors.red
                                : null),
                  ),
                  value: controller.filter),
              AppSpaces.v16,
              PickDate(
                onChanged: (value, type) => controller.setDate(value!, type),
                initDate: controller.date,
                enableTime: false,
                isYearSelected: controller.isYearSelected,
                isMonthSelected: controller.isMonthSelected,
                isDaySelected: controller.isDaySelected,
                valuesYear: controller.valuesYear,
                valuesMonth: controller.valuesMonth,
                valuesDay: controller.valuesDay,
              ),
            ],
          ),
          AppSpaces.v32,
        ],
      ));

  // --------------------------------------------------------------------------------------------

  Widget _amount() => Obx(() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${"analytics_total_period".tr} ", style: AppTextStyle.text12w400()),
          Text(controller.amount?.formatSum ?? "0", style: AppTextStyle.text18w400()),
        ],
      ));

  Widget _category() => Obx(() => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.category.length,
        itemBuilder: (_, index) => AnalyticsCategoryItem(
          analytics: controller.category[index],
          index: index,
        ),
      ));
}
