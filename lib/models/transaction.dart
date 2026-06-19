import 'package:json_annotation/json_annotation.dart';
import 'package:pecunia/models/finance_category.dart';
import 'package:pecunia/util/sql_fun.dart';
import 'package:pecunia/models/transaction_type.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  @JsonKey(name: "_id")
  final int id;
  @JsonKey(name: "wallet_id")
  int walletId;
  double amount;
  @JsonKey(name: "category_id", fromJson: toCategory, toJson: fromCategory)
  FinanceCategory? category;
  @JsonKey(name: "subcategory_id", fromJson: toCategory, toJson: fromCategory)
  FinanceCategory? subcategory;
  @JsonKey(name: "created_at", fromJson: toDateTime, toJson: fromDateTime)
  DateTime createdAt;
  @JsonKey(defaultValue: "")
  String description;

  Transaction({
    this.id = 0,
    required this.walletId,
    required this.amount,
    this.category,
    this.subcategory,
    required this.createdAt,
    required this.description,
  });

  TransactionType get type => amount > 0 ? TransactionType.income : TransactionType.expense;

  factory Transaction.empty() => Transaction(
        walletId: 0,
        amount: 0,
        createdAt: DateTime.now(),
        description: "",
      );

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  String toString() =>
      'Transaction(id: $id, walletId: $walletId, amount: $amount, '
      'category: ${category?.name}, createdAt: $createdAt)';
}
