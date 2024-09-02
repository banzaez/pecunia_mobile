import 'package:json_annotation/json_annotation.dart';
import 'package:pecunia/util/sql_fun.dart';

part 'analytics.g.dart';

@JsonSerializable()
class Analytics {

  @JsonKey(fromJson: toInt)
  final int group;
  final String? category;
  final double amount;
  final DateTime date;

  const Analytics({
    required this.group,
    this.category,
    required this.amount,
    required this.date,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsToJson(this);
}
