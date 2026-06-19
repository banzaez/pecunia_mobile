import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/firebase_options.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/data/sql/sql_provider.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/providers/sql_provider_ref.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/startup/startup_error_screen.dart';
import 'package:pecunia/styles/app_themes.dart';
import 'package:pecunia/styles/app_system_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSystemUi.configure();

  final bootstrap = await _bootstrap();

  runApp(
    ProviderScope(
      overrides: [
        if (bootstrap.sqlProvider != null)
          sqlProviderProvider.overrideWithValue(bootstrap.sqlProvider!),
        if (bootstrap.sharedPreferences != null)
          sharedPreferencesProvider.overrideWithValue(bootstrap.sharedPreferences!),
      ],
      child: bootstrap.error != null
          ? StartupErrorScreen(
              message: bootstrap.error!,
              onRetry: startApp,
            )
          : const MyApp(),
    ),
  );
}

Future<void> main() async => startApp();

class _BootstrapResult {
  const _BootstrapResult({this.sqlProvider, this.sharedPreferences, this.error});

  final SQLProvider? sqlProvider;
  final SharedPreferences? sharedPreferences;
  final String? error;
}

Future<_BootstrapResult> _bootstrap() async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    final sqlProvider = SQLProvider();
    await sqlProvider.init();

    final sharedPreferences = await SharedPreferences.getInstance();

    return _BootstrapResult(
      sqlProvider: sqlProvider,
      sharedPreferences: sharedPreferences,
    );
  } catch (e, stackTrace) {
    debugPrint('Startup error: $e\n$stackTrace');
    return _BootstrapResult(error: e.toString());
  }
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
      builder: AppSystemUi.wrap,
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
