// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) => Analytics(
      group: toInt(json['group'] as String),
      category: json['category'] as String?,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      count: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
      'group': instance.group,
      'category': instance.category,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'id': instance.count,
    };
