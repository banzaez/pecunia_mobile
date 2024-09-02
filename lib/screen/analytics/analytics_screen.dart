import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
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
          PickDate(
            onChanged: (value, type) => controller.setDateTime(value!, type),
            initDate: controller.dateTime,
            enableTime: false,
            isYearSelected: controller.isYearSelected,
            isMonthSelected: controller.isMonthSelected,
            isDaySelected: controller.isDaySelected,
          ),
        ],
      ));
}
