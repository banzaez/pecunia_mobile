import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Стили системных панелей (status bar, navigation bar) в соответствии с темой.
abstract final class AppSystemUi {
  static Future<void> configure() => SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
      );

  static SystemUiOverlayStyle overlayFor(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final barColor = isDark ? Colors.black : Colors.white;

    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: barColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarContrastEnforced: false,
    );
  }

  static Widget wrap(BuildContext context, Widget? child) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayFor(Theme.of(context).brightness),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
