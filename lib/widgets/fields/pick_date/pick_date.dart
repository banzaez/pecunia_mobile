import 'package:flutter/material.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/ext_list.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date_field.dart';

class PickDate extends StatelessWidget {
  PickDate({
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
    List<int>? valuesYear,
    List<int>? valuesMonth,
    List<int>? valuesDay,
  }) {
    valuesYear == null
        ? this.valuesYear.fillOfRange(firstDate.year, start: lastDate.year)
        : this.valuesYear.addAll(valuesYear);
    valuesMonth == null
        ? this.valuesMonth.fillOfRange(12, start: 1)
        : this.valuesMonth.addAll(valuesMonth);
    valuesDay == null
        ? this.valuesDay.fillOfRange(initDate?.daysInMonth ?? 0, start: 1)
        : this.valuesDay.addAll(valuesDay);

    this.valuesYear.sort((a, b) => (b.compareTo(a)));
    this.valuesMonth.sort((a, b) => (a.compareTo(b)));
    this.valuesDay.sort((a, b) => (a.compareTo(b)));

    valuesHour.fillOfRange(23, start: 0);
    valuesMinute.fillOfRange(59, start: 0, step: 5);
  }

  final Function(DateTime? value, PickDateTypeField type) onChanged;

  final DateTime? initDate;

  final String formatYear;
  final String formatMonth;
  final String formatDay;
  final String formatHour = "HH";
  final String formatMinute = "mm";

  final bool enableTime;

  final TextStyle? textStyle;

  final bool isYearSelected;
  final bool isMonthSelected;
  final bool isDaySelected;

  final List<int> valuesYear = [];
  final List<int> valuesMonth = [];
  final List<int> valuesDay = [];
  final List<int> valuesHour = [];
  final List<int> valuesMinute = [];

  // --------------------------------------------------------------------------------------------

  final DateTime firstDate = DateTime.now();
  final DateTime lastDate = DateTime(2020, 1, 1);

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
            onChanged: (value) => onChanged(value, PickDateTypeField.day),
            type: PickDateTypeField.day,
            initDate: initDate,
            format: formatDay,
            values: valuesDay,
            isSelected: isDaySelected,
          ),
          AppSpaces.h8,
          PickDateField(
            onChanged: (value) => onChanged(value, PickDateTypeField.month),
            type: PickDateTypeField.month,
            initDate: initDate,
            format: formatMonth,
            values: valuesMonth,
            isSelected: isMonthSelected,
          ),
          AppSpaces.h8,
          PickDateField(
            onChanged: (value) => onChanged(value, PickDateTypeField.year),
            type: PickDateTypeField.year,
            initDate: initDate,
            format: formatYear,
            values: valuesYear,
            isSelected: isYearSelected,
          ),
        ],
      );

  Widget _time() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSpaces.h16,
          PickDateField(
            onChanged: (value) => onChanged(value, PickDateTypeField.hour),
            type: PickDateTypeField.hour,
            initDate: initDate,
            format: formatHour,
            values: valuesHour,
            isSelected: false,
          ),
          AppSpaces.h8,
          PickDateField(
            onChanged: (value) => onChanged(value, PickDateTypeField.minute),
            type: PickDateTypeField.minute,
            initDate: initDate,
            format: formatMinute,
            values: valuesMinute,
            isSelected: false,
          ),
        ],
      );
}
