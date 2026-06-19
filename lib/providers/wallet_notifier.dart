import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/providers/sql_provider_ref.dart';

part 'wallet_notifier.g.dart';

const walletErrorLastWallet = '__last_wallet__';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class WalletState {
  final List<Wallet> wallets;
  final bool isLoading;
  final String? error;

  const WalletState({
    this.wallets = const [],
    this.isLoading = false,
    this.error,
  });

  WalletState copyWith({
    List<Wallet>? wallets,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      WalletState(
        wallets: wallets ?? this.wallets,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : (error ?? this.error),
      );
}

// ---------------------------------------------------------------------------
// WalletNotifier
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true, name: 'walletNotifierProvider')
class WalletNotifier extends _$WalletNotifier {
  @override
  WalletState build() {
    Future.microtask(refreshWallets);
    return const WalletState();
  }

  // -----------SQL------------------------------------------------------------

  Future<void> refreshWallets() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final wallets = await ref.read(sqlProviderProvider).wallets.selectAll();
      state = state.copyWith(wallets: wallets, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addSQL(Wallet wallet) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await ref.read(sqlProviderProvider).wallets.add(value: wallet);
      await refreshWallets();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateSQL(Wallet wallet) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await ref.read(sqlProviderProvider).wallets.update(value: wallet);
      await refreshWallets();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteSQL(int id) async {
    if (state.wallets.length <= 1) {
      state = state.copyWith(error: walletErrorLastWallet);
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await ref.read(sqlProviderProvider).wallets.delete(id: id);
      await refreshWallets();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() => state = state.copyWith(clearError: true);
}
