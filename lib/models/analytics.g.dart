// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) => Analytics(
      group: toInt(json['group'] as String),
      subgroup: (json['subgroup'] as List<dynamic>?)
              ?.map((e) => Analytics.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      category: json['category'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      sum: (json['sum'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
      'group': instance.group,
      'subgroup': instance.subgroup,
      'category': instance.category,
      'amount': instance.amount,
      'sum': instance.sum,
    };
