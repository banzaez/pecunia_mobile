import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecunia/screen/transactions/transactions_controller.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';
import 'package:pecunia/widgets/transaction_item.dart';

class TransactionsScreen extends GetView<TransactionsController> {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(title: "".tr),
        body: _list(),
      );

  // --------------------------------------------------------------------------------------------

  Widget _list() => Obx(() => ListView.builder(
        itemCount: controller.transactions.length,
        itemBuilder: (_, index) => TransactionItem(transaction: controller.transactions[index]),
      ));
}
