import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/base_controller.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/util/ext_string.dart';
import 'package:pecunia/widgets/fields/number_field.dart';


class SettingTransactionController extends BaseController {
  SettingTransactionController([this.transaction]);

  final TransactionController _transactionController = Get.find();

  final Transaction? transaction;

  final NumberEditingController controllerAmount = NumberEditingController();
  final TextEditingController controllerCategory = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final Rx<DateTime> datetime = Rx<DateTime>(DateTime.now());

  final RxInt i = RxInt(-1); // -1 or +1

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

    controllerAmount.text = transaction!.amount.abs().formatSum.toSortable();
    controllerCategory.text = transaction!.category;
    controllerDescription.text = transaction!.description;
    datetime.value = transaction!.createdAt;
    i.value = transaction!.amount == 0 ? -1 : transaction!.amount.sign.toInt();
  }

  // ----------VALUES----------------------------------------------------------------------------

  void updateValues() {
    transaction!.amount = (double.tryParse(controllerAmount.text.toSortable()) ?? 0) * i.value;
    transaction!.category = controllerCategory.text;
    transaction!.description = controllerDescription.text;
    transaction!.createdAt = datetime.value;
  }

  bool isOk() {
    errorAmount.value = controllerAmount.text.isEmpty ? "tran_item_error_amount".tr : null;
    errorCategory.value = controllerCategory.text.isEmpty ? "tran_item_error_category".tr : null;

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
