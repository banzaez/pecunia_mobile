import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/base_field.dart';
import 'package:pecunia/widgets/fields/currency_field.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet_controller.dart';

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
      _SettingWalletSheet(wallet: update, defaultCurrency: defaultCurrency),
    );
  }
}

// ---------------------------------------------------------------------------
// Internal sheet widget
// ---------------------------------------------------------------------------

class _SettingWalletSheet extends ConsumerStatefulWidget {
  const _SettingWalletSheet({this.wallet, this.defaultCurrency});

  final Wallet? wallet;
  final dynamic defaultCurrency;

  @override
  ConsumerState<_SettingWalletSheet> createState() =>
      _SettingWalletSheetState();
}

class _SettingWalletSheetState extends ConsumerState<_SettingWalletSheet> {
  late SettingWalletController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = SettingWalletController(
      wallet: widget.wallet,
      defaultCurrency: widget.defaultCurrency,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: _ctrl,
      builder: (_, _) => SingleChildScrollView(
        child: Column(
          children: [
            AppSpaces.v8,
            Center(
              child: Text(
                widget.wallet == null
                    ? l10n.settingWalletTitleAdd
                    : l10n.settingWalletTitleUpdate,
                textAlign: TextAlign.center,
              ),
            ),
            AppSpaces.v16,
            BaseField(
              controller: _ctrl.nameController,
              errorText: _ctrl.errorName,
            ),
            Text(l10n.settingWalletName),
            AppSpaces.v16,
            BaseField(controller: _ctrl.descriptionController),
            Text(l10n.settingWalletDescription),
            AppSpaces.v16,
            CurrencyField(
              onChange: (value) => _ctrl.currency = value,
              currency: _ctrl.currency,
              errorText: _ctrl.errorCurrency,
            ),
            Text(l10n.settingWalletCurrency),
            AppSpaces.v16,
            AppSwitch<bool>(
              onChange: (value) => _ctrl.showBalance = value,
              values: [
                AppSwitchValue(label: l10n.no, value: false),
                AppSwitchValue(label: l10n.yes, value: true),
              ],
              value: _ctrl.showBalance,
              width: 256,
            ),
            Text(l10n.settingWalletShowBalance),
            AppSpaces.v16,
            AppSwitch<bool>(
              onChange: (value) => _ctrl.isRoundUp = value,
              values: [
                AppSwitchValue(label: l10n.no, value: false),
                AppSwitchValue(label: l10n.yes, value: true),
              ],
              value: _ctrl.isRoundUp,
              width: 256,
            ),
            Text(l10n.settingWalletIsRoundUp),
            AppSpaces.v32,
            ElevatedButton(
              onPressed: _save,
              child: Text(l10n.settingWalletButtonSave),
            ),
            AppSpaces.v32,
          ],
        ),
      ),
    );
  }

  void _save() {
    final l10n = AppLocalizations.of(context);
    if (!_ctrl.isOk(
      l10n.settingWalletErrorName,
      l10n.settingWalletErrorCurrency,
    ))
      return;
    _ctrl.updateValues();

    final notifier = ref.read(walletNotifierProvider.notifier);
    final wallet = _ctrl.wallet;
    if (wallet.id == 0) {
      notifier.addSQL(wallet);
    } else {
      notifier.updateSQL(wallet);
    }

    Navigator.of(context).pop();
  }
}
