import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/transaction.dart';

class AppAddTransactionController extends GetxController {
  final TransactionController _transactionController = Get.find();

  final TextEditingController controllerAmount = TextEditingController();
  final TextEditingController controllerCategory = TextEditingController();
  final Rx<DateTime> datetime = Rx<DateTime>(DateTime.now());
  final RxBool showDate = RxBool(false);

  final errorAmount = RxnString();
  final errorCategory = RxnString();

  bool get hasError => errorAmount.value != null || errorCategory.value != null;

  @override
  void onInit() {
    super.onInit();

    showDate.addListener(() => datetime.value = DateTime.now());
  }

  // ----------VALUES----------------------------------------------------------------------------

  void cleanValues() {
    controllerAmount.clear();
    controllerCategory.clear();
    showDate.value = false;
  }

  void updateValues(Transaction transaction) {
    transaction.walletId = _transactionController.walletId;
    transaction.amount = double.tryParse(controllerAmount.text) ?? 0;
    transaction.category = controllerCategory.text;
    transaction.createdAt = showDate.isTrue ? datetime.value : DateTime.now();
  }

  bool isOk() {
    errorAmount.value = controllerAmount.text.isEmpty ? "transaction_item_error_amount".tr : null;
    errorCategory.value = controllerCategory.text.isEmpty ? "transaction_item_error_category".tr : null;

    return !hasError;
  }

  // ----------SQL-------------------------------------------------------------------------------

  void add(int i) {
    final transaction = Transaction.empty();
    updateValues(transaction);
    transaction.amount = transaction.amount * i;
    _transactionController.addSQL(transaction);
    cleanValues();
  }

}