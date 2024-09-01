import 'dart:ui';

import 'package:countries_flag/countries_flag.dart';
import 'package:get/get.dart';
import 'package:pecunia/translations/en_translations.dart';
import 'package:pecunia/translations/ru_translations.dart';

class LocaleItem {
  String name;
  Locale locale;
  String flag;

  LocaleItem({required this.name, required this.locale, required this.flag});
}

class AppTranslations extends Translations {

  //----->>>>>-----add-here----->>>>>------------------------------------------------------------
  List<LocaleItem> localeItems = [
    LocaleItem(name: "English", locale: const Locale('en', 'US'), flag: Flags.england),
    LocaleItem(name: "Русский", locale: const Locale('ru', 'RU'), flag: Flags.russia),
  ];
  //-----<<<<<-----add-here-----<<<<<------------------------------------------------------------

  List<Locale> get localeList => localeItems.map((e) => e.locale).toList();

  void setLocale(Locale locale) => Get.updateLocale(locale);

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ru': ru,
      };
}
