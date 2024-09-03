import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/util/ext_string.dart';

class TransactionEditController extends GetxController {
  TransactionEditController(this._transaction);

  final TransactionController _transactionController = Get.find();

  final Transaction _transaction;

  final TextEditingController controllerAmount = TextEditingController();
  final TextEditingController controllerCategory = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final Rx<DateTime> datetime = Rx<DateTime>(DateTime.now());

  final RxInt i = RxInt(-1); // -1 or +1

  final errorAmount = RxnString();
  final errorCategory = RxnString();

  bool get hasError => errorAmount.value != null || errorCategory.value != null;

  @override
  void onInit() {
    super.onInit();

    fillField();
  }

  // ----------VALUES----------------------------------------------------------------------------

  void fillField() {
    controllerAmount.text = _transaction.amount.abs().formatSum.toSortable();
    controllerCategory.text = _transaction.category;
    controllerDescription.text = _transaction.description;
    datetime.value = _transaction.createdAt;
    i.value = _transaction.amount == 0 ? -1 : _transaction.amount.sign.toInt();
  }

  void updateValues() {
    _transaction.amount = (double.tryParse(controllerAmount.text.toSortable()) ?? 0) * i.value;
    _transaction.category = controllerCategory.text;
    _transaction.description = controllerDescription.text;
    _transaction.createdAt = datetime.value;
  }

  bool isOk() {
    errorAmount.value = controllerAmount.text.isEmpty ? "tran_item_error_amount".tr : null;
    errorCategory.value = controllerCategory.text.isEmpty ? "tran_item_error_category".tr : null;

    return !hasError;
  }

  // ----------SQL-------------------------------------------------------------------------------

  bool edit() {
    updateValues();
    _transactionController.updateSQL(_transaction);
    return true;
  }
}
