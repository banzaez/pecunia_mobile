import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/styles/app_text_style.dart';

class WalletItem extends ConsumerWidget {
  const WalletItem({super.key, required this.wallet, required this.isEditing});

  final Wallet wallet;
  final bool isEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Card(
      color: Colors.white10,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white10,
          child: Text(
            wallet.currency?.code ?? "",
            style: AppTextStyle.text14w600(color: Colors.white60),
          ),
        ),
        title: Text.rich(TextSpan(
          children: [
            TextSpan(text: "${l10n.walletItemName}: ", style: AppTextStyle.text12w400()),
            TextSpan(text: wallet.name),
          ],
        )),
        subtitle: wallet.description.isNotEmpty
            ? Text.rich(TextSpan(
                children: [
                  TextSpan(
                      text: "${l10n.walletItemDescription}: ", style: AppTextStyle.text12w400()),
                  TextSpan(text: wallet.description),
                ],
              ))
            : null,
        trailing: isEditing
            ? IconButton(
                onPressed: () => _onDelete(context, ref),
                icon: const Icon(Icons.close, color: AppColors.edit),
              )
            : null,
      ),
    );
  }

  // --------------------------------------------------------------------------------------------

  Future<void> _onDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await _confirmDismiss(context);
    if (confirmed != true) return;
    await ref.read(walletNotifierProvider.notifier).deleteSQL(wallet.id);
  }

  Future<bool?> _confirmDismiss(BuildContext context) =>
      showConfirmDeleteDialog(context);
}
