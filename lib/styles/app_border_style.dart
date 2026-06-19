import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_colors.dart';

abstract class AppBorderStyle {
  static const borderRadius = BorderRadius.all(Radius.circular(10));

  static const contentPadding = EdgeInsets.symmetric(vertical: 12, horizontal: 16);

  static Color borderColor(Brightness brightness) =>
      brightness == Brightness.dark
          ? Colors.white.withValues(alpha: 0.22)
          : Colors.black.withValues(alpha: 0.14);

  static Color fillColor(Brightness brightness) =>
      brightness == Brightness.dark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.black.withValues(alpha: 0.03);

  static OutlineInputBorder outline(
    Brightness brightness, {
    Color? color,
    double width = 1,
  }) =>
      OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: color ?? borderColor(brightness),
          width: width,
        ),
      );

  static InputDecorationTheme decorationTheme(Brightness brightness) {
    final enabled = borderColor(brightness);
    return InputDecorationTheme(
      alignLabelWithHint: true,
      contentPadding: contentPadding,
      filled: true,
      fillColor: fillColor(brightness),
      border: outline(brightness),
      enabledBorder: outline(brightness),
      focusedBorder: outline(brightness, color: AppColors.primary, width: 1.5),
      disabledBorder: outline(brightness, color: enabled.withValues(alpha: 0.45)),
      errorBorder: outline(brightness, color: AppColors.error),
      focusedErrorBorder: outline(brightness, color: AppColors.error, width: 1.5),
    );
  }

  static InputDecoration inputDecoration(
    BuildContext context, {
    String? labelText,
    String? hintText,
    String? helperText,
    String? prefixText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? errorText,
  }) =>
      InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
      ).applyDefaults(Theme.of(context).inputDecorationTheme);

  static BoxDecoration fieldBox(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BoxDecoration(
      color: fillColor(brightness),
      borderRadius: borderRadius,
      border: Border.all(color: borderColor(brightness), width: 1),
    );
  }
}
