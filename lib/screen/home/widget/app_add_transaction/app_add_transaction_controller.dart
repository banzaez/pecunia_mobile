import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/transaction.dart';

class AppAddTransactionController extends GetxController {
  final TransactionController _transactionController = Get.find();

  final TextEditingController controllerSumma = TextEditingController();
  final TextEditingController controllerCategory = TextEditingController();

  // ----------VALUES----------------------------------------------------------------------------

  void cleanValues() {
    controllerSumma.clear();
    controllerCategory.clear();
  }

  void updateValues(Transaction transaction) {
    transaction.walletId = _transactionController.walletId;
    transaction.amount = double.tryParse(controllerSumma.text) ?? 0;
    transaction.category = controllerCategory.text;
    transaction.createdAt = DateTime.now();
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