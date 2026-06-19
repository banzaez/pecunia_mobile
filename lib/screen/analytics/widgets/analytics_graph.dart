import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/models/analytics_filter.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/screen/analytics/analytics_palette.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/ext_double.dart';

class AnalyticsGraph extends ConsumerStatefulWidget {
  const AnalyticsGraph({
    super.key,
    required this.data,
    required this.filter,
    required this.totalSum,
  });

  final List<Analytics> data;
  final AnalyticsFilter filter;
  final double totalSum;

  @override
  ConsumerState<AnalyticsGraph> createState() => _AnalyticsGraphState();
}

class _AnalyticsGraphState extends ConsumerState<AnalyticsGraph> {
  double? _oldValue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final selectedIndex = ref.watch(selectedCategoryIndexProvider);

    final bool hasSelection =
        selectedIndex != null && selectedIndex >= 0 && selectedIndex < widget.data.length;
    final String centerLabel = hasSelection
        ? (widget.data[selectedIndex].category?.localizedName(l10n) ?? '').toUpperCase()
        : l10n.analyticsTotalPeriod.toUpperCase();

    final double targetValue =
        hasSelection ? widget.data[selectedIndex].total : widget.totalSum;

    final double beginValue = _oldValue ?? targetValue;
    _oldValue = targetValue;

    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
          key: ValueKey(widget.data.length),
          PieChartData(
            borderData: FlBorderData(show: false),
            sectionsSpace: 3,
            centerSpaceRadius: 65,
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  return;
                }
                final touchedSectionIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
                if (touchedSectionIndex >= 0 &&
                    touchedSectionIndex < widget.data.length) {
                  if (event is FlTapUpEvent) {
                    final current = ref.read(selectedCategoryIndexProvider);
                    ref.read(selectedCategoryIndexProvider.notifier).setIndex(
                          current == touchedSectionIndex ? null : touchedSectionIndex,
                        );
                  }
                }
              },
            ),
            sections: _graphItem(selectedIndex),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                centerLabel,
                style: AppTextStyle.text10w600(
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              TweenAnimationBuilder<double>(
                key: ValueKey(centerLabel),
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                tween: Tween<double>(begin: beginValue, end: targetValue),
                builder: (context, value, child) {
                  return Text(
                    value.formatSum,
                    style: AppTextStyle.text22w400(
                      color: isDark ? Colors.white : Colors.black87,
                    ).copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }

  List<PieChartSectionData> _graphItem(int? selectedIndex) {
    final palette = AnalyticsPalette.forFilter(widget.filter);

    return List.generate(widget.data.length, (index) {
      final color = AnalyticsPalette.colorAt(palette, index);
      final item = widget.data[index];
      final isTouched = index == selectedIndex;
      final radius = isTouched ? 24.0 : 16.0;

      return PieChartSectionData(
        color: isTouched ? color : color.withValues(alpha: 0.85),
        showTitle: false,
        radius: radius,
        value: item.total.abs(),
      );
    });
  }
}
