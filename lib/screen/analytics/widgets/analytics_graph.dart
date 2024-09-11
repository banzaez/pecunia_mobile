import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/ext_double.dart';

class AnalyticsGraph extends StatelessWidget {
  const AnalyticsGraph({super.key, required this.data, required this.isTotal});

  final bool isTotal;
  final List<Analytics> data;

  @override
  Widget build(BuildContext context) => PieChart(
    PieChartData(
      borderData: FlBorderData(
        show: false,
      ),
      sectionsSpace: 0,
      centerSpaceRadius: 0,
      sections: _graphItem(),
    ),
  );

  // ----------ITEM------------------------------------------------------------------------------

  Widget _badge({required String name, required Color color}) => Container(
        decoration: BoxDecoration(
          color: color,
          border: AppBorderStyle.borderSideBox,
          borderRadius: AppBorderStyle.borderRadius,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(name, style: AppTextStyle.text12w600(color: Colors.black)),
      );

  List<PieChartSectionData> _graphItem() => List.generate(data.length, (index) {
        final background = Colors.primaries[index % Colors.primaries.length];
        final item = data[index];
        return PieChartSectionData(
          color: background,
          badgeWidget: _badge(name: item.category?.name ?? "", color: background),
          badgePositionPercentageOffset: .98,
          radius: item.total.isNegative ? 100 : 80,
          title: item.total.formatSum,
          titleStyle: AppTextStyle.text12w400(),
          value: item.total.abs(),
        );
      });
}
