import 'package:flutter/material.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/widgets/fields/number_field.dart';

/// Чистый ChangeNotifier — заменяет GetxController для Transfer формы.
class TransferController extends ChangeNotifier {
  final NumberEditingController amount = NumberEditingController();
  final NumberEditingController exchangeRate = NumberEditingController();
  final NumberEditingController total = NumberEditingController();

  bool differentCurrencies = false;
  bool enableDone = false;
  bool divisionSign = false;

  String? errorWallet;

  Wallet? _from;
  Wallet? get from => _from;
  set from(Wallet? wallet) {
    _from = wallet;
    changeWallet();
  }

  Wallet? _to;
  Wallet? get to => _to;
  set to(Wallet? wallet) {
    _to = wallet;
    changeWallet();
  }

  TransferController() {
    amount.addListener(_onAmountChanged);
    exchangeRate.addListener(_onAmountChanged);
    total.addListener(_onTotalChanged);
  }

  @override
  void dispose() {
    amount.removeListener(_onAmountChanged);
    exchangeRate.removeListener(_onAmountChanged);
    total.removeListener(_onTotalChanged);
    amount.dispose();
    exchangeRate.dispose();
    total.dispose();
    super.dispose();
  }

  // ----------CHANGES---------------------------------------------------------------------------

  void toggleDivisionSign() {
    divisionSign = !divisionSign;
    changeAmount();
  }

  void changeWallet() {
    exchangeRate.number = 1;
    differentCurrencies = (_from != null && _to != null && _from?.currency != _to?.currency);
    errorWallet = _from?.id == _to?.id ? '__wallet_error__' : null;

    if (differentCurrencies) {
      amount.clear();
    } else {
      total.clear();
    }

    checkEnableDone();
    notifyListeners();
  }

  void _onAmountChanged() => changeAmount();

  void changeAmount() {
    if (!differentCurrencies) return;

    final sum = (divisionSign
            ? exchangeRate.number == 0
                ? 0.0
                : amount.number / exchangeRate.number
            : amount.number * exchangeRate.number)
        .toStringAsFixed(2);
    total.number = double.tryParse(sum) ?? 0;
    checkEnableDone();
    notifyListeners();
  }

  void _onTotalChanged() => changeTotal();

  void changeTotal() {
    if (!differentCurrencies) amount.number = total.number;
    checkEnableDone();
    notifyListeners();
  }

  void checkEnableDone() {
    enableDone = isOk();
  }

  // ----------IS OK-----------------------------------------------------------------------------

  bool isOk() {
    if (errorWallet != null) return false;
    if (amount.number == 0) return false;
    if (differentCurrencies && exchangeRate.number == 0) return false;
    if (total.number == 0) return false;
    return true;
  }
}
