import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  AppColors._();

  static const Color disable = Colors.grey;
  static const Color error = Colors.red;
  static const Color edit = Colors.red;

  static const MaterialColor primary = Colors.blue;

  static const Color borderColor = Colors.grey;

  static Color get background => Get.isDarkMode ? Colors.black : Colors.white;

  static Color get backgroundContent => Get.isDarkMode ? Colors.white10 : Colors.black12;
}
