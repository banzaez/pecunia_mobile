import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/ext_double.dart';

class AnalyticsGraph extends StatelessWidget {
  const AnalyticsGraph({super.key, required this.data, required this.isTotal});

  final List<Analytics> data;
  final bool isTotal;

  @override
  Widget build(BuildContext context) => PieChart(
    PieChartData(
      borderData: FlBorderData(
        show: false,
      ),
      sectionsSpace: 0,
      centerSpaceRadius: 0,
      sections: _graphItem(context),
    ),
  );

  // ----------ITEM------------------------------------------------------------------------------

  Widget _badge({required BuildContext context, required String name, required Color color}) =>
      Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppBorderStyle.borderRadius,
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(name, style: AppTextStyle.text12w600(color: Colors.black)),
      );

  List<PieChartSectionData> _graphItem(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return List.generate(data.length, (index) {
      final background = Colors.primaries[index % Colors.primaries.length];
      final item = data[index];
      return PieChartSectionData(
        color: background,
        badgeWidget: _badge(
          context: context,
          name: item.category?.localizedName(l10n) ?? "",
          color: background,
        ),
        badgePositionPercentageOffset: .98,
        radius: isTotal ?  item.total.isNegative ? 100 : 80 : 100,
        title: item.total.formatSum,
        titleStyle: AppTextStyle.text10w600(),
        value: item.total.abs(),
      );
    });
  }
}
