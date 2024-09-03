import 'package:flutter/material.dart';
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
          children: List.generate(values.length, (i) => Expanded(child: _button(values[i]))),
        ),
      );

  // --------------------------------------------------------------------------------------------

  Widget _button(AppSwitchValue item) {
    final isActive = item.value == value;
    final widget = Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? item.color ?? AppColors.primary : null,
        borderRadius: AppBorderStyle.borderRadius,
      ),
      margin: const EdgeInsets.all(4),
      child: Text(
        item.label,
        style: AppTextStyle.text14w600(color: isActive ? null : AppColors.disable),
        textAlign: TextAlign.center,
      ),
    );

    return isActive
        ? widget
        : GestureDetector(
            onTap: () => onChange.call(item.value),
            child: widget,
          );
  }
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
