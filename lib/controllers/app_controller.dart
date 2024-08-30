import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pecunia/translations/app_translations.dart';

class AppController extends GetxController {

  @override
  void onInit() {
    super.onInit();

  }

  //----------LOCALISATION-----------------------------------------------------------------------

  Locale _appLocale = AppTranslations.localeDefault;

  Locale get appLocale => _appLocale;

  set appLocale(Locale locale) {
    _appLocale = locale;

    Get.updateLocale(locale);
    GetStorage().write('locale', locale.languageCode);
  }

  //----------NAVIGATION-------------------------------------------------------------------------

  Future<void> goToScreen(AppScreens screen, {bool addToStack = true, dynamic arguments}) async {
    addToStack
        ? await Get.toNamed(screen.route, arguments: arguments)
        : await Get.offAllNamed(screen.route, arguments: arguments);
  }
}

enum AppScreens {
  home,
  profile;

  String get route => switch (this) {
        home => "/",
        profile => "/profile",
      };
}
