import 'package:intl/intl.dart';
import 'package:pecunia/controllers/app_controller.dart';

extension DoubleExtension on double {
  String get formatSum => NumberFormat(AppController.isRoundUp.value ? "#,###" : "#,##0.00", "en_US")
        .format(this)
        .replaceAll(',', ' ');

  String get formatDouble => NumberFormat("#,##0.00", "en_US").format(this).replaceAll(',', ' ');
}
