import 'package:currency_picker/currency_picker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pecunia/models/finance_category.dart';
import 'package:pecunia/util/sql_fun.dart';

part 'wallet.g.dart';

@JsonSerializable()
class Wallet {
  @JsonKey(name: "_id")
  int id;
  String name;
  @JsonKey(name: "category_id", fromJson: toCategory, toJson: fromCategory)
  FinanceCategory? category;
  @JsonKey(fromJson: toCurrency, toJson: fromCurrency)
  Currency? currency;
  String description;
  bool showBalance;
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
        currency: null,
        description: "",
        showBalance: true,
        isRoundUp: true,
      );

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);

  @override
  String toString() => "id: $id, name: $name, currency: $currency, description: $description";
}
