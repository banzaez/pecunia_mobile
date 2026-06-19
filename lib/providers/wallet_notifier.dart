import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pecunia/models/wallet.dart';
import 'package:pecunia/providers/sql_provider_ref.dart';

part 'wallet_notifier.g.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class WalletState {
  final List<Wallet> wallets;
  final bool isEditing;
  final bool isLoading;
  final String? error;

  const WalletState({
    this.wallets = const [],
    this.isEditing = false,
    this.isLoading = false,
    this.error,
  });

  WalletState copyWith({
    List<Wallet>? wallets,
    bool? isEditing,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      WalletState(
        wallets: wallets ?? this.wallets,
        isEditing: isEditing ?? this.isEditing,
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
    // Загружаем кошельки при инициализации
    Future.microtask(() => refreshWallets());
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
    if (state.wallets.length <= 1) return;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await ref.read(sqlProviderProvider).wallets.delete(id: id);
      await refreshWallets();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setEditing(bool value) => state = state.copyWith(isEditing: value);

  void clearError() => state = state.copyWith(clearError: true);
}
