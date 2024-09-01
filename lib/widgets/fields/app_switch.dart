import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';

class AppSwitch<T> extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.onChange,
    required this.textPrimary,
    required this.textSecond,
    required this.valuePrimary,
    required this.valueSecond,
    required this.value,
    this.width,
  });

  final String textPrimary;
  final String textSecond;

  final T valuePrimary;
  final T valueSecond;

  final T value;

  final double? width;

  final ValueChanged<T> onChange;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: AppBorderStyle.borderSideBox,
          borderRadius: AppBorderStyle.borderRadius,
        ),
        height: 48,
        width: width ?? double.infinity,
        child: Row(
          children: [
            _button(textPrimary, valuePrimary, value == valuePrimary),
            _button(textSecond, valueSecond, value == valueSecond),
          ],
        ),
      );

  Widget _button(String text, T value, bool isActive) => Expanded(
        child: isActive
            ? Container(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppBorderStyle.borderRadius
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
                onTap: () => onChange.call(value),
                child: Text(
                  text,
                  style: AppTextStyle.text14w600(color: AppColors.disable),
                  textAlign: TextAlign.center,
                ),
              ),
      );
}
