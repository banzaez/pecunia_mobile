// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: (json['_id'] as num?)?.toInt() ?? 0,
      walletId: (json['wallet_id'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      categoryId: (json['category_id'] as num).toInt(),
      createdAt: toDateTime(json['created_at']),
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'wallet_id': instance.walletId,
      'amount': instance.amount,
      'category': instance.category,
      'category_id': instance.categoryId,
      'created_at': fromDateTime(instance.createdAt),
      'description': instance.description,
    };
