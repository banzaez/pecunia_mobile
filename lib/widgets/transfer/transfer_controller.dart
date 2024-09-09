import 'package:get/get.dart';
import 'package:pecunia/controllers/transaction_controller.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/util/ext_string.dart';
import 'package:pecunia/widgets/fields/number_field.dart';

class TransferController extends GetxController {
  final TransactionController _transactionController = Get.find();

  final Rxn<Wallet> _fromWallet = Rxn();
  final Rxn<Wallet> _toWallet = Rxn();

  final NumberEditingController amount = NumberEditingController();
  final NumberEditingController exchangeRate = NumberEditingController();
  final NumberEditingController total = NumberEditingController();

  final RxBool needExchangeRate = false.obs;
  final RxBool enableDone = false.obs;

  final RxnString errorWallet = RxnString();
  final RxnString errorAmount = RxnString();
  final RxnString errorExchangeRate = RxnString();
  final RxnString errorTotal = RxnString();

  // ----------GETS------------------------------------------------------------------------------

  Wallet? get from => _fromWallet.value;
  set from(Wallet? wallet) => _fromWallet.value = wallet;

  Wallet? get to => _toWallet.value;
  set to(Wallet? wallet) => _toWallet.value = wallet;

  // ----------INIT------------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();
    _fromWallet.addListener(() => changeWallet());
    _toWallet.addListener(() => changeWallet());

    amount.addListener(() => changeAmount());
    exchangeRate.addListener(() => changeAmount());
  }

  // ----------CHANGES---------------------------------------------------------------------------

  void checkEnableDone() => enableDone.value = isOk();

  void changeAmount() {
    total.number = amount.number * exchangeRate.number;
    checkEnableDone();
  }

  void changeWallet() {
    exchangeRate.number = 1;
    needExchangeRate.value = (from != null && to != null && from?.currency != to?.currency);
    errorWallet.value = from?.id == to?.id ? "transfer_error_wallet".tr : null;
    checkEnableDone();
  }

  // ----------IS OK-----------------------------------------------------------------------------

  bool isOk() {
    if (errorWallet.value != null) return false;
    if (amount.number == 0) return false;
    if (needExchangeRate.value && exchangeRate.number == 0) return false;
    if (total.number == 0) return false;
    return true;
  }

  // ----------SQL-------------------------------------------------------------------------------

  Future<void> transfer() async {
    if (from == null || to == null) return;

    final description = "transfer_description".tr.format([
      from!.name,
      to!.name,
      exchangeRate.number.toDouble().formatDouble,
    ]);

    final transaction = Transaction.empty();
    transaction.walletId = from!.id;
    transaction.category = "transfer";
    transaction.description = description;
    transaction.amount = -amount.number.toDouble();
    _transactionController.addSQL(transaction);

    transaction.walletId = to!.id;
    transaction.amount = total.number.toDouble();
    _transactionController.addSQL(transaction);
  }
}
