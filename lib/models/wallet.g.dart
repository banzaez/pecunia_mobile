// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
  id: (json['_id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String,
  currency: toCurrency(json['currency'] as String),
  description: json['description'] as String,
  showBalance: json['showBalance'] == null
      ? true
      : Wallet.boolFromSql(json['showBalance']),
  isRoundUp: json['isRoundUp'] == null
      ? true
      : Wallet.boolFromSql(json['isRoundUp']),
)..category = toCategory((json['category_id'] as num?)?.toInt());

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'category_id': fromCategory(instance.category),
  'currency': fromCurrency(instance.currency),
  'description': instance.description,
  'showBalance': Wallet.boolToSql(instance.showBalance),
  'isRoundUp': Wallet.boolToSql(instance.isRoundUp),
};
