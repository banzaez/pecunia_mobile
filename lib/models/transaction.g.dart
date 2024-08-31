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
      createdAt: toDateTime(json['created_at']),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'wallet_id': instance.walletId,
      'amount': instance.amount,
      'category': instance.category,
      'created_at': fromDateTime(instance.createdAt),
    };
