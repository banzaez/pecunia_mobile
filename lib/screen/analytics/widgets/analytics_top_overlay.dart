import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_graph.dart';
import 'package:pecunia/styles/app_panel_style.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';

class AnalyticsTopOverlay extends ConsumerWidget {
  const AnalyticsTopOverlay({
    super.key,
    required this.fadeHeight,
    this.graphHeight = 220,
  });

  final double fadeHeight;
  final double graphHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    final category = ref.watch(analyticsNotifierProvider.select((s) => s.category));
    final filter = ref.watch(analyticsNotifierProvider.select((s) => s.filter));
    final total = ref.watch(analyticsNotifierProvider.select((s) => s.total));
    final isLoading = ref.watch(analyticsNotifierProvider.select((s) => s.isLoading));
    final periodStr = ref.watch(
      analyticsNotifierProvider.select((s) => s.periodStr(locale)),
    );
    final baseColor = appOverlayBaseColor(context);
    final panelColor = appPanelColor(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ColoredBox(
          color: panelColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.analyticsCategoryPeriod(periodStr),
                  style: AppTextStyle.text14w400(),
                  textAlign: TextAlign.center,
                ),
                if (category.isNotEmpty) ...[
                  AppSpaces.v8,
                  SizedBox(
                    height: graphHeight,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity == null) return;
                              if (details.primaryVelocity! < 0) {
                                // Swipe left -> Next period
                                ref.read(analyticsNotifierProvider.notifier).shiftPeriod(1);
                              } else if (details.primaryVelocity! > 0) {
                                // Swipe right -> Previous period
                                ref.read(analyticsNotifierProvider.notifier).shiftPeriod(-1);
                              }
                            },
                            child: AnalyticsGraph(
                              data: category,
                              filter: filter,
                              totalSum: total,
                            ),
                          ),
                        ),
                        if (isLoading)
                          const Positioned.fill(
                            child: Center(
                              child: SizedBox(
                                width: 28,
                                height: 28,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                panelColor,
                baseColor.withValues(alpha: 0.0),
              ],
            ),
          ),
          child: SizedBox(height: fadeHeight, width: double.infinity),
        ),
      ],
    );
  }
}
