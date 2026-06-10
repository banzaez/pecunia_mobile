import 'package:json_annotation/json_annotation.dart';

part 'analytics_total.g.dart';

@JsonSerializable()
class AnalyticsTotal {
  @JsonKey(defaultValue: 0)
  final double total;
  @JsonKey(defaultValue: 0)
  final double income;
  @JsonKey(defaultValue: 0)
  final double expense;

  const AnalyticsTotal(
    this.total,
    this.income,
    this.expense,
  );

  factory AnalyticsTotal.fromJson(Map<String, dynamic> json) => _$AnalyticsTotalFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsTotalToJson(this);
}
