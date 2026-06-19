import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/fields/app_switch.dart';
import 'package:pecunia/widgets/fields/base_field.dart';
import 'package:pecunia/widgets/fields/currency_field.dart';
import 'package:pecunia/util/sheet_save.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet_controller.dart';

class SettingWalletSheet extends ConsumerStatefulWidget {
  const SettingWalletSheet({
    super.key,
    this.wallet,
    this.defaultCurrency,
  });

  final Wallet? wallet;
  final Currency? defaultCurrency;

  @override
  ConsumerState<SettingWalletSheet> createState() => _SettingWalletSheetState();
}

class _SettingWalletSheetState extends ConsumerState<SettingWalletSheet> {
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
      builder: (_, _) => BottomSheetScrollView(
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
            BottomSheetActionRow(
              action: ElevatedButton(
                onPressed: _save,
                child: Text(l10n.settingWalletButtonSave),
              ),
            ),
            AppSpaces.v16,
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final wallet = _ctrl.wallet;

    await saveSheetAndPop(
      context: context,
      validate: () => _ctrl.isOk(
        l10n.settingWalletErrorName,
        l10n.settingWalletErrorCurrency,
      ),
      applyChanges: _ctrl.updateValues,
      persist: () async {
        final notifier = ref.read(walletNotifierProvider.notifier);
        if (wallet.id == 0) {
          await notifier.addSQL(wallet);
        } else {
          await notifier.updateSQL(wallet);
        }
      },
      hasError: () => ref.read(walletNotifierProvider).error != null,
    );
  }
}
