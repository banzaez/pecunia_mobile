import 'package:json_annotation/json_annotation.dart';
import 'package:pecunia/controllers/sql_controller.dart';

part 'wallet.g.dart';

@JsonSerializable()
class Wallet {
  @JsonKey(name: "_id")
  final int id;
  final String name;
  final String currency;
  final String description;
  @JsonKey(fromJson: toBoolean, toJson: fromBoolean)
  final bool showBalance;
  @JsonKey(fromJson: toBoolean, toJson: fromBoolean)
  final bool isRoundUp;

  const Wallet({
    required this.id,
    required this.name,
    required this.currency,
    required this.description,
    required this.showBalance,
    required this.isRoundUp,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
