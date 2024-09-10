import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/finance_category.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/widgets/fields/category_field.dart';
import 'package:pecunia/widgets/fields/number_field.dart';


class SettingTransactionController extends BaseController {
  SettingTransactionController([this.transaction]);

  final TransactionController _transactionController = Get.find();

  final Transaction? transaction;

  final NumberEditingController amount = NumberEditingController();
  final Rxn<FinanceCategory> category = Rxn();
  final TextEditingController controllerDescription = TextEditingController();
  final Rx<DateTime> datetime = Rx<DateTime>(DateTime.now());

  final Rx<TransactionType> _type = TransactionType.income.obs;
  TransactionType get type => _type.value;
  set type(TransactionType type) {
    category.value = null;
    _type.value = type;
  }

  final errorAmount = RxnString();
  final errorCategory = RxnString();

  bool get hasError => errorAmount.value != null || errorCategory.value != null;

  // ----------INIT------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    if(transaction == null) {
      return;
    }

    amount.number = transaction!.amount.abs();
    //category.value = transaction!.category;
    controllerDescription.text = transaction!.description;
    datetime.value = transaction!.createdAt;
    type = transaction!.amount > 0 ? TransactionType.income : TransactionType.expense;
  }

  // ----------VALUES----------------------------------------------------------------------------

  void updateValues() {
    transaction!.amount = amount.number * (type == TransactionType.income ? 1 : -1);
   // transaction!.category = controllerCategory.text;
    transaction!.description = controllerDescription.text;
    transaction!.createdAt = datetime.value;
  }

  bool isOk() {
    errorAmount.value = amount.text.isEmpty ? "tran_item_error_amount".tr : null;
    errorCategory.value = category.value == null ? "tran_item_error_category".tr : null;

    return !hasError;
  }

  // ----------SQL-------------------------------------------------------------------------------

  void _addTransaction() {
    final transaction = Transaction.empty();
    updateValues();
    _transactionController.addSQL(transaction);
  }

  void _updateTransaction(Transaction transaction) {
    updateValues();
    _transactionController.updateSQL(transaction);
  }

  bool save() {
    if(transaction == null) {
      _addTransaction();
    } else {
      _updateTransaction(transaction!);
    }

    return true;
  }
}
