import 'package:json_annotation/json_annotation.dart';

part 'wallet.g.dart';

@JsonSerializable()
class Wallet {
  final int id;
  final String? name;
  final String? currency;
  final String? description;
  final bool? showBalance;
  final bool? round;

  const Wallet({
    required this.id,
    this.name,
    this.currency,
    this.description,
    this.showBalance,
    this.round,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
