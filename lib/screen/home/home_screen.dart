import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/providers/wallet_notifier.dart';
import 'package:pecunia/router/app_router.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/screen/home/widget/current_wallet.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/widgets/provider_error_listener.dart';
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
    final isRoundUp = ref.watch(settingsNotifierProvider.select((s) => s.isRoundUp));

    return _HomeErrorListener(
      child: homeState.isInitializing
          ? const Material(child: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: _appBar(context, ref, l10n, homeState, isRoundUp),
              body: _body(isRoundUp),
            ),
    );
  }

  AppBar _appBar(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    HomeState homeState,
    bool isRoundUp,
  ) {
    final showBalance = homeState.currentWallet?.showBalance ?? false;
    final total = ref.watch(
      transactionNotifierProvider.select((s) => s.analyticsTotal),
    );

    return AppBar(
      leading: SettingWallet(update: homeState.currentWallet),
      title: const CurrentWallet(),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => context.push(AppRoute.profile.path),
          icon: const Icon(Icons.account_box),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(showBalance ? 158.0 : 64.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showBalance)
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: TotalHeader(total: total, isRoundUp: isRoundUp),
              ),
            TextButton.icon(
              onPressed: () => context.push(AppRoute.analytics.path),
              icon: const Icon(Icons.query_stats),
              label: Text(l10n.analyticsTitle, style: AppTextStyle.text16w400()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(bool isRoundUp) => Column(
        children: [
          Expanded(child: _TransactionList(isRoundUp: isRoundUp)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SettingTransaction(),
          ),
          const SizedBox(height: 32),
        ],
      );
}

class _HomeErrorListener extends ConsumerWidget {
  const _HomeErrorListener({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenProviderError(
      ref,
      context,
      provider: walletNotifierProvider,
      selectError: (state) => (state as WalletState?)?.error,
      clearError: () => ref.read(walletNotifierProvider.notifier).clearError(),
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

class _TransactionList extends ConsumerStatefulWidget {
  const _TransactionList({required this.isRoundUp});

  final bool isRoundUp;

  @override
  ConsumerState<_TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends ConsumerState<_TransactionList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      ref.read(transactionNotifierProvider.notifier).loadMore();
    }
  }

  Future<bool> _deleteTransaction(int id) async {
    await ref.read(transactionNotifierProvider.notifier).deleteSQL(id);
    return ref.read(transactionNotifierProvider).error == null;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int?>(
      homeNotifierProvider.select((s) => s.currentWallet?.id),
      (prev, next) {
        if (prev != next && _scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      },
    );

    final transactionState = ref.watch(transactionNotifierProvider);
    final homeState = ref.watch(homeNotifierProvider);
    final wallets = ref.watch(walletNotifierProvider.select((s) => s.wallets));
    final walletCount = wallets.length;
    final currentIndex = wallets.indexWhere((e) => e.id == homeState.currentWallet?.id);
    final transactions = transactionState.transactions;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView.builder(
          controller: _scrollController,
          itemCount: transactions.length + (transactionState.isLoadingMore ? 1 : 0),
          itemBuilder: (_, index) {
            if (index >= transactions.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final transaction = transactions[index];
            return TransactionItem(
              key: ValueKey(transaction.id),
              transaction: transaction,
              isRoundUp: widget.isRoundUp,
              onDelete: () => _deleteTransaction(transaction.id),
            );
          },
        ),
        _WalletDots(
          walletCount: walletCount,
          currentIndex: currentIndex,
          onSwipe: (offset) =>
              ref.read(homeNotifierProvider.notifier).swipeWallet(offset),
        ),
      ],
    );
  }
}

class _WalletDots extends StatelessWidget {
  const _WalletDots({
    required this.walletCount,
    required this.currentIndex,
    required this.onSwipe,
  });

  final int walletCount;
  final int currentIndex;
  final ValueChanged<int> onSwipe;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onPanEnd: (details) {
          final dx = details.velocity.pixelsPerSecond.dx;
          onSwipe(dx.sign.toInt());
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
