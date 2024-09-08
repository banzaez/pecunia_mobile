import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pecunia/controllers/app_controller.dart';
import 'package:pecunia/controllers/storage_controller.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/screen/analytics/analitics_binding.dart';
import 'package:pecunia/screen/analytics/analytics_screen.dart';
import 'package:pecunia/screen/home/home_binding.dart';
import 'package:pecunia/screen/home/home_screen.dart';
import 'package:pecunia/screen/profile/profile_binding.dart';
import 'package:pecunia/screen/profile/profile_screen.dart';
import 'package:pecunia/styles/app_themes.dart';
import 'package:pecunia/translations/app_translations.dart';
import 'package:pecunia/util/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sql = Get.put(SQLProvider(), permanent: true);
  await sql.initAsync();

  final storage = Get.put(StorageController(), permanent: true);
  await storage.initAsync();

  Get.put(AppTranslations(), permanent: true);
  Get.put(AppController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTranslations appTranslations = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: !AppConstants.isProdServer,
      supportedLocales: appTranslations.locales,
      translations: appTranslations,
      fallbackLocale: appTranslations.locales.first,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: _localeResolutionCallback,
      theme: AppThemes.theme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.dark,
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen(), binding: HomeBinding()),
        GetPage(name: AppScreens.analytics.route, page: () => const AnalyticsScreen(), binding: AnalyticsBinding()),
        GetPage(name: AppScreens.profile.route, page: () => const ProfileScreen(), binding: ProfileBinding()),
      ],
    );
  }

  //----------SET-LOCALE-------------------------------------------------------------------------

  Locale? _localeResolutionCallback(locale, supportedLocales) {
    final StorageController storageController = Get.find();

    Locale currentLocale = supportedLocales.first;

    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode) {
        currentLocale = supportedLocale;
      }
    }

    if (Get.locale == null) {
      currentLocale = storageController.locale ?? currentLocale;
      Get.updateLocale(currentLocale);
    }

    storageController.locale = currentLocale;

    return currentLocale;
  }
}
