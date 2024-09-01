import 'package:json_annotation/json_annotation.dart';

part 'analytics.g.dart';

@JsonSerializable()
class Analytics {
  final int? year;
  final int? month;
  final int? day;
  final String? category;
  final int? sum;

  const Analytics({
    this.year,
    this.month,
    this.day,
    this.category,
    this.sum,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsToJson(this);
}
