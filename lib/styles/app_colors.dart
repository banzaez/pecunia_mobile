import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color disable = Colors.grey;
  static const Color error = Colors.red;
  static const Color edit = Colors.red;

  static const Color income = Color(0xFF3D9A5F);
  static const Color expense = Color(0xFFC75C5C);

  static const Color incomeBright = Color(0xFF34C759);
  static const Color incomeBrightDark = Color(0xFF30D158);
  static const Color expenseBright = Color(0xFFC62828);
  static const Color expenseBrightDark = Color(0xFFC62828);

  static Color incomeOnSurface(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? incomeBrightDark : incomeBright;
  }

  static Color expenseOnSurface(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white : Colors.black87;
  }

  static Color neutralSecondary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white60 : Colors.black54;
  }

  static const Color accentIndigo = Color(0xFF3F51B5);

  static const MaterialColor primary = Colors.blue;

  static const Color borderColor = Colors.grey;

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white;

  static Color backgroundContent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.black12;
}
