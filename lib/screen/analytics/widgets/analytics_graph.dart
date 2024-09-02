import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/styles/app_text_style.dart';

class AnalyticsGraph extends StatelessWidget {
  const AnalyticsGraph({super.key, required this.data});

  final List<Analytics> data;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 200,
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: _graphItem(),
          ),
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
        return PieChartSectionData(
          color: background,
          badgeWidget: _badge(name: data[index].category ?? "", color: background),
          badgePositionPercentageOffset: .98,
          showTitle: false,
          radius: 100,
          title: data[index].category,
          value: data[index].amount,
        );
      });
}
