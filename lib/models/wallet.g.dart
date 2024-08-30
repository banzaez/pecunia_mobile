// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      currency: json['currency'] as String?,
      description: json['description'] as String?,
      showBalance: json['showBalance'] as bool?,
      round: json['round'] as bool?,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currency': instance.currency,
      'description': instance.description,
      'showBalance': instance.showBalance,
      'round': instance.round,
    };
