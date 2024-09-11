import 'package:json_annotation/json_annotation.dart';

part 'analytics_total.g.dart';

@JsonSerializable()
class AnalyticsTotal {
  final double total;
  final double income;
  final double expense;

  AnalyticsTotal(
    this.total,
    this.income,
    this.expense,
  );

  factory AnalyticsTotal.fromJson(Map<String, dynamic> json) => _$AnalyticsTotalFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsTotalToJson(this);
}
