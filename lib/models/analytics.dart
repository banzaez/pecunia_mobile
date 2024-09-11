import 'package:json_annotation/json_annotation.dart';
import 'package:pecunia/models/finance_category.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/sql_fun.dart';

part 'analytics.g.dart';

@JsonSerializable()
class Analytics {
  @JsonKey(fromJson: toInt)
  final int year;
  @JsonKey(fromJson: toInt)
  final int month;
  @JsonKey(fromJson: toInt)
  final int day;
  @JsonKey(fromJson: toCategory, toJson: fromCategory)
  final FinanceCategory? category;
  final double total;
  final DateTime date;
  final int count;

  Analytics(
    this.year,
    this.month,
    this.day,
    this.category,
    this.total,
    this.date,
    this.count,
  );

  DateTime get startOfYear => date.startOfYear;
  DateTime get startOfMonth => date.startOfMonth;
  DateTime get startOfDay => date.startOfDay;

  factory Analytics.fromJson(Map<String, dynamic> json) => _$AnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsToJson(this);
}
