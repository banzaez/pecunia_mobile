import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';

class AppSwitch<T> extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.onChange,
    required this.values,
    required this.value,
    this.width,
  });

  final List<AppSwitchValue<T>> values;

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
          children: List.generate(values.length, (i) => _button(values[i])),
        ),
      );

  Widget _button(AppSwitchValue item) => Expanded(
        child: value == item.value
            ? Container(
                decoration: BoxDecoration(
                  color: item.color ?? AppColors.primary,
                  borderRadius: AppBorderStyle.borderRadius,
                ),
                height: 40,
                child: Center(
                  child: Text(
                    item.label,
                    style: AppTextStyle.text14w600(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ).paddingAll(4)
            : GestureDetector(
                onTap: () => onChange.call(item.value),
                child: Text(
                  item.label,
                  style: AppTextStyle.text14w600(color: AppColors.disable),
                  textAlign: TextAlign.center,
                ),
              ),
      );
}

class AppSwitchValue<T> {
  AppSwitchValue({
    required this.label,
    required this.value,
    this.color,
  });

  final String label;
  final T value;
  final Color? color;
}
