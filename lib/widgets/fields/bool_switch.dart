import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';

class BoolSwitch extends StatelessWidget {
  const BoolSwitch({
    super.key,
    required this.onChange,
    required this.textPrimary,
    required this.textSecond,
    required this.value,
    this.width,
  });

  final bool value;

  final String textPrimary;
  final String textSecond;

  final double? width;

  final ValueChanged<bool> onChange;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 48,
        width: width ?? double.infinity,
        child: Row(
          children: [
            _button(textPrimary, value == true),
            _button(textSecond, value == false),
          ],
        ),
      );

  Widget _button(String text, bool isActive) => Expanded(
        child: isActive
            ? Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8)
                ),
                height: 40,
                child: Center(
                  child: Text(
                    text,
                    style: AppTextStyle.text14w600(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ).paddingAll(4)
            : GestureDetector(
                onTap: () => onChange(!value),
                child: Text(
                  text,
                  style: AppTextStyle.text14w600(color: AppColors.disable),
                  textAlign: TextAlign.center,
                ),
              ),
      );
}
