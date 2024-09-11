import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  AppTextStyle._();

  static baseStyle({
    Color? color,
    required double fontSize,
    FontWeight? fontWeight,
  }) =>
      GoogleFonts.openSans(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
      );

  //---------------------------------------------------------------------------------------------

  static TextStyle text8w400({Color? color}) => baseStyle(color: color, fontSize: 8, fontWeight: FontWeight.w400);

  static TextStyle text8w600({Color? color}) => baseStyle(color: color, fontSize: 8, fontWeight: FontWeight.w600);

  static TextStyle text10w400({Color? color}) => baseStyle(color: color, fontSize: 10, fontWeight: FontWeight.w400);

  static TextStyle text10w600({Color? color}) => baseStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600);

  static TextStyle text12w400({Color? color}) => baseStyle(color: color, fontSize: 12, fontWeight: FontWeight.w400);

  static TextStyle text12w600({Color? color}) => baseStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600);

  static TextStyle text14w400({Color? color}) => baseStyle(color: color, fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle text14w600({Color? color}) => baseStyle(color: color, fontSize: 14, fontWeight: FontWeight.w600);

  static TextStyle text14w700({Color? color}) => baseStyle(color: color, fontSize: 14, fontWeight: FontWeight.w700);

  static TextStyle text15w600({Color? color}) => baseStyle(color: color, fontSize: 15, fontWeight: FontWeight.w600);

  static TextStyle text16w400({Color? color}) => baseStyle(color: color, fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle text16w600({Color? color}) => baseStyle(color: color, fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle text18w400({Color? color}) => baseStyle(color: color, fontSize: 18, fontWeight: FontWeight.w400);

  static TextStyle text18w700({Color? color}) => baseStyle(color: color, fontSize: 18, fontWeight: FontWeight.w700);

  static TextStyle text22w400({Color? color}) => baseStyle(color: color, fontSize: 22, fontWeight: FontWeight.w400);

  static TextStyle text24w400({Color? color}) => baseStyle(color: color, fontSize: 24, fontWeight: FontWeight.w400);

  static TextStyle text24w600({Color? color}) => baseStyle(color: color, fontSize: 24, fontWeight: FontWeight.w600);

  static TextStyle text24w700({Color? color}) => baseStyle(color: color, fontSize: 24, fontWeight: FontWeight.w700);

  static TextStyle text32w400({Color? color}) => baseStyle(color: color, fontSize: 32, fontWeight: FontWeight.w400);

  static TextStyle text32w600({Color? color}) => baseStyle(color: color, fontSize: 32, fontWeight: FontWeight.w600);

  static TextStyle text64w700({Color? color}) => baseStyle(color: color, fontSize: 64, fontWeight: FontWeight.bold);

}
