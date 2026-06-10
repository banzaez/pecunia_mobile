import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/models/analytics_total.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/providers/wallet_notifier.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class HomeState {
  final Wallet? currentWallet;
  final bool isInitializing;

  const HomeState({this.currentWallet, this.isInitializing = true});

  HomeState copyWith({Wallet? currentWallet, bool? isInitializing}) => HomeState(
        currentWallet: currentWallet ?? this.currentWallet,
        isInitializing: isInitializing ?? this.isInitializing,
      );
}

// ---------------------------------------------------------------------------
// HomeNotifier
// ---------------------------------------------------------------------------

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    // Listen wallet changes
    ref.listen(walletNotifierProvider, (prev, next) {
      if (next.wallets.isNotEmpty) {
        _onWalletsChanged(next.wallets);
      } else {
        state = const HomeState(isInitializing: true);
      }
    });

    // Initial load
    final wallets = ref.read(walletNotifierProvider).wallets;
    if (wallets.isNotEmpty) {
      final firstWallet = wallets.first;
      _selectWallet(firstWallet);
      return HomeState(currentWallet: firstWallet, isInitializing: false);
    }

    return const HomeState(isInitializing: true);
  }

  void _onWalletsChanged(List<Wallet> wallets) {
    final currentId = state.currentWallet?.id;
    final stillExists = currentId != null && wallets.any((w) => w.id == currentId);

    if (!stillExists) {
      _selectWallet(wallets.first);
      state = HomeState(currentWallet: wallets.first, isInitializing: false);
    } else {
      final updated = wallets.firstWhere((w) => w.id == currentId);
      _selectWallet(updated);
      state = HomeState(currentWallet: updated, isInitializing: false);
    }
  }

  void _selectWallet(Wallet wallet) {
    ref.read(settingsNotifierProvider.notifier).setRoundUp(wallet.isRoundUp);
    ref.read(transactionNotifierProvider.notifier).changeWallet(wallet.id);
  }

  void selectWallet(Wallet wallet) {
    _selectWallet(wallet);
    state = HomeState(currentWallet: wallet, isInitializing: false);
  }

  // -----------GETTERS---------------------------------------------------------

  List<Wallet> get wallets => ref.read(walletNotifierProvider).wallets;
  AnalyticsTotal get total => ref.read(transactionNotifierProvider).analyticsTotal;
  List<Transaction> get transactions => ref.read(transactionNotifierProvider).transactions;

  int get currentIndex =>
      wallets.indexWhere((e) => e.id == state.currentWallet?.id);

  // -----------SWIPE-----------------------------------------------------------

  void swipeWallet(int offset) {
    final wallets = ref.read(walletNotifierProvider).wallets;
    if (wallets.isEmpty) return;
    var index = currentIndex - offset;
    index = max(0, index);
    index = min(index, wallets.length - 1);
    selectWallet(wallets[index]);
  }
}

final homeNotifierProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
