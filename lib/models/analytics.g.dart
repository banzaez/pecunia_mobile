// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) => Analytics(
      toInt(json['year'] as String),
      toInt(json['month'] as String),
      toInt(json['day'] as String),
      toCategory((json['category'] as num?)?.toInt()),
      (json['total'] as num).toDouble(),
      DateTime.parse(json['date'] as String),
      (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'category': fromCategory(instance.category),
      'total': instance.total,
      'date': instance.date.toIso8601String(),
      'count': instance.count,
    };
