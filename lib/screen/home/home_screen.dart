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
import 'package:pecunia/styles/app_colors.dart';
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
    final homeState = ref.watch(homeNotifierProvider);
    final isRoundUp = ref.watch(settingsNotifierProvider.select((s) => s.isRoundUp));

    return _HomeErrorListener(
      child: homeState.isInitializing
          ? const Material(child: Center(child: CircularProgressIndicator()))
          : Scaffold(
              extendBody: true,
              appBar: _appBar(context, ref, homeState),
              body: _body(context, ref, isRoundUp),
            ),
    );
  }

  AppBar _appBar(BuildContext context, WidgetRef ref, HomeState homeState) => AppBar(
        leading: SettingWallet(update: homeState.currentWallet),
        title: const CurrentWallet(),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoute.profile.path),
            icon: const Icon(Icons.account_box),
          ),
        ],
      );

  Widget _body(BuildContext context, WidgetRef ref, bool isRoundUp) {
    final bottomSafe = MediaQuery.viewPaddingOf(context).bottom;
    const actionPanelContentHeight = 64.0;
    const walletDotsHeight = 40.0;
    const topFadeHeight = 24.0;
    const listInsetTrim = 12.0;
    final bottomOverlayHeight =
        actionPanelContentHeight + walletDotsHeight + bottomSafe + 4;

    final showBalance = ref.watch(homeNotifierProvider).currentWallet?.showBalance ?? false;
    final topContentHeight = showBalance ? 148.0 : 56.0;
    final topOverlayHeight = topContentHeight + topFadeHeight * 0.5;

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: Stack(
        children: [
          Positioned.fill(
            child: _TransactionList(
              isRoundUp: isRoundUp,
              topPadding: topOverlayHeight - listInsetTrim,
              bottomPadding: bottomOverlayHeight - listInsetTrim,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: _HomeTopOverlay(fadeHeight: topFadeHeight),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _HomeBottomOverlay(bottomSafe: bottomSafe),
          ),
        ],
      ),
    );
  }
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

class _TransactionList extends ConsumerStatefulWidget {
  const _TransactionList({
    required this.isRoundUp,
    required this.topPadding,
    required this.bottomPadding,
  });

  final bool isRoundUp;
  final double topPadding;
  final double bottomPadding;

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
    final transactions = transactionState.transactions;

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(
        top: widget.topPadding,
        bottom: widget.bottomPadding,
      ),
      clipBehavior: Clip.none,
      itemCount: transactions.length + (transactionState.isLoadingMore ? 1 : 0),
      itemBuilder: (_, index) {
        if (index >= transactions.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final transaction = transactions[index];
        return TransactionItem(
          key: ValueKey(transaction.id),
          transaction: transaction,
          isRoundUp: widget.isRoundUp,
          onDelete: () => _deleteTransaction(transaction.id),
          edgeToEdge: true,
        );
      },
    );
  }
}

Color _homePanelColor(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final baseColor = isDark ? Colors.black : Colors.white;
  return baseColor.withValues(alpha: isDark ? 0.82 : 0.9);
}

class _HomeTopOverlay extends ConsumerWidget {
  const _HomeTopOverlay({required this.fadeHeight});

  final double fadeHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.black : Colors.white;
    final panelColor = _homePanelColor(context);
    final showBalance = ref.watch(homeNotifierProvider).currentWallet?.showBalance ?? false;
    final isRoundUp = ref.watch(settingsNotifierProvider.select((s) => s.isRoundUp));
    final total = ref.watch(transactionNotifierProvider.select((s) => s.analyticsTotal));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ColoredBox(
          color: panelColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showBalance)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                panelColor,
                baseColor.withValues(alpha: 0.0),
              ],
            ),
          ),
          child: SizedBox(height: fadeHeight, width: double.infinity),
        ),
      ],
    );
  }
}

class _HomeBottomOverlay extends ConsumerWidget {
  const _HomeBottomOverlay({required this.bottomSafe});

  final double bottomSafe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.black : Colors.white;
    final panelColor = _homePanelColor(context);

    final homeState = ref.watch(homeNotifierProvider);
    final wallets = ref.watch(walletNotifierProvider.select((s) => s.wallets));
    final currentIndex = wallets.indexWhere((e) => e.id == homeState.currentWallet?.id);

    final barButtonColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFD9D9D9);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                baseColor.withValues(alpha: 0.0),
                panelColor,
              ],
            ),
          ),
          child: _WalletDots(
            walletCount: wallets.length,
            currentIndex: currentIndex,
            onSwipe: (offset) =>
                ref.read(homeNotifierProvider.notifier).swipeWallet(offset),
          ),
        ),
        ColoredBox(
          color: panelColor,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomSafe),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Theme(
                data: Theme.of(context).copyWith(
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: barButtonColor,
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: AppTextStyle.text16w400(),
                    ),
                  ),
                  iconButtonTheme: IconButtonThemeData(
                    style: IconButton.styleFrom(
                      backgroundColor: barButtonColor,
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                ),
                child: const SettingTransaction(),
              ),
            ),
          ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
