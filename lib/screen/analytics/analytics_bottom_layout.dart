import 'package:flutter/material.dart';
import 'package:pecunia/styles/bottom_overlay_layout.dart';

/// Отступы нижней панели Analytics.
abstract final class AnalyticsBottomLayout {
  static const panelPadding = 8.0;

  static double bottomInset(BuildContext context) =>
      BottomOverlayLayout.bottomInset(context);
}
