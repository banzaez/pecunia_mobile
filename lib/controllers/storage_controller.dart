import 'dart:ui';

import 'package:currency_picker/currency_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final GetStorage _getStorage = GetStorage();

  final _currencyKey = "currency";
  final _localeKey = "locale";

  Future<void> initAsync() async => await GetStorage.init();

  //----------LOCALE-----------------------------------------------------------------------------

  Locale? get locale {
    final List list = _getStorage.read(_localeKey)?.split("_") ?? [];
    return list.isEmpty ? null : Locale(list.first, list.last);
  }

  set locale(Locale? value) => value == null
      ? _getStorage.remove(_localeKey)
      : _getStorage.write(_localeKey, value.toString());

  //----------main currency-----------------------------------------------------------------------------------

  Currency? get currency {
    final String? currencyCode = _getStorage.read(_currencyKey);
    return CurrencyService().findByCode(currencyCode);
  }

  set currency(Currency? value) => value == null
      ? _getStorage.remove(_currencyKey)
      : _getStorage.write(_currencyKey, value.code);
}
