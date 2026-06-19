import 'package:flutter/material.dart';
import 'package:pecunia/styles/app_panel_style.dart';

/// Градиентное затемнение края прокручиваемого списка.
class ListEdgeFade extends StatelessWidget {
  const ListEdgeFade({
    super.key,
    required this.height,
    this.top = false,
    this.forBottomNav = false,
  });

  final double height;

  /// `false` — затемнение снизу (прозрачный → панель).
  /// `true` — затемнение сверху (панель → прозрачный).
  final bool top;

  /// Многоступенчатый градиент над нижней панелью навигации.
  final bool forBottomNav;

  @override
  Widget build(BuildContext context) {
    final baseColor = appOverlayBaseColor(context);
    final panelColor = appPanelColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Gradient gradient;
    if (forBottomNav && !top) {
      gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          baseColor.withValues(alpha: 0),
          panelColor.withValues(alpha: isDark ? 0.35 : 0.4),
          panelColor.withValues(alpha: isDark ? 0.75 : 0.82),
          panelColor,
        ],
        stops: const [0.0, 0.38, 0.72, 1.0],
      );
    } else {
      gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: top
            ? [panelColor, baseColor.withValues(alpha: 0)]
            : [baseColor.withValues(alpha: 0), panelColor],
      );
    }

    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: gradient),
        child: SizedBox(height: height, width: double.infinity),
      ),
    );
  }
}
