import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
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
                onPressed: () => _confirmDismiss(context).then((value) {
                  if (value == true) {
                    ref.read(walletNotifierProvider.notifier).deleteSQL(wallet.id);
                  }
                }),
                icon: const Icon(Icons.close, color: AppColors.edit),
              )
            : null,
      ),
    );
  }

  // --------------------------------------------------------------------------------------------

  Future<bool?> _confirmDismiss(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    return await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.dialogDeleteTitle),
        content: Text(l10n.dialogDeleteContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.dialogDeleteCancel, style: AppTextStyle.text16w600()),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              l10n.dialogDeleteDelete,
              style: AppTextStyle.text16w600(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
