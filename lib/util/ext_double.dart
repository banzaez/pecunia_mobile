import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String get formatSum => formatSumCustom(roundUp: false);

  String formatSumCustom({bool roundUp = false}) =>
      NumberFormat(roundUp ? "#,###" : "#,##0.00", "en_US")
          .format(this)
          .replaceAll(',', ' ');

  String get formatDouble => NumberFormat("#,##0.00", "en_US").format(this).replaceAll(',', ' ');
}
