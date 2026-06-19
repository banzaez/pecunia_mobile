import 'package:flutter/material.dart';

Color appPanelColor(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final baseColor = isDark ? Colors.black : Colors.white;
  return baseColor.withValues(alpha: isDark ? 0.82 : 0.9);
}

Color appOverlayBaseColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white;
