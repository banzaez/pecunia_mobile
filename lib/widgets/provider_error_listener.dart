import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/styles/app_text_style.dart';

void listenProviderError(
  WidgetRef ref,
  BuildContext context, {
  required dynamic provider,
  required String? Function(Object? state) selectError,
  required void Function() clearError,
  String Function(String error, AppLocalizations l10n)? formatError,
}) {
  ref.listen(provider, (prev, next) {
    final error = selectError(next);
    if (error == null || error == selectError(prev)) return;

    final l10n = AppLocalizations.of(context);
    final message = formatError?.call(error, l10n) ?? error;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${l10n.dataLoadError}: $message', style: AppTextStyle.text14w400()),
        backgroundColor: Colors.red,
      ),
    );
    clearError();
  });
}

String formatWalletError(String error, AppLocalizations l10n) =>
    error == walletErrorLastWallet ? l10n.walletDeleteLastError : error;
