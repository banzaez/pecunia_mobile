import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date_value.dart';

class PickDateField extends StatelessWidget {
  const PickDateField({
    super.key,
    required this.onChanged,
    required this.type,
    required this.initDate,
    required this.format,
    required this.values,
    required this.isSelected,
    this.textStyle,
  });

  final ValueChanged<DateTime> onChanged;
  final PickDateTypeField type;
  final DateTime? initDate;
  final String format;
  final List<int> values;
  final bool isSelected;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => appBottomSheet(
          Wrap(children: _getValues(values: values)).paddingOnly(bottom: 64),
        ),
        onLongPress: () => onChanged(initDate!),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.backgroundContent,
            borderRadius: AppBorderStyle.borderRadius,
          ),
          padding: const EdgeInsets.all(12),
          child: initDate == null
              ? Text(" " * format.length)
              : Text(initDate!.toFormat(format), style: textStyle),
        ),
      );

  // ----------GENERATE-VALUES-------------------------------------------------------------------

  List<Widget> _getValues({required List<int> values}) {
    final list = List.generate(values.length, (index) {
      final date = changeDate(values[index]);

      return PickDateValue(
        onTap: onChanged,
        date: date,
        format: format,
        isSelected: getCurrentValue() == values[index],
      );
    });

    return list;
  }

  // ----------CHANGE-DATE-----------------------------------------------------------------------

  DateTime changeDate(value) {
    DateTime currentDate = initDate ?? DateTime.now();

    DateTime dateTime = DateTime(
      type == PickDateTypeField.year ? value : currentDate.year,
      type == PickDateTypeField.month ? value : currentDate.month,
    );

    final day = currentDate.day > dateTime.daysInMonth ? dateTime.daysInMonth : currentDate.day;

    dateTime = DateTime(
      type == PickDateTypeField.year ? value : currentDate.year,
      type == PickDateTypeField.month ? value : currentDate.month,
      type == PickDateTypeField.day ? value : day,
      type == PickDateTypeField.hour ? value : currentDate.hour,
      type == PickDateTypeField.minute ? value : currentDate.minute,
    );
    return dateTime;
  }

  int getCurrentValue() => switch (type) {
        PickDateTypeField.year => initDate?.year ?? 0,
        PickDateTypeField.month => initDate?.month ?? 0,
        PickDateTypeField.day => initDate?.day ?? 0,
        PickDateTypeField.hour => initDate?.hour ?? 0,
        PickDateTypeField.minute => initDate?.minute ?? 0
      };
}

enum PickDateTypeField {
  year,
  month,
  day,
  hour,
  minute,
}
