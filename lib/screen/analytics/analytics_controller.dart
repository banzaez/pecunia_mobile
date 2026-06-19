import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/models/analytics.dart';
import 'package:pecunia/models/analytics_filter.dart';
import 'package:pecunia/providers/sql_provider_ref.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/screen/transactions/transactions_arguments.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/widgets/fields/pick_date/pick_date_type.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class AnalyticsState {
  final List<Analytics> category;
  final List<Analytics> subcategory;
  final DateTime date;
  final DateType period;
  final AnalyticsFilter filter;
  final bool isLoading;
  final String? error;
  final List<int> valuesYear;
  final List<int> valuesMonth;
  final List<int> valuesDay;

  AnalyticsState({
    this.category = const [],
    this.subcategory = const [],
    DateTime? date,
    this.period = DateType.year,
    this.filter = AnalyticsFilter.total,
    this.isLoading = false,
    this.error,
    this.valuesYear = const [],
    this.valuesMonth = const [],
    this.valuesDay = const [],
  }) : date = date ?? DateTime.now();

  AnalyticsState copyWith({
    List<Analytics>? category,
    List<Analytics>? subcategory,
    DateTime? date,
    DateType? period,
    AnalyticsFilter? filter,
    bool? isLoading,
    String? error,
    bool clearError = false,
    List<int>? valuesYear,
    List<int>? valuesMonth,
    List<int>? valuesDay,
  }) =>
      AnalyticsState(
        category: category ?? this.category,
        subcategory: subcategory ?? this.subcategory,
        date: date ?? this.date,
        period: period ?? this.period,
        filter: filter ?? this.filter,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : (error ?? this.error),
        valuesYear: valuesYear ?? this.valuesYear,
        valuesMonth: valuesMonth ?? this.valuesMonth,
        valuesDay: valuesDay ?? this.valuesDay,
      );

  // ----------DATA-------------------------------------------------------------------------------

  double get total => category.fold(0.0, (acc, e) => acc + e.total);

  List<DateTime> get interval => switch (period) {
        DateType.year => [date.startOfYear, date.endOfYear],
        DateType.month => [date.startOfMonth, date.endOfMonth],
        DateType.day || DateType.hour || DateType.minute => [date.startOfDay, date.endOfDay],
      };

  String periodStr(String locale) => switch (period) {
        DateType.year => date.toFormat("yyyy"),
        DateType.month => date.toFormat("MMMM yyyy"),
        DateType.day || DateType.hour || DateType.minute => date.toFormat("dd MMMM yyyy"),
      };
}

// ---------------------------------------------------------------------------
// AnalyticsNotifier
// ---------------------------------------------------------------------------

class AnalyticsNotifier extends Notifier<AnalyticsState> {
  int _refreshGeneration = 0;

  @override
  AnalyticsState build() {
    ref.listen(
      transactionNotifierProvider.select(
        (s) => (
          s.walletId,
          s.analyticsTotal.total,
          s.analyticsTotal.income,
          s.analyticsTotal.expense,
        ),
      ),
      (prev, next) {
        if (next.$1 <= 0) return;
        if (prev == null) return;
        if (prev.$1 != next.$1) {
          _refreshAll();
        } else if (prev.$2 != next.$2 || prev.$3 != next.$3 || prev.$4 != next.$4) {
          _refreshAnalytics();
        }
      },
    );

    final walletId = ref.read(transactionNotifierProvider).walletId;
    if (walletId > 0) {
      Future.microtask(_refreshAll);
    }

    return AnalyticsState(date: DateTime.now().startOfDay);
  }

  int get _walletId => ref.read(transactionNotifierProvider).walletId;

  Future<void> _refreshAll() async {
    if (_walletId <= 0) return;

    final generation = ++_refreshGeneration;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await Future.wait([
        _refreshAnalytics(generation),
        _loadAvailableYears(generation),
        _loadAvailableMonths(generation),
        _loadAvailableDays(generation),
      ]);
    } catch (e) {
      if (generation == _refreshGeneration) {
        state = state.copyWith(error: e.toString());
      }
    } finally {
      if (generation == _refreshGeneration) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> _refreshAnalytics([int? generation]) async {
    final gen = generation ?? ++_refreshGeneration;
    if (_walletId <= 0) return;

    try {
      final results = await Future.wait([
        ref.read(sqlProviderProvider).analytics.selectByWalletId(
              walletId: _walletId,
              filter: state.filter,
              detail: false,
              startDate: state.interval.first,
              endDate: state.interval.last,
            ),
        ref.read(sqlProviderProvider).analytics.selectByWalletId(
              walletId: _walletId,
              filter: state.filter,
              detail: true,
              startDate: state.interval.first,
              endDate: state.interval.last,
            ),
      ]);
      if (gen != _refreshGeneration) return;
      ref.read(selectedCategoryIndexProvider.notifier).reset();
      state = state.copyWith(
        category: results[0],
        subcategory: results[1],
        clearError: true,
      );
    } catch (e) {
      if (gen != _refreshGeneration) return;
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> _loadAvailableYears([int? generation]) async {
    final gen = generation ?? _refreshGeneration;
    if (_walletId <= 0) return;

    final years = await ref.read(sqlProviderProvider).transactions.availableYears(_walletId);
    if (gen != _refreshGeneration) return;
    state = state.copyWith(valuesYear: years);
  }

  Future<void> _loadAvailableMonths([int? generation]) async {
    final gen = generation ?? _refreshGeneration;
    if (_walletId <= 0) return;

    final months = await ref
        .read(sqlProviderProvider)
        .transactions
        .availableMonths(_walletId, state.date.year);
    if (gen != _refreshGeneration) return;
    state = state.copyWith(valuesMonth: months);
  }

  Future<void> _loadAvailableDays([int? generation]) async {
    final gen = generation ?? _refreshGeneration;
    if (_walletId <= 0) return;

    final days = await ref
        .read(sqlProviderProvider)
        .transactions
        .availableDays(_walletId, state.date.year, state.date.month);
    if (gen != _refreshGeneration) return;
    state = state.copyWith(valuesDay: days);
  }

  void setFilter(AnalyticsFilter value) {
    if (state.filter == value) return;
    ref.read(selectedCategoryIndexProvider.notifier).reset();
    state = state.copyWith(filter: value, isLoading: true, clearError: true);
    final generation = ++_refreshGeneration;
    _applyFilterChange(generation);
  }

  Future<void> _applyFilterChange(int generation) async {
    try {
      await _refreshAnalytics(generation);
    } finally {
      if (generation == _refreshGeneration) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  void setDate(DateTime value, DateType type) {
    ref.read(selectedCategoryIndexProvider.notifier).reset();
    final prev = state.date;
    state = state.copyWith(
      date: value.startOfDay,
      period: type,
      isLoading: true,
      clearError: true,
    );
    final generation = ++_refreshGeneration;
    _applyDateChange(generation, value, prev);
  }

  Future<void> _applyDateChange(int generation, DateTime value, DateTime prev) async {
    try {
      await _refreshAnalytics(generation);
      if (generation != _refreshGeneration) return;
      if (value.year != prev.year) {
        await Future.wait([
          _loadAvailableMonths(generation),
          _loadAvailableDays(generation),
        ]);
      } else if (value.month != prev.month) {
        await _loadAvailableDays(generation);
      }
    } finally {
      if (generation == _refreshGeneration) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  void shiftPeriod(int delta) {
    DateTime nextDate;
    switch (state.period) {
      case DateType.year:
        nextDate = DateTime(state.date.year + delta, state.date.month, state.date.day);
      case DateType.month:
        nextDate = DateTime(state.date.year, state.date.month + delta, state.date.day);
      case DateType.day || DateType.hour || DateType.minute:
        nextDate = state.date.add(Duration(days: delta));
    }
    setDate(nextDate, state.period);
  }

  TransactionsArguments? buildDetailsArgs(int categoryId) {
    if (categoryId <= 0 || _walletId <= 0) return null;
    return TransactionsArguments(
      walletId: _walletId,
      categoryId: categoryId,
      startDate: state.interval.first,
      endDate: state.interval.last,
    );
  }

  void clearError() => state = state.copyWith(clearError: true);
}

class SelectedCategoryIndex extends Notifier<int?> {
  @override
  int? build() => null;

  void setIndex(int? value) => state = value;
  void reset() => state = null;
}

final selectedCategoryIndexProvider = NotifierProvider<SelectedCategoryIndex, int?>(
  SelectedCategoryIndex.new,
);

final analyticsNotifierProvider = NotifierProvider<AnalyticsNotifier, AnalyticsState>(
  AnalyticsNotifier.new,
);
