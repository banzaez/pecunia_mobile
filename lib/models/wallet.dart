import 'package:json_annotation/json_annotation.dart';
import 'package:pecunia/util/sql_fun.dart';

part 'wallet.g.dart';

@JsonSerializable()
class Wallet {
  @JsonKey(name: "_id")
  int id;
  String name;
  String currency;
  String description;
  @JsonKey(fromJson: toBoolean, toJson: fromBoolean)
  bool showBalance;
  @JsonKey(fromJson: toBoolean, toJson: fromBoolean)
  bool isRoundUp;

  Wallet({
    this.id = 0,
    required this.name,
    required this.currency,
    required this.description,
    required this.showBalance,
    required this.isRoundUp,
  });

  factory Wallet.empty() => Wallet(
        name: "",
        currency: "",
        description: "",
        showBalance: false,
        isRoundUp: false,
      );

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);

  @override
  String toString() => "id: $id, name: $name, currency: $currency, description: $description";
}
