import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get theme => ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
        dialogBackgroundColor: Colors.white,
        elevatedButtonTheme: _elevatedButtonTheme,
        primarySwatch: AppColors.primary,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: Colors.white,
          secondary: AppColors.primary,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        fontFamily: GoogleFonts.openSans().fontFamily,
      );

  static ThemeData get darkTheme => ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.black,
        ),
        dialogBackgroundColor: Colors.black,
        elevatedButtonTheme: _elevatedButtonTheme,
        primarySwatch: AppColors.primary,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primary,
          onPrimary: Colors.black,
          secondary: AppColors.primary,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.black,
          onSurface: Colors.white,
        ),
        fontFamily: GoogleFonts.openSans().fontFamily,
      );

  // --------------------------------------------------------------------------------------------

  static ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white10,
          textStyle: AppTextStyle.text16w400(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
}
