import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date_type.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date_value.dart';

export 'package:pecunia/widgets/fields/pick_date/pick_date_type.dart';

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
  final DateType type;
  final DateTime? initDate;
  final String format;
  final List<int> values;
  final bool isSelected;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => appBottomSheet(
          context,
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: _getValues(values: values),
              ),
            ),
          ),
        ),
        onLongPress: initDate != null ? () => onChanged(initDate!) : null,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppBorderStyle.fillColor(Theme.of(context).brightness),
            borderRadius: AppBorderStyle.borderRadius,
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppBorderStyle.borderColor(Theme.of(context).brightness),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: initDate == null
              ? Text(" " * format.length)
              : Text(initDate!.toFormat(format), style: textStyle),
        ),
      );

  // ----------GENERATE-VALUES-------------------------------------------------------------------

  List<Widget> _getValues({required List<int> values}) =>
      List.generate(values.length, (index) {
        final date = changeDate(values[index]);
        return PickDateValue(
          onTap: onChanged,
          date: date,
          format: format,
          isSelected: getCurrentValue() == values[index],
        );
      });

  // ----------CHANGE-DATE-----------------------------------------------------------------------

  DateTime changeDate(int value) {
    final currentDate = initDate ?? DateTime.now();

    final int targetYear = type == DateType.year ? value : currentDate.year;
    final int targetMonth = type == DateType.month ? value : currentDate.month;
    final int maxDay = DateTime(targetYear, targetMonth + 1, 0).day;
    final int targetDay =
        type == DateType.day ? value : currentDate.day.clamp(1, maxDay);

    return DateTime(
      targetYear,
      targetMonth,
      targetDay,
      type == DateType.hour ? value : currentDate.hour,
      type == DateType.minute ? value : currentDate.minute,
    );
  }

  int getCurrentValue() => switch (type) {
        DateType.year => initDate?.year ?? 0,
        DateType.month => initDate?.month ?? 0,
        DateType.day => initDate?.day ?? 0,
        DateType.hour => initDate?.hour ?? 0,
        DateType.minute => initDate?.minute ?? 0,
      };
}
