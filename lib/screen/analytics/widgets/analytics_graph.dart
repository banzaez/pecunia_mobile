import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/screen/analytics/analytics_controller.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/ext_double.dart';

class AnalyticsGraph extends ConsumerWidget {
  const AnalyticsGraph({
    super.key,
    required this.data,
    required this.isTotal,
    required this.totalSum,
  });

  final List<Analytics> data;
  final bool isTotal;
  final double totalSum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final selectedIndex = ref.watch(selectedCategoryIndexProvider);

    // If an item is selected, display its details in the center, otherwise the grand total.
    final bool hasSelection = selectedIndex != null && selectedIndex >= 0 && selectedIndex < data.length;
    final String centerLabel = hasSelection 
        ? (data[selectedIndex].category?.localizedName(l10n) ?? "").toUpperCase()
        : l10n.analyticsTotalPeriod.toUpperCase();
    final String centerValue = hasSelection 
        ? data[selectedIndex].total.formatSum
        : totalSum.formatSum;

    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          key: ValueKey(data.length),
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
                final touchedSectionIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                if (touchedSectionIndex >= 0 && touchedSectionIndex < data.length) {
                  // Only respond on tap/click
                  if (event is FlTapUpEvent) {
                    final current = ref.read(selectedCategoryIndexProvider);
                    ref.read(selectedCategoryIndexProvider.notifier).setIndex(
                        current == touchedSectionIndex ? null : touchedSectionIndex);
                  }
                }
              },
            ),
            sections: _graphItem(context, selectedIndex),
          ),
        ),
        // Central summary text
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
              Text(
                centerValue,
                style: AppTextStyle.text22w400(
                  color: isDark ? Colors.white : Colors.black87,
                ).copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _graphItem(BuildContext context, int? selectedIndex) {
    final bool isIncome = data.isNotEmpty && data.first.total > 0;
    
    // Modern palettes with beautiful, professional color matching
    final palette = isTotal 
        ? [
            const Color(0xFF3F51B5), // Indigo
            const Color(0xFF673AB7), // Deep Purple
            const Color(0xFF00BCD4), // Cyan
            const Color(0xFF03A9F4), // Light Blue
            const Color(0xFFE91E63), // Pink
            const Color(0xFF9C27B0), // Purple
            const Color(0xFF2196F3), // Blue
          ]
        : isIncome 
            ? [
                const Color(0xFF2E7D32), // Emerald
                const Color(0xFF00796B), // Teal
                const Color(0xFF4CAF50), // Green
                const Color(0xFF009688), // Mint
                const Color(0xFF81C784), // Light Green
                const Color(0xFF66BB6A), 
              ]
            : [
                const Color(0xFFC62828), // Deep Red
                const Color(0xFFD84315), // Deep Orange
                const Color(0xFFE64A19), // Orange Red
                const Color(0xFFF4511E), // Coral
                const Color(0xFFE57373), // Rose
                const Color(0xFFF57C00), // Orange
              ];

    return List.generate(data.length, (index) {
      final color = palette[index % palette.length];
      final item = data[index];
      final isTouched = index == selectedIndex;
      
      // Enlarge the sector on touch
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
