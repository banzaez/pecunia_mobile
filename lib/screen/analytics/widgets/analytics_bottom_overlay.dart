import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/analytics_filter.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/screen/home/home_panel_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date.dart';

class AnalyticsBottomOverlay extends ConsumerWidget {
  const AnalyticsBottomOverlay({
    super.key,
    required this.bottomSafe,
  });

  final double bottomSafe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(analyticsNotifierProvider);
    final baseColor = homeOverlayBaseColor(context);
    final panelColor = homePanelColor(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                baseColor.withValues(alpha: 0.0),
                panelColor,
              ],
            ),
          ),
          child: const SizedBox(height: 24, width: double.infinity),
        ),
        ColoredBox(
          color: panelColor,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 8 + bottomSafe),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSwitch(
                  onChange: (value) =>
                      ref.read(analyticsNotifierProvider.notifier).setFilter(value),
                  values: List.generate(
                    AnalyticsFilter.values.length,
                    (i) => AppSwitchValue(
                      label: AnalyticsFilter.values[i].label(l10n),
                      value: AnalyticsFilter.values[i],
                      color: i == 0
                          ? Colors.green
                          : i == 1
                              ? Colors.red
                              : null,
                    ),
                  ),
                  value: state.filter,
                ),
                AppSpaces.v16,
                PickDate(
                  onChanged: (value, type) =>
                      ref.read(analyticsNotifierProvider.notifier).setDate(value!, type),
                  initDate: state.date,
                  enableTime: false,
                  isYearSelected: state.period == DateType.year,
                  isMonthSelected: state.period == DateType.month,
                  isDaySelected: state.period == DateType.day,
                  valuesYear: state.valuesYear,
                  valuesMonth: state.valuesMonth,
                  valuesDay: state.valuesDay,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
