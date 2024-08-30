// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      name: json['name'] as String,
      currency: json['currency'] as String,
      description: json['description'] as String,
      showBalance: toBoolean(json['showBalance']),
      isRoundUp: toBoolean(json['isRoundUp']),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'name': instance.name,
      'currency': instance.currency,
      'description': instance.description,
      'showBalance': fromBoolean(instance.showBalance),
      'isRoundUp': fromBoolean(instance.isRoundUp),
    };
