import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';

// ---------------------------------------------------------------------------
// Список доступных языков
// ---------------------------------------------------------------------------

class _LangItem {
  final String name;
  final String flag;
  final Locale locale;
  const _LangItem(this.name, this.flag, this.locale);
}

const _languages = [
  _LangItem('English', 'gb', Locale('en')),
  _LangItem('Русский', 'ru', Locale('ru')),
  _LangItem('Español', 'es', Locale('es')),
  _LangItem('Français', 'fr', Locale('fr')),
  _LangItem('Polski', 'pl', Locale('pl')),
  _LangItem('Українська', 'ua', Locale('uk')),
];

extension _FlagEmoji on String {
  String get toFlag => toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
      );
}

// ---------------------------------------------------------------------------

class SwitchLanguage extends ConsumerWidget {
  const SwitchLanguage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(settingsNotifierProvider).locale ?? Localizations.localeOf(context);

    return DropdownButton<Locale>(
      onChanged: (value) {
        if (value != null) {
          ref.read(settingsNotifierProvider.notifier).setLocale(value);
        }
      },
      value: _matchLocale(currentLocale),
      items: _languages.map((e) => _item(item: e)).toList(),
      autofocus: false,
      borderRadius: BorderRadius.circular(8),
      padding: EdgeInsets.zero,
      underline: const SizedBox.shrink(),
      elevation: 1,
      icon: const Icon(Icons.arrow_drop_down, color: AppColors.disable, size: 26),
    );
  }

  Locale _matchLocale(Locale current) {
    for (final lang in _languages) {
      if (lang.locale.languageCode == current.languageCode) return lang.locale;
    }
    return _languages.first.locale;
  }

  DropdownMenuItem<Locale> _item({required _LangItem item}) => DropdownMenuItem<Locale>(
        value: item.locale,
        child: Row(
          children: [
            Text(
              item.flag.toFlag,
              style: const TextStyle(fontSize: 22),
            ),
            AppSpaces.h16,
            Text(item.name, style: AppTextStyle.text14w600()),
          ],
        ),
      );
}
