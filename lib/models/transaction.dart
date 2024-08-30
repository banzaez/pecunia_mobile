import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  @JsonKey(name: "_id")
  final int id;
  final int walletId;
  final double amount;
  final String category;

  const Transaction({
    required this.id,
    required this.walletId,
    required this.amount,
    required this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
