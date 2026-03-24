import 'package:get/get.dart';

enum AnalyticsFilter {
  income,
  expenses,
  total;

  String get label => switch (this) {
        income => "analytics_income".tr,
        expenses => "analytics_expenses".tr,
        total => "analytics_total".tr,
      };
}
