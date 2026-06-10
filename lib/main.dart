import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/firebase_options.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/provider/sql_provider.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/providers/sql_provider_ref.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/styles/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';
import 'dart:ui';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final sqlProvider = SQLProvider();
  await sqlProvider.init();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sqlProviderProvider.overrideWithValue(sqlProvider),
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    final resolvedLocale = settings.locale ?? PlatformDispatcher.instance.locale;
    Intl.defaultLocale = resolvedLocale.toString();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppThemes.theme,
      darkTheme: AppThemes.darkTheme,
      themeMode: settings.themeMode,
      locale: settings.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        final settingsLocale = ref.read(settingsNotifierProvider).locale;
        if (settingsLocale != null) return settingsLocale;

        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
