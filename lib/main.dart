import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pecunia/controllers/app_controller.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/screen/home/home_binding.dart';
import 'package:pecunia/screen/home/home_screen.dart';
import 'package:pecunia/screen/profile/profile_binding.dart';
import 'package:pecunia/screen/profile/profile_screen.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/translations/app_translations.dart';
import 'package:pecunia/util/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('Ru_ru', null);

  final sqlController = Get.put(SQLProvider(), permanent: true);
  await sqlController.initAsync();

  Get.put(AppTranslations(), permanent: true);
  Get.put(AppController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => GetMaterialApp(
      debugShowCheckedModeBanner: !AppConstants.isProdServer,
      supportedLocales: AppTranslations.localeList,
      translations: Get.find<AppTranslations>(),
      fallbackLocale: AppTranslations.localeDefault,
      locale: Get.find<AppController>().appLocale,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: theme,
      darkTheme: themeDark,
      themeMode: ThemeMode.dark,
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen(), binding: HomeBinding()),
        GetPage(name: AppScreens.profile.route, page: () => const ProfileScreen(), binding: ProfileBinding()),
      ]);

  //----------THEME------------------------------------------------------------------------------

  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white10,
          textStyle: AppTextStyle.text16w400(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  ThemeData get theme => ThemeData(
        elevatedButtonTheme: _elevatedButtonTheme,
        primarySwatch: AppColors.primary,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: Colors.white,
          secondary: AppColors.primary,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        fontFamily: GoogleFonts.openSans().fontFamily,
      );

  ThemeData get themeDark => ThemeData(
        elevatedButtonTheme: _elevatedButtonTheme,
        primarySwatch: AppColors.primary,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primary,
          onPrimary: Colors.black,
          secondary: AppColors.primary,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.black,
          onSurface: Colors.white,
        ),
        fontFamily: GoogleFonts.openSans().fontFamily,
      );
}
