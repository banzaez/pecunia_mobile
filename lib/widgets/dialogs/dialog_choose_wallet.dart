import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/widgets/app_bottom_sheet.dart';
import 'package:pecunia/widgets/flex_builder.dart';
import 'package:pecunia/widgets/wallet_item.dart';

class DialogChooseWallet extends ConsumerWidget {
  const DialogChooseWallet({super.key, required this.onChanged, required this.child});

  final ValueChanged<Wallet?> onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) => GestureDetector(
        onTap: () => _onTap(context, ref).then((wallet) {
          if (wallet == null) return;
          onChanged(wallet);
        }),
        child: child,
      );

  // --------------------------------------------------------------------------------------------

  Widget _item(Wallet wallet, BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(wallet),
        child: WalletItem(wallet: wallet, isEditing: false),
      );

  Future<Wallet?> _onTap(BuildContext context, WidgetRef ref) async {
    final wallets = ref.read(walletNotifierProvider).wallets;
    final l10n = AppLocalizations.of(context);
    return await appBottomSheet<Wallet>(
      context,
      SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.currentWalletBottomTitle),
            AppSpaces.v16,
            FlexBuilder(
              mainAxisSize: MainAxisSize.min,
              itemCount: wallets.length,
              itemBuilder: (_, index) => _item(wallets[index], context),
            ),
            AppSpaces.v32,
          ],
        ),
      ),
    );
  }
}
