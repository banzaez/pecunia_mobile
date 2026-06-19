import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_notifier.g.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class SettingsState {
  final Locale? locale;
  final Currency? currency;
  final bool isRoundUp;
  final ThemeMode themeMode;

  const SettingsState({
    this.locale,
    this.currency,
    this.isRoundUp = false,
    this.themeMode = ThemeMode.dark,
  });

  SettingsState copyWith({
    Locale? locale,
    Currency? currency,
    bool? isRoundUp,
    ThemeMode? themeMode,
    bool clearLocale = false,
    bool clearCurrency = false,
  }) =>
      SettingsState(
        locale: clearLocale ? null : (locale ?? this.locale),
        currency: clearCurrency ? null : (currency ?? this.currency),
        isRoundUp: isRoundUp ?? this.isRoundUp,
        themeMode: themeMode ?? this.themeMode,
      );
}

// ---------------------------------------------------------------------------
// SharedPreferences provider
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('Initialize SharedPreferences before use');
}

// ---------------------------------------------------------------------------
// SettingsNotifier
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true, name: 'settingsNotifierProvider')
class SettingsNotifier extends _$SettingsNotifier {
  static const _currencyKey = 'currency';
  static const _localeKey = 'locale';
  static const _themeModeKey = 'themeMode';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);
  final CurrencyService _currencyService = CurrencyService();

  @override
  SettingsState build() {
    final prefs = ref.watch(sharedPreferencesProvider);

    // Read locale
    Locale? locale;
    final localeStr = prefs.getString(_localeKey);
    if (localeStr != null) {
      final parts = localeStr.split('_');
      locale = parts.length > 1 ? Locale(parts.first, parts.last) : Locale(parts.first);
    }

    // Read currency
    Currency? currency;
    final currencyCode = prefs.getString(_currencyKey);
    if (currencyCode != null) {
      currency = _currencyService.findByCode(currencyCode);
    }

    // Read theme (string with legacy int migration)
    final themeMode = _readThemeMode(prefs);

    return SettingsState(locale: locale, currency: currency, themeMode: themeMode);
  }

  ThemeMode _readThemeMode(SharedPreferences prefs) {
    final themeName = prefs.getString(_themeModeKey);
    if (themeName != null) {
      return ThemeMode.values.firstWhere(
        (mode) => mode.name == themeName,
        orElse: () => ThemeMode.dark,
      );
    }

    final legacyIndex = prefs.getInt(_themeModeKey);
    if (legacyIndex != null &&
        legacyIndex >= 0 &&
        legacyIndex < ThemeMode.values.length) {
      final mode = ThemeMode.values[legacyIndex];
      prefs.setString(_themeModeKey, mode.name);
      return mode;
    }

    return ThemeMode.dark;
  }

  // -----------LOCALE----------------------------------------------------------

  void setLocale(Locale locale) {
    _prefs.setString(_localeKey, locale.toString());
    state = state.copyWith(locale: locale);
  }

  // -----------CURRENCY--------------------------------------------------------

  void setCurrency(Currency? currency) {
    if (currency == null) {
      _prefs.remove(_currencyKey);
      state = state.copyWith(clearCurrency: true);
    } else {
      _prefs.setString(_currencyKey, currency.code);
      state = state.copyWith(currency: currency);
    }
  }

  // -----------ROUND UP-------------------------------------------------------

  void setRoundUp(bool value) => state = state.copyWith(isRoundUp: value);

  // -----------THEME----------------------------------------------------------

  void setThemeMode(ThemeMode themeMode) {
    _prefs.setString(_themeModeKey, themeMode.name);
    state = state.copyWith(themeMode: themeMode);
  }
}
