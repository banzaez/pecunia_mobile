import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/util/ext_datetime.dart';

class PickDateValue extends StatelessWidget {
  const PickDateValue({
    super.key,
    required this.onTap,
    required this.date,
    required this.format,
    required this.isSelected,
    this.textStyle,
  });

  final ValueChanged<DateTime> onTap;
  final DateTime date;
  final String format;
  final bool isSelected;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.backgroundContent,
            borderRadius: AppBorderStyle.borderRadius,
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(4),
          child: Text(date.toFormat(format), style: textStyle),
        ),
      );

  // --------------------------------------------------------------------------------------------

  void _onTap() {
    onTap(date);
    Get.close();
  }
}
