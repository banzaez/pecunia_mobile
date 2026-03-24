import 'package:flutter/material.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date_field.dart';

export 'package:pecunia/widgets/fields/pick_date/pick_date_type.dart';

class PickDate extends StatelessWidget {
  const PickDate({
    super.key,
    required this.onChanged,
    this.initDate,
    this.formatYear = "yyyy",
    this.formatMonth = "MMMM",
    this.formatDay = "dd",
    this.textStyle,
    this.enableTime = true,
    this.isYearSelected = false,
    this.isMonthSelected = false,
    this.isDaySelected = false,
    this.valuesYear,
    this.valuesMonth,
    this.valuesDay,
  });

  final Function(DateTime? value, DateType type) onChanged;

  final DateTime? initDate;

  final String formatYear;
  final String formatMonth;
  final String formatDay;
  static const String _formatHour = "HH";
  static const String _formatMinute = "mm";

  final bool enableTime;
  final TextStyle? textStyle;

  final bool isYearSelected;
  final bool isMonthSelected;
  final bool isDaySelected;

  final List<int>? valuesYear;
  final List<int>? valuesMonth;
  final List<int>? valuesDay;

  static final List<int> _valuesHour = List.generate(24, (i) => i);
  static final List<int> _valuesMinute = List.generate(12, (i) => i * 5);
  static final DateTime _minDate = DateTime(2020, 1, 1);

  List<int> get _resolvedValuesYear {
    final maxYear = DateTime.now().year;
    if (valuesYear != null) {
      return (List<int>.from(valuesYear!))..sort((a, b) => b.compareTo(a));
    }
    return List.generate(maxYear - _minDate.year + 1, (i) => maxYear - i);
  }

  List<int> get _resolvedValuesMonth {
    if (valuesMonth != null) {
      return (List<int>.from(valuesMonth!))..sort((a, b) => a.compareTo(b));
    }
    return List.generate(12, (i) => i + 1);
  }

  List<int> get _resolvedValuesDay {
    if (valuesDay != null) {
      return (List<int>.from(valuesDay!))..sort((a, b) => a.compareTo(b));
    }
    final days = initDate?.daysInMonth ?? 0;
    return List.generate(days, (i) => i + 1);
  }

  // --------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [_date(), if (enableTime) _time()],
      );

  Widget _date() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PickDateField(
            onChanged: (value) => onChanged(value, DateType.year),
            type: DateType.year,
            initDate: initDate,
            format: formatYear,
            values: _resolvedValuesYear,
            isSelected: isYearSelected,
          ),
          AppSpaces.h8,
          PickDateField(
            onChanged: (value) => onChanged(value, DateType.month),
            type: DateType.month,
            initDate: initDate,
            format: formatMonth,
            values: _resolvedValuesMonth,
            isSelected: isMonthSelected,
          ),
          AppSpaces.h8,
          PickDateField(
            onChanged: (value) => onChanged(value, DateType.day),
            type: DateType.day,
            initDate: initDate,
            format: formatDay,
            values: _resolvedValuesDay,
            isSelected: isDaySelected,
          ),
        ],
      );

  Widget _time() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSpaces.h16,
          PickDateField(
            onChanged: (value) => onChanged(value, DateType.hour),
            type: DateType.hour,
            initDate: initDate,
            format: _formatHour,
            values: _valuesHour,
            isSelected: false,
          ),
          AppSpaces.h8,
          PickDateField(
            onChanged: (value) => onChanged(value, DateType.minute),
            type: DateType.minute,
            initDate: initDate,
            format: _formatMinute,
            values: _valuesMinute,
            isSelected: false,
          ),
        ],
      );
}
