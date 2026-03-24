import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:pecunia/provider/settings_provider.dart';

extension DoubleExtension on double {
  String get formatSum => NumberFormat(Get.find<SettingsProvider>().isRoundUp.value ? "#,###" : "#,##0.00", "en_US")
        .format(this)
        .replaceAll(',', ' ');

  String get formatDouble => NumberFormat("#,##0.00", "en_US").format(this).replaceAll(',', ' ');
}
