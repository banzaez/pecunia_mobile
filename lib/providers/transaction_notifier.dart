import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pecunia/models/analytics_total.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/providers/sql_provider_ref.dart';

part 'transaction_notifier.g.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class TransactionState {
  static const int pageSize = 50;

  final int walletId;
  final List<Transaction> transactions;
  final AnalyticsTotal analyticsTotal;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;

  const TransactionState({
    this.walletId = 0,
    this.transactions = const [],
    AnalyticsTotal? analyticsTotal,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.error,
  }) : analyticsTotal = analyticsTotal ?? const AnalyticsTotal(0, 0, 0);

  TransactionState copyWith({
    int? walletId,
    List<Transaction>? transactions,
    AnalyticsTotal? analyticsTotal,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    bool clearError = false,
  }) =>
      TransactionState(
        walletId: walletId ?? this.walletId,
        transactions: transactions ?? this.transactions,
        analyticsTotal: analyticsTotal ?? this.analyticsTotal,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMore: hasMore ?? this.hasMore,
        error: clearError ? null : (error ?? this.error),
      );
}

// ---------------------------------------------------------------------------
// TransactionNotifier
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true, name: 'transactionNotifierProvider')
class TransactionNotifier extends _$TransactionNotifier {
  bool _loadMoreInFlight = false;

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
      final sql = ref.read(sqlProviderProvider).transactions;
      final walletId = state.walletId;

      final results = await Future.wait<Object>([
        sql.selectByWalletId(
          walletId,
          limit: TransactionState.pageSize,
          offset: 0,
        ),
        sql.countByWalletId(walletId),
        sql.selectTotalByWallet(walletId),
      ]);

      final list = results[0] as List<Transaction>;
      final total = results[1] as int;
      final analyticsTotal = results[2] as AnalyticsTotal;

      state = state.copyWith(
        isLoading: false,
        transactions: list,
        hasMore: list.length < total,
        analyticsTotal: analyticsTotal,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading || _loadMoreInFlight) {
      return;
    }

    _loadMoreInFlight = true;
    state = state.copyWith(isLoadingMore: true, clearError: true);
    try {
      final sql = ref.read(sqlProviderProvider).transactions;
      final offset = state.transactions.length;
      final list = await sql.selectByWalletId(
        state.walletId,
        limit: TransactionState.pageSize,
        offset: offset,
      );
      final merged = [...state.transactions, ...list];
      state = state.copyWith(
        transactions: merged,
        hasMore: list.length >= TransactionState.pageSize,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    } finally {
      _loadMoreInFlight = false;
    }
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

  void clearError() => state = state.copyWith(clearError: true);
}
