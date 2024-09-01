import 'package:json_annotation/json_annotation.dart';
import 'package:pecunia/util/sql_fun.dart';

part 'analytics.g.dart';

@JsonSerializable()
class Analytics {

  @JsonKey(fromJson: toInt)
  final int? group;
  @JsonKey(defaultValue: [])
  final List<Analytics>? subgroup;
  final String? category;
  final double? amount;
  final double? sum;

  const Analytics({
    this.group,
    this.subgroup,
    this.category,
    this.amount,
    this.sum,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsToJson(this);
}
