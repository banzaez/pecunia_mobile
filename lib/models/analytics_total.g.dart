// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_total.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsTotal _$AnalyticsTotalFromJson(Map<String, dynamic> json) =>
    AnalyticsTotal(
      (json['total'] as num).toDouble(),
      (json['income'] as num).toDouble(),
      (json['expense'] as num).toDouble(),
    );

Map<String, dynamic> _$AnalyticsTotalToJson(AnalyticsTotal instance) =>
    <String, dynamic>{
      'total': instance.total,
      'income': instance.income,
      'expense': instance.expense,
    };
