import 'dart:ui';

abstract class AppTranslation {
  String get name;

  String get flag;

  Locale get locale;

  Map<String, String> get keys;
}
