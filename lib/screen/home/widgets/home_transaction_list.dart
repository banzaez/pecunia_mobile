import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/widgets/staggered_fade_in.dart';
import 'package:pecunia/widgets/transaction_item.dart';

sealed class HomeListItem {}

class DateHeaderItem extends HomeListItem {
  final DateTime date;
  final double dayTotal;

  DateHeaderItem(this.date, this.dayTotal);
}

class TransactionItemWrapper extends HomeListItem {
  final Transaction transaction;

  TransactionItemWrapper(this.transaction);
}

class HomeTransactionList extends ConsumerStatefulWidget {
  const HomeTransactionList({
    super.key,
    required this.isRoundUp,
    required this.topPadding,
    required this.bottomPadding,
  });

  final bool isRoundUp;
  final double topPadding;
  final double bottomPadding;

  @override
  ConsumerState<HomeTransactionList> createState() => _HomeTransactionListState();
}

class _HomeTransactionListState extends ConsumerState<HomeTransactionList> {
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

  List<HomeListItem> _buildHomeList(List<Transaction> transactions) {
    final list = <HomeListItem>[];
    if (transactions.isEmpty) return list;

    DateTime? currentDay;
    final dayTransactions = <Transaction>[];

    void addCurrentGroup() {
      if (dayTransactions.isEmpty || currentDay == null) return;
      final dayTotal = dayTransactions.fold<double>(0, (sum, t) => sum + t.amount);
      list.add(DateHeaderItem(currentDay, dayTotal));
      for (final t in dayTransactions) {
        list.add(TransactionItemWrapper(t));
      }
      dayTransactions.clear();
    }

    for (final t in transactions) {
      final tDate = DateTime(t.createdAt.year, t.createdAt.month, t.createdAt.day);
      if (currentDay == null) {
        currentDay = tDate;
        dayTransactions.add(t);
      } else if (currentDay == tDate) {
        dayTransactions.add(t);
      } else {
        addCurrentGroup();
        currentDay = tDate;
        dayTransactions.add(t);
      }
    }
    addCurrentGroup();

    return list;
  }

  String _formatHeaderDate(DateTime date, AppLocalizations l10n, String locale) {
    if (date.isToday) {
      return l10n.dateToday;
    }
    if (date.isYesterday) {
      return l10n.dateYesterday;
    }

    final pattern = switch (locale) {
      'ru' => 'd MMMM, EEEE',
      'uk' => 'd MMMM, EEEE',
      'pl' => 'd MMMM, EEEE',
      'es' => 'd MMMM, EEEE',
      'fr' => 'd MMMM, EEEE',
      _ => 'EEEE, MMMM d',
    };
    try {
      final formatted = date.toFormat(pattern);
      if (formatted.isNotEmpty) {
        return formatted[0].toUpperCase() + formatted.substring(1);
      }
      return formatted;
    } catch (_) {
      return date.formatDDMMSYYYY;
    }
  }

  Widget _dateHeaderWidget(DateTime date, double dayTotal, AppLocalizations l10n, String locale, bool isDark) {
    final formattedDate = _formatHeaderDate(date, l10n, locale);
    final totalText = (dayTotal > 0 ? "+" : "") + dayTotal.formatSumCustom(roundUp: widget.isRoundUp);
    // Используем Apple Green для доходных дней, нейтральный для расходных
    final accentColor = dayTotal > 0
        ? (isDark ? const Color(0xFF30D158) : const Color(0xFF34C759))
        : dayTotal < 0
            ? (isDark ? Colors.white70 : Colors.black54)
            : (isDark ? Colors.white38 : Colors.black38);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedDate,
                style: AppTextStyle.text12w600(
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
              if (dayTotal != 0)
                Text(
                  totalText,
                  style: AppTextStyle.text12w600(
                    color: accentColor,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Divider(
            height: 1,
            thickness: 0.5,
            color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.06),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(AppLocalizations l10n, bool isDark) {
    final accentColor = const Color(0xFF3F51B5);
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      accentColor.withValues(alpha: 0.15),
                      accentColor.withValues(alpha: 0.05),
                    ],
                  ),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                  boxShadow: isDark ? null : [
                    BoxShadow(
                      color: accentColor.withValues(alpha: 0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.receipt_long_rounded,
                    color: isDark ? Colors.white70 : accentColor,
                    size: 32,
                  ),
                ),
              ),
              AppSpaces.v24,
              Text(
                l10n.emptyHistoryTitle,
                style: AppTextStyle.text15w600(
                  color: isDark ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpaces.v8,
              Text(
                l10n.emptyHistoryDesc,
                style: AppTextStyle.text12w400(
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
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

    final transactions = ref.watch(
      transactionNotifierProvider.select((s) => s.transactions),
    );
    final isLoadingMore = ref.watch(
      transactionNotifierProvider.select((s) => s.isLoadingMore),
    );

    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (transactions.isEmpty) {
      return _emptyState(l10n, isDark);
    }

    final listItems = _buildHomeList(transactions);

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(
        top: widget.topPadding,
        bottom: widget.bottomPadding,
      ),
      clipBehavior: Clip.none,
      itemCount: listItems.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (_, index) {
        if (index >= listItems.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final item = listItems[index];

        if (item is DateHeaderItem) {
          return _dateHeaderWidget(item.date, item.dayTotal, l10n, locale, isDark);
        } else if (item is TransactionItemWrapper) {
          final transaction = item.transaction;
          return StaggeredFadeIn(
            key: ValueKey(transaction.id),
            index: index,
            child: TransactionItem(
              key: ValueKey(transaction.id),
              transaction: transaction,
              isRoundUp: widget.isRoundUp,
              onDelete: () => _deleteTransaction(transaction.id),
              edgeToEdge: true,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
