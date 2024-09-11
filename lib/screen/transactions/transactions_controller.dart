import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/screen/transactions/transactions_arguments.dart';

class TransactionsController extends GetxController {
  final TransactionController _transactionController = Get.find();

  final RxList<Transaction> transactions = RxList();

  late final int walletId;
  late final int categoryId;
  late final DateTime startDate;
  late final DateTime endDate;

  // -----------INIT-----------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    final TransactionsArguments arguments = Get.arguments;

    walletId = arguments.walletId;
    categoryId = arguments.categoryId;
    startDate = arguments.startDate;
    endDate = arguments.endDate;

    _transactionController
        .selectByWalletIdAndCategoryAndByPeriod(
          walletId,
          categoryId,
          startDate,
          endDate,
        )
        .then((value) => transactions.value = value);
  }
}
