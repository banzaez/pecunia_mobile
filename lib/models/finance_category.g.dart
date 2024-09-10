// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinanceCategory _$FinanceCategoryFromJson(Map<String, dynamic> json) =>
    FinanceCategory(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      subcategories: (json['subcategories'] as List<dynamic>)
          .map((e) => FinanceCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FinanceCategoryToJson(FinanceCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subcategories': instance.subcategories,
    };
