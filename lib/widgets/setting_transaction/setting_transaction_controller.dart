import 'package:flutter/material.dart';
import 'package:pecunia/models/finance_category.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/models/transaction_type.dart';
import 'package:pecunia/widgets/fields/number_field.dart';

/// Чистый ChangeNotifier — заменяет GetxController для SettingTransaction формы.
class SettingTransactionController extends ChangeNotifier {
  SettingTransactionController({required TransactionType type, Transaction? transaction}) {
    _type = type;
    this.transaction = transaction ?? Transaction.empty();
    _init();
  }

  late Transaction transaction;

  final NumberEditingController amount = NumberEditingController();
  final TextEditingController description = TextEditingController();
  DateTime datetime = DateTime.now();

  FinanceCategory? _category;
  FinanceCategory? get category => _category;
  set category(FinanceCategory? value) {
    _category = value;
    _subcategory = null;
    notifyListeners();
  }

  FinanceCategory? _subcategory;
  FinanceCategory? get subcategory => _subcategory;
  set subcategory(FinanceCategory? value) {
    _subcategory = value;
    notifyListeners();
  }

  TransactionType _type = TransactionType.income;
  TransactionType get type => _type;
  set type(TransactionType value) {
    category = null;
    _type = value;
    notifyListeners();
  }

  String? errorAmount;
  String? errorCategory;

  // ----------INIT------------------------------------------------------------------------------

  void _init() {
    _type = transaction.id == 0 ? _type : transaction.type;
    amount.number = transaction.id == 0 ? 0 : transaction.amount.abs();
    _category = transaction.category;
    _subcategory = transaction.subcategory;
    description.text = transaction.description;
    datetime = transaction.createdAt;
  }

  @override
  void dispose() {
    amount.dispose();
    description.dispose();
    super.dispose();
  }

  // ----------VALUES----------------------------------------------------------------------------

  void updateValues() {
    transaction.amount = (amount.number * type.i).toDouble();
    transaction.category = _category;
    transaction.subcategory = _subcategory;
    transaction.description = description.text;
    transaction.createdAt = datetime;
  }

  bool isOk(String amountError, String categoryError) {
    errorAmount = amount.text.isEmpty ? amountError : null;
    errorCategory = _category == null ? categoryError : null;
    notifyListeners();
    return errorAmount == null && errorCategory == null;
  }

  void setDatetime(DateTime value) {
    datetime = value;
    notifyListeners();
  }
}
