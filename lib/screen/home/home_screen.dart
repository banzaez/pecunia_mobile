import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/screen/home/widget/current_wallet.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/widgets/setting_transaction/setting_transaction.dart';
import 'package:pecunia/widgets/setting_wallet/setting_wallet.dart';
import 'package:pecunia/widgets/total_header.dart';
import 'package:pecunia/widgets/transaction_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final homeState = ref.watch(homeNotifierProvider);

    if (homeState.isInitializing) {
      return const Material(child: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: _appBar(context, ref, l10n),
      body: _body(context, ref),
    );
  }

  // --------------------------------------------------------------------------------------------

  PreferredSize _analytics(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final wallet = ref.watch(homeNotifierProvider).currentWallet;
    final showBalance = wallet?.showBalance ?? false;
    final total = ref.watch(transactionNotifierProvider).analyticsTotal;

    return PreferredSize(
      preferredSize: Size.fromHeight(showBalance ? 158.0 : 64.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showBalance)
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: TotalHeader(total: total),
            ),
          TextButton.icon(
            onPressed: () => context.push(AppRoute.analytics.path),
            icon: const Icon(Icons.query_stats),
            label: Text(l10n.analyticsTitle, style: AppTextStyle.text16w400()),
          ),
        ],
      ),
    );
  }

  Widget _profile(BuildContext context) => IconButton(
        onPressed: () => context.push(AppRoute.profile.path),
        icon: const Icon(Icons.account_box),
      );

  AppBar _appBar(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final homeState = ref.watch(homeNotifierProvider);
    return AppBar(
      leading: SettingWallet(update: homeState.currentWallet),
      title: const CurrentWallet(),
      centerTitle: true,
      actions: [_profile(context)],
      bottom: _analytics(context, ref, l10n),
    );
  }

  // --------------------------------------------------------------------------------------------

  Widget _body(BuildContext context, WidgetRef ref) => Column(
        children: [
          _list(context, ref),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const SettingTransaction(),
          ),
          const SizedBox(height: 32),
        ],
      );

  // --------------------------------------------------------------------------------------------

  Widget _list(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionNotifierProvider).transactions;
    final wallets = ref.watch(walletNotifierProvider).wallets;
    final currentIndex = ref.read(homeNotifierProvider.notifier).currentIndex;

    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (_, index) => TransactionItem(transaction: transactions[index]),
          ),
          _dots(ref, wallets.length, currentIndex),
        ],
      ),
    );
  }

  Widget _dots(WidgetRef ref, int walletCount, int currentIndex) => GestureDetector(
        onPanEnd: (details) {
          final dx = details.velocity.pixelsPerSecond.dx;
          ref.read(homeNotifierProvider.notifier).swipeWallet(dx.sign.toInt());
        },
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(
              walletCount,
              (index) => Icon(
                currentIndex == index
                    ? Icons.fiber_manual_record
                    : Icons.fiber_manual_record_outlined,
                size: 18,
              ),
            ),
          ),
        ),
      );
}
