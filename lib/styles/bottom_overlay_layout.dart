import 'package:flutter/material.dart';

/// Общие константы нижних оверлеев (Home, Analytics).
abstract final class BottomOverlayLayout {
  static const extraBottomInset = 12.0;

  static double bottomInset(BuildContext context) {
    final systemBottom = MediaQuery.viewPaddingOf(context).bottom;
    return systemBottom + extraBottomInset;
  }
}
