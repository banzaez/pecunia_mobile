import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color disable = Colors.grey;
  static const Color error = Colors.red;
  static const Color edit = Colors.red;

  static const MaterialColor primary = Colors.blue;

  static const Color borderColor = Colors.grey;

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white;

  static Color backgroundContent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.black12;
}
