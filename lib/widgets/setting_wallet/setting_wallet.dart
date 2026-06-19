import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet_sheet.dart';

class SettingWallet extends ConsumerWidget {
  const SettingWallet({super.key, this.update});

  final Wallet? update;

  @override
  Widget build(BuildContext context, WidgetRef ref) => update == null
      ? TextButton.icon(
          onPressed: () => _setting(context, ref),
          icon: const Icon(Icons.add_circle),
          label: Text(
            AppLocalizations.of(context).settingWalletButtonAdd,
            style: AppTextStyle.text14w400(),
          ),
        )
      : IconButton(
          onPressed: () => _setting(context, ref),
          icon: const Icon(Icons.settings),
        );

  Future<void> _setting(BuildContext context, WidgetRef ref) async {
    final defaultCurrency = ref.read(settingsNotifierProvider).currency;
    await appBottomSheet(
      context,
      SettingWalletSheet(wallet: update, defaultCurrency: defaultCurrency),
    );
  }
}
