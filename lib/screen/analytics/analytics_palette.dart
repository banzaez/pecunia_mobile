import 'package:flutter/material.dart';
import 'package:pecunia/models/analytics_filter.dart';

abstract final class AnalyticsPalette {
  static const total = [
    Color(0xFF3F51B5),
    Color(0xFF673AB7),
    Color(0xFF00BCD4),
    Color(0xFF03A9F4),
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
    Color(0xFF2196F3),
  ];

  static const income = [
    Color(0xFF2E7D32),
    Color(0xFF00796B),
    Color(0xFF4CAF50),
    Color(0xFF009688),
    Color(0xFF81C784),
    Color(0xFF66BB6A),
  ];

  static const expense = [
    Color(0xFFC62828),
    Color(0xFFD84315),
    Color(0xFFE64A19),
    Color(0xFFF4511E),
    Color(0xFFE57373),
    Color(0xFFF57C00),
  ];

  static List<Color> forFilter(AnalyticsFilter filter, [List<double>? totals]) {
    return switch (filter) {
      AnalyticsFilter.income => income,
      AnalyticsFilter.expenses => expense,
      AnalyticsFilter.total => total,
    };
  }

  static Color colorAt(List<Color> palette, int index) => palette[index % palette.length];
}
