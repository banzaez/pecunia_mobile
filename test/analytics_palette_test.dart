import 'package:flutter_test/flutter_test.dart';
import 'package:pecunia/screen/analytics/analytics_palette.dart';
import 'package:pecunia/models/analytics_filter.dart';

void main() {
  test('AnalyticsPalette returns distinct palettes per filter', () {
    expect(
      AnalyticsPalette.forFilter(AnalyticsFilter.income),
      AnalyticsPalette.income,
    );
    expect(
      AnalyticsPalette.forFilter(AnalyticsFilter.expenses),
      AnalyticsPalette.expense,
    );
    expect(
      AnalyticsPalette.forFilter(AnalyticsFilter.total),
      AnalyticsPalette.total,
    );
  });

  test('AnalyticsPalette.colorAt wraps around palette length', () {
    final palette = AnalyticsPalette.income;
    expect(
      AnalyticsPalette.colorAt(palette, palette.length),
      palette.first,
    );
  });
}
