import 'package:json_annotation/json_annotation.dart';
import 'package:pecunia/models/finance_category.dart';
import 'package:pecunia/util/sql_fun.dart';

part 'analytics.g.dart';

@JsonSerializable()
class Analytics {

  @JsonKey(fromJson: toInt)
  final int group;
  @JsonKey(name: "category_id", fromJson: toCategory, toJson: fromCategory)
  final FinanceCategory? category;
  final double amount;
  final DateTime date;
  @JsonKey(name: "id")
  final int count;

  const Analytics({
    required this.group,
    this.category,
    required this.amount,
    required this.date,
    required this.count,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsToJson(this);
}
