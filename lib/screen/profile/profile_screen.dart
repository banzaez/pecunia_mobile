import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_constants.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/currency_field.dart';
import 'package:pecunia/widgets/switch_language.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static final Future<PackageInfo> _packageInfoFuture = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(title: l10n.profileTitle),
      body: _body(context, ref, l10n),
    );
  }

  // --------------------------------------------------------------------------------------------

  Widget _body(BuildContext context, WidgetRef ref, AppLocalizations l10n) =>
      SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height -
              (MediaQuery.paddingOf(context).top +
                  MediaQuery.paddingOf(context).bottom +
                  kToolbarHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _settings(context, ref, l10n),
              _buttons(context, l10n),
              const SwitchLanguage(),
              _support(context, l10n),
            ],
          ),
        ),
      );

  // --------------------------------------------------------------------------------------------

  Widget _settings(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final settings = ref.watch(settingsNotifierProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          AppSwitch<ThemeMode>(
            onChange: (value) => ref.read(settingsNotifierProvider.notifier).setThemeMode(value),
            values: [
              AppSwitchValue(label: l10n.light, value: ThemeMode.light),
              AppSwitchValue(label: l10n.dark, value: ThemeMode.dark),
            ],
            value: settings.themeMode,
          ),
          Text(l10n.profileTheme),
          AppSpaces.v16,
          CurrencyField(
            onChange: (value) => ref.read(settingsNotifierProvider.notifier).setCurrency(value),
            currency: settings.currency,
          ),
          Text(l10n.profileMainCurrency),
        ],
      ),
    );
  }

  Widget _buttons(BuildContext context, AppLocalizations l10n) => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 256,
            child: ElevatedButton(
              onPressed: () => context.push(AppRoute.wallets.path),
              child: Text(l10n.walletsButton),
            ),
          ),
          AppSpaces.v16,
          SizedBox(
            width: 256,
            child: ElevatedButton(
              onPressed: () => context.push(AppRoute.backup.path),
              child: Text(l10n.backupButton),
            ),
          ),
          AppSpaces.v16,
          SizedBox(
            width: 256,
            child: ElevatedButton(
              onPressed: () => context.push(AppRoute.donate.path),
              child: Text(l10n.profileDonate),
            ),
          ),
        ],
      );

  Widget _support(BuildContext context, AppLocalizations l10n) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => _launchUrl(context),
            child: const Text(AppConstants.supportEmail),
          ),
          Text(l10n.profileSupport, style: AppTextStyle.text12w400(color: AppColors.disable)),
          AppSpaces.v16,
          FutureBuilder(
            future: _packageInfoFuture,
            builder: (_, snapshot) => snapshot.hasData
                ? Text(
                    "${snapshot.data!.packageName} ${snapshot.data!.version}",
                    style: AppTextStyle.text12w400(color: AppColors.disable),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      );

  Future<void> _launchUrl(BuildContext context) async {
    final Uri url = Uri.parse("mailto:${AppConstants.supportEmail}");
    if (!await launchUrl(url) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).error)),
      );
    }
  }
}
