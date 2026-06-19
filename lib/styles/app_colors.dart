import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color disable = Colors.grey;
  static const Color error = Colors.red;
  static const Color edit = Colors.red;

  static const Color income = Color(0xFF3D9A5F);
  static const Color expense = Color(0xFFC75C5C);

  static const MaterialColor primary = Colors.blue;

  static const Color borderColor = Colors.grey;

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white;

  static Color backgroundContent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.black12;
}
