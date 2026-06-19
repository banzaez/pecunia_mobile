import 'package:flutter/material.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/styles/app_border_style.dart';
import 'package:pecunia/widgets/dialogs/dialog_choose_wallet.dart';
import 'package:pecunia/widgets/wallet_item.dart';

class WalletField extends StatelessWidget {
  const WalletField({super.key, required this.onChanged, this.initValue});

  final ValueChanged<Wallet?> onChanged;
  final Wallet? initValue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DialogChooseWallet(
      onChanged: onChanged,
      child: initValue == null
          ? Container(
              decoration: AppBorderStyle.fieldBox(context),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(l10n.walletFieldEmpty)),
                    const Icon(Icons.arrow_drop_up),
                  ],
                ),
              )
          : WalletItem(wallet: initValue!, isEditing: false),
    );
  }
}
