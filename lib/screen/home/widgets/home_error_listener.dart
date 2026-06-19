import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/widgets/provider_error_listener.dart';

class HomeErrorListener extends ConsumerWidget {
  const HomeErrorListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenProviderError(
      ref,
      context,
      provider: walletNotifierProvider,
      selectError: (state) => (state as WalletState?)?.error,
      clearError: () => ref.read(walletNotifierProvider.notifier).clearError(),
      formatError: formatWalletError,
    );
    listenProviderError(
      ref,
      context,
      provider: transactionNotifierProvider,
      selectError: (state) => (state as TransactionState?)?.error,
      clearError: () => ref.read(transactionNotifierProvider.notifier).clearError(),
    );
    return child;
  }
}
