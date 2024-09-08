import 'dart:ui';
import 'package:get/get.dart';
import 'package:pecunia/translations/app_translation.dart';
import 'package:pecunia/translations/en_translation.dart';
import 'package:pecunia/translations/es_translation.dart';
import 'package:pecunia/translations/fr_translation.dart';
import 'package:pecunia/translations/pl_translation.dart';
import 'package:pecunia/translations/ru_translation.dart';
import 'package:pecunia/translations/ua_translation.dart';


class AppTranslations extends Translations {

  //----->>>>>-----add-here----->>>>>------------------------------------------------------------
  List<AppTranslation> translations = [
    EnTranslation(),
    EsTranslation(),
    FrTranslation(),
    PlTranslation(),
    RuTranslation(),
    UaTranslation(),
  ];
  //-----<<<<<-----add-here-----<<<<<------------------------------------------------------------

  List<Locale> get locales => translations.map((e) => e.locale).toList();

  void setLocale(Locale locale) => Get.updateLocale(locale);

  @override
  Map<String, Map<String, String>> get keys =>
      {for (var v in translations) v.locale.languageCode: v.keys};
}
