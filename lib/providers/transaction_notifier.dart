import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pecunia/models/analytics_total.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/providers/sql_provider_ref.dart';

part 'transaction_notifier.g.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class TransactionState {
  final int walletId;
  final List<Transaction> transactions;
  final AnalyticsTotal analyticsTotal;
  final bool isLoading;
  final String? error;

  const TransactionState({
    this.walletId = 0,
    this.transactions = const [],
    AnalyticsTotal? analyticsTotal,
    this.isLoading = false,
    this.error,
  }) : analyticsTotal = analyticsTotal ?? const AnalyticsTotal(0, 0, 0);

  TransactionState copyWith({
    int? walletId,
    List<Transaction>? transactions,
    AnalyticsTotal? analyticsTotal,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      TransactionState(
        walletId: walletId ?? this.walletId,
        transactions: transactions ?? this.transactions,
        analyticsTotal: analyticsTotal ?? this.analyticsTotal,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : (error ?? this.error),
      );
}

// ---------------------------------------------------------------------------
// TransactionNotifier
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true, name: 'transactionNotifierProvider')
class TransactionNotifier extends _$TransactionNotifier {
  @override
  TransactionState build() => const TransactionState();

  // -----------WALLET-SELECTION-----------------------------------------------

  Future<void> changeWallet(int walletId) async {
    state = state.copyWith(walletId: walletId);
    await refreshAll();
  }

  // -----------SQL------------------------------------------------------------

  Future<void> refreshAll() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await Future.wait([_refreshTransactions(), _refreshTotal()]);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _refreshTransactions() async {
    final list = await ref
        .read(sqlProviderProvider)
        .transactions
        .selectByWalletId(state.walletId);
    state = state.copyWith(transactions: list);
  }

  Future<void> _refreshTotal() async {
    final total = await ref
        .read(sqlProviderProvider)
        .transactions
        .selectTotalByWallet(state.walletId);
    state = state.copyWith(analyticsTotal: total);
  }

  Future<void> addSQL(Transaction transaction) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      if (transaction.walletId == 0) transaction.walletId = state.walletId;
      await ref.read(sqlProviderProvider).transactions.add(value: transaction);
      await refreshAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateSQL(Transaction transaction) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      if (transaction.walletId == 0) transaction.walletId = state.walletId;
      await ref.read(sqlProviderProvider).transactions.update(value: transaction);
      await refreshAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteSQL(int id) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await ref.read(sqlProviderProvider).transactions.delete(id: id);
      await refreshAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addTransferSQL(Transaction from, Transaction to) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await ref
          .read(sqlProviderProvider)
          .transactions
          .addBatch(values: [from, to]);
      await refreshAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<List<Transaction>> selectByWalletIdAndCategoryAndByPeriod(
    int walletId,
    int categoryId,
    DateTime startDate,
    DateTime endDate,
  ) =>
      ref
          .read(sqlProviderProvider)
          .transactions
          .selectByWalletIdAndCategoryAndByPeriod(
            walletId,
            categoryId,
            startDate,
            endDate,
          );
}
