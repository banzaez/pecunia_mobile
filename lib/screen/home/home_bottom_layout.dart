import 'package:flutter/material.dart';
import 'package:pecunia/styles/bottom_overlay_layout.dart';

/// Отступы нижней панели Home.
abstract final class HomeBottomLayout {
  static double bottomInset(BuildContext context) =>
      BottomOverlayLayout.bottomInset(context);
}
