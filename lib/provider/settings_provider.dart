import 'dart:ui';
import 'package:currency_picker/currency_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsProvider extends GetxController {
  final GetStorage _getStorage = GetStorage();
  final CurrencyService _currencyService = CurrencyService();

  final _currencyKey = "currency";
  final _localeKey = "locale";

  final Rxn<Locale> rxLocale = Rxn<Locale>();
  final Rxn<Currency> rxCurrency = Rxn<Currency>();
  final RxBool isRoundUp = RxBool(false);

  Future<void> init() async {
    await GetStorage.init();
    
    // Read Initial Locale
    final List list = _getStorage.read(_localeKey)?.split("_") ?? [];
    if (list.isNotEmpty) {
      rxLocale.value = Locale(list.first, list.last);
    }
    
    // Read Initial Currency
    final String? currencyCode = _getStorage.read(_currencyKey);
    if (currencyCode != null) {
      rxCurrency.value = _currencyService.findByCode(currencyCode);
    }

    // Read Initial Round Up (Using previous isRoundUp from wallets or wherever if needed, here just default to false since it's Wallet specific. Wait! isRoundUp was in AppController as static but Wallet model has it too. So maybe we should just keep it in SettingsProvider if it's meant to be global, or if it changes per Wallet, we update it via HomeController.)

    // Auto-save changes to storage
    ever(rxLocale, _saveLocale);
    ever(rxCurrency, _saveCurrency);
  }

  void _saveLocale(Locale? value) => value == null
      ? _getStorage.remove(_localeKey)
      : _getStorage.write(_localeKey, value.toString());

  void _saveCurrency(Currency? value) => value == null
      ? _getStorage.remove(_currencyKey)
      : _getStorage.write(_currencyKey, value.code);

  Locale? get locale => rxLocale.value;
  set locale(Locale? value) => rxLocale.value = value;

  Currency? get currency => rxCurrency.value;
  set currency(Currency? value) => rxCurrency.value = value;
}
