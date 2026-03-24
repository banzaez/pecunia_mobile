// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) => Analytics(
  toCategory((json['category'] as num?)?.toInt()),
  (json['total'] as num).toDouble(),
  Analytics._parseDate(json['date'] as String),
  (json['count'] as num).toInt(),
);

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
  'category': fromCategory(instance.category),
  'total': instance.total,
  'date': instance.date.toIso8601String(),
  'count': instance.count,
};
