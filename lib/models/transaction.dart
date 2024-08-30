import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  @JsonKey()
  final int id;
  final int? walletId;
  final double? amount;
  final String? category;

  const Transaction({
    required this.id,
    this.walletId,
    this.amount,
    this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
