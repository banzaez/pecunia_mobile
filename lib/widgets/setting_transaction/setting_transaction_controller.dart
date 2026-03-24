import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/finance_category.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/widgets/fields/category_field.dart';
import 'package:pecunia/widgets/fields/number_field.dart';

class SettingTransactionController extends BaseController {
  SettingTransactionController({required TransactionType type, Transaction? transaction}) {
    _type.value = type;
    this.transaction = transaction ?? Transaction.empty();
  }

  final TransactionController _transactionController = Get.find();

  late final Transaction transaction;

  final NumberEditingController amount = NumberEditingController();
  final TextEditingController description = TextEditingController();
  final Rx<DateTime> datetime = Rx<DateTime>(DateTime.now());

  final Rxn<FinanceCategory> _category = Rxn();
  FinanceCategory? get category => _category.value;
  set category(FinanceCategory? value) {
    _category.value = value;
    subcategory = null;
  }

  final Rxn<FinanceCategory> _subcategory = Rxn();
  FinanceCategory? get subcategory => _subcategory.value;
  set subcategory(FinanceCategory? value) => _subcategory.value = value;

  final Rx<TransactionType> _type = TransactionType.income.obs;
  TransactionType get type => _type.value;

  set type(TransactionType type) {
    category = null;
    _type.value = type;
  }

  final errorAmount = RxnString();
  final errorCategory = RxnString();

  bool get hasError => errorAmount.value != null || errorCategory.value != null;

  // ----------INIT------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    type = transaction.id == 0 ? type : transaction.type;
    amount.number = transaction.id == 0 ? null : transaction.amount.abs();
    category = transaction.category;
    subcategory = transaction.subcategory;
    description.text = transaction.description;
    datetime.value = transaction.createdAt;
  }

  // ----------VALUES----------------------------------------------------------------------------

  void updateValues() {
    transaction.amount = (amount.number * type.i).toDouble();
    transaction.category = category;
    transaction.subcategory = subcategory;
    transaction.description = description.text;
    transaction.createdAt = datetime.value;
  }

  bool isOk() {
    errorAmount.value = amount.text.isEmpty ? "tran_item_error_amount".tr : null;
    errorCategory.value = category == null ? "tran_item_error_category".tr : null;

    return !hasError;
  }

  // ----------SQL-------------------------------------------------------------------------------

  bool save() {
    if (!isOk()) return false;
    updateValues();

    transaction.id == 0
        ? _transactionController.addSQL(transaction)
        : _transactionController.updateSQL(transaction);

    return true;
  }
}
