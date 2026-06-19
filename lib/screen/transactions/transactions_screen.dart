import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/finance_categories.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/screen/transactions/transactions_arguments.dart';
import 'package:pecunia/styles/app_text_style.dart';
import 'package:pecunia/util/app_spaces.dart';
import 'package:pecunia/util/category_icon_helper.dart';
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';
import 'package:pecunia/styles/app_colors.dart';
import 'package:pecunia/widgets/empty_state_view.dart';
import 'package:pecunia/widgets/staggered_fade_in.dart';
import 'package:pecunia/widgets/transaction_item.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key, required this.args});

  final TransactionsArguments args;

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  bool _isLoading = true;
  String? _loadError;
  List<Transaction> _transactions = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadTransactions();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  Future<void> _loadTransactions() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });
    try {
      final list = await ref
          .read(transactionNotifierProvider.notifier)
          .selectByWalletIdAndCategoryAndByPeriod(
            widget.args.walletId,
            widget.args.categoryId,
            widget.args.startDate,
            widget.args.endDate,
          );
      if (mounted) {
        setState(() {
          _transactions = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadError = e.toString();
        });
      }
    }
  }

  Future<bool> _deleteTransaction(int id) async {
    await ref.read(transactionNotifierProvider.notifier).deleteSQL(id);
    final success = ref.read(transactionNotifierProvider).error == null;
    if (success && mounted) {
      setState(() => _transactions.removeWhere((transaction) => transaction.id == id));
    }
    return success;
  }

  List<Transaction> _getFilteredTransactions(AppLocalizations l10n) {
    if (_searchQuery.trim().isEmpty) {
      return _transactions;
    }
    final query = _searchQuery.toLowerCase().trim();
    return _transactions.where((t) {
      final categoryName = t.category?.localizedName(l10n).toLowerCase() ?? '';
      final subcategoryName = t.subcategory?.localizedName(l10n).toLowerCase() ?? '';
      final desc = t.description.toLowerCase();
      final amount = t.amount.toString();
      final amountFormatted = t.amount.abs().toString();

      return categoryName.contains(query) ||
          subcategoryName.contains(query) ||
          desc.contains(query) ||
          amount.contains(query) ||
          amountFormatted.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isRoundUp = ref.watch(settingsNotifierProvider.select((s) => s.isRoundUp));
    return Scaffold(
      appBar: CustomAppBar(title: l10n.transactionsTitle),
      body: _list(isRoundUp, l10n),
    );
  }

  Widget _list(bool isRoundUp, AppLocalizations l10n) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_loadError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _loadError!,
                style: AppTextStyle.text14w400(),
                textAlign: TextAlign.center,
              ),
              AppSpaces.v16,
              ElevatedButton(
                onPressed: _loadTransactions,
                child: Text(l10n.startupErrorRetry),
              ),
            ],
          ),
        ),
      );
    }

    if (_transactions.isEmpty) {
      return _emptyState(l10n, isSearchEmpty: false);
    }

    final filtered = _getFilteredTransactions(l10n);
    final category = FinanceCategories.getCategoryById(widget.args.categoryId);

    // Вычисляем суммарную информацию по отфильтрованным транзакциям
    final totalAmount = filtered.fold<double>(0, (sum, item) => sum + item.amount);
    final isIncome = totalAmount != 0 
        ? totalAmount > 0 
        : FinanceCategories.incomeCategories.any((c) => c.id == category?.id);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final accentColor = isIncome 
        ? (isDark ? const Color(0xFF30D158) : const Color(0xFF34C759)) 
        : (isDark ? Colors.white : Colors.black87);

    final cardBgColor = isDark 
        ? Colors.white.withValues(alpha: 0.015) 
        : Colors.white.withValues(alpha: 0.7);
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.04);

    return Column(
      children: [
        // 1. Summary Card
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor),
              boxShadow: isDark ? null : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                // Category Icon with Double Ring
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.25),
                      width: 1,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CategoryIconHelper.getIcon(category?.name),
                      color: accentColor,
                      size: 24,
                    ),
                  ),
                ),
                AppSpaces.h16,
                // Category Name & Transactions Count
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category?.localizedName(l10n) ?? l10n.transactionsTitle,
                        style: AppTextStyle.text16w600(
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${filtered.length} ${l10n.analyticsCategoryItemCount}",
                        style: AppTextStyle.text12w400(
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpaces.h16,
                // Total Sum & Label
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      (totalAmount > 0 ? "+" : "") + totalAmount.formatSumCustom(roundUp: isRoundUp),
                      style: AppTextStyle.text18w700(
                        color: accentColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.totalForPeriod,
                      style: AppTextStyle.text10w400(
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // 2. Search Input Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.015),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.03),
              ),
            ),
            child: TextField(
              controller: _searchController,
              style: AppTextStyle.text14w600(
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: l10n.searchPlaceholder,
                hintStyle: AppTextStyle.text14w400(
                  color: isDark ? Colors.white30 : Colors.black38,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: isDark ? Colors.white38 : Colors.black38,
                  size: 20,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        color: isDark ? Colors.white54 : Colors.black54,
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        // 3. Transactions List / Empty State
        Expanded(
          child: filtered.isEmpty
              ? _emptyState(l10n, isSearchEmpty: true)
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16, top: 4),
                  itemCount: filtered.length,
                  itemBuilder: (_, index) {
                    final item = filtered[index];
                    return StaggeredFadeIn(
                      key: ValueKey(item.id),
                      index: index,
                      child: TransactionItem(
                        key: ValueKey(item.id),
                        transaction: item,
                        isRoundUp: isRoundUp,
                        onDelete: () => _deleteTransaction(item.id),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _emptyState(AppLocalizations l10n, {required bool isSearchEmpty}) =>
      EmptyStateView(
        icon: isSearchEmpty ? Icons.search_off_rounded : Icons.receipt_long_rounded,
        title: isSearchEmpty ? l10n.emptySearchTitle : l10n.emptyTransactionsTitle,
        subtitle: isSearchEmpty ? l10n.emptySearchDesc : l10n.emptyTransactionsDesc,
        accentColor: isSearchEmpty ? Colors.grey : AppColors.accentIndigo,
      );
}
