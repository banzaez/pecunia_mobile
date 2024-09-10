// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) => Analytics(
      group: toInt(json['group'] as String),
      category: toCategory((json['category_id'] as num?)?.toInt()),
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      count: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
      'group': instance.group,
      'category_id': fromCategory(instance.category),
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'id': instance.count,
    };
