import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/analytics_filter.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/screen/analytics/widgets/analytics_graph.dart';
import 'package:pecunia/screen/home/home_panel_style.dart';
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
    final state = ref.watch(analyticsNotifierProvider);
    final locale = Localizations.localeOf(context).toString();
    final periodStr = state.periodStr(locale);
    final baseColor = homeOverlayBaseColor(context);
    final panelColor = homePanelColor(context);

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
                 if (state.category.isNotEmpty) ...[
                  AppSpaces.v8,
                  SizedBox(
                    height: graphHeight,
                    child: AnalyticsGraph(
                      data: state.category,
                      isTotal: state.filter == AnalyticsFilter.total,
                      totalSum: state.total,
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
