import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';

class PickDate extends StatelessWidget {
  PickDate({
    super.key,
    required this.onChanged,
    this.initDate,
    this.formatDay = "dd",
    this.formatMonth = "MMMM",
    this.formatYear = "yyyy",
    this.textStyle,
  })  : day = initDate?.day ?? 0,
        mouth = initDate?.month ?? 0,
        year = initDate?.year ?? 0;

  final ValueChanged<DateTime?> onChanged;
  final DateTime? initDate;

  final String formatDay;
  final String formatMonth;
  final String formatYear;

  final String formatTime = "HH : mm";

  final TextStyle? textStyle;

  final DateTime firstDate = DateTime.now();
  final DateTime lastDate = DateTime(2020, 1, 1);

  final int day;
  final int mouth;
  final int year;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _field(format: formatDay, values: _days()),
          AppSpaces.h8,
          _field(format: formatMonth, values: _mouths()),
          AppSpaces.h8,
          _field(format: formatYear, values: _years()),
          // AppSpaces.h8,
          // _field(formatTime, 0, 59),
        ],
      );

  // ----------FIELD-----------------------------------------------------------------------------

  Widget _field({
    required String format,
    required List<PickDateValue> values,
  }) =>
      GestureDetector(
        onTap: () => pickValue(List.generate(
          values.length,
          (index) => valueItem(values[index]),
        )),
        child: _style(format),
      );

  // ----------STYLE-----------------------------------------------------------------------------

  Widget _style(String format) => Container(
        decoration: const BoxDecoration(
          color: Colors.white10,
          borderRadius: AppBorderStyle.borderRadius,
        ),
        padding: const EdgeInsets.all(12),
        child: initDate == null
            ? Text(" " * format.length)
            : Text(initDate!.toFormat(format), style: textStyle),
      );

  // ----------BOTTOM-SHEET----------------------------------------------------------------------

  Widget valueItem(PickDateValue value) => GestureDetector(
        onTap: () {
          onChanged(value.date);
          Get.close();
        },
        child: Container(
          decoration: BoxDecoration(
            color: value.active ? AppColors.primary : Colors.white10,
            borderRadius: AppBorderStyle.borderRadius,
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(4),
          child: Text(value.string, style: textStyle),
        ),
      );

  Future<void> pickValue(List<Widget> values) =>
      appBottomSheet(Wrap(children: values).paddingOnly(bottom: 32));

  // ----------GENERATED-------------------------------------------------------------------------

  List<PickDateValue> _days() {
    final list = <PickDateValue>[];

    for (int i = initDate?.daysInMonth ?? 0; i > 0; --i) {
      final date = checkDate(year, mouth, i);

      list.insert(0, PickDateValue(
        string: date.toFormat(formatDay),
        date: date,
        value: 1,
        active: day == i,
      ));
    }
    return list;
  }

  List<PickDateValue> _mouths() {
    final list = <PickDateValue>[];

    for (int i = 12; i > 0; --i) {
      final date = checkDate(year, i, day);

      list.insert(0, PickDateValue(
        string: date.toFormat(formatMonth),
        date: date,
        value: i,
        active: mouth == i,
      ));
    }

    return list;
  }

  List<PickDateValue> _years() {
    final list = <PickDateValue>[];

    for (int i = firstDate.year; i >= lastDate.year; --i) {
      final date = checkDate(i, mouth, day);

      list.add(PickDateValue(
        string: date.toFormat(formatYear),
        date: date,
        value: i,
        active: year == i,
      ));
    }

    return list;
  }

  DateTime checkDate(int year, int month, int day) {
    DateTime dateTime = DateTime(year, month);
    dateTime = DateTime(year, month, day > dateTime.daysInMonth ? dateTime.daysInMonth : day);
    return dateTime;
  }
}

class PickDateValue {
  PickDateValue({
    required this.string,
    required this.date,
    required this.value,
    required this.active,
  });

  final String string;
  final DateTime date;
  final int value;
  final bool active;
}
