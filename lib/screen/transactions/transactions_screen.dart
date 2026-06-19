import 'dart:math';

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
import 'package:pecunia/util/ext_double.dart';
import 'package:pecunia/widgets/custom_app_bar.dart';
import 'package:pecunia/widgets/transaction_item.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key, required this.args});

  final TransactionsArguments args;

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  bool _isLoading = true;
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

  IconData _getCategoryIcon(String? name) {
    if (name == null) return Icons.category_rounded;
    final lower = name.toLowerCase();

    if (lower.contains('salary')) return Icons.payments_rounded;
    if (lower.contains('bonus')) return Icons.card_giftcard_rounded;
    if (lower.contains('gift')) return Icons.card_giftcard_rounded;
    if (lower.contains('invest')) return Icons.trending_up_rounded;
    if (lower.contains('rent')) return Icons.home_work_rounded;
    if (lower.contains('freelance')) return Icons.laptop_mac_rounded;
    if (lower.contains('dividend')) return Icons.account_balance_wallet_rounded;
    if (lower.contains('cashback')) return Icons.monetization_on_rounded;
    if (lower.contains('income')) return Icons.arrow_downward_rounded;

    if (lower.contains('food') || lower.contains('restaurant') || lower.contains('cafe')) return Icons.restaurant_rounded;
    if (lower.contains('grocer')) return Icons.local_grocery_store_rounded;
    if (lower.contains('publictransport') || lower.contains('bus') || lower.contains('metro')) return Icons.directions_bus_rounded;
    if (lower.contains('fuel')) return Icons.local_gas_station_rounded;
    if (lower.contains('parking')) return Icons.local_parking_rounded;
    if (lower.contains('transport') || lower.contains('auto') || lower.contains('car')) return Icons.directions_car_rounded;
    if (lower.contains('utilities') || lower.contains('utility')) return Icons.water_drop_rounded;
    if (lower.contains('repair') || lower.contains('maintenance')) return Icons.build_rounded;
    if (lower.contains('housing') || lower.contains('mortgage')) return Icons.home_rounded;
    if (lower.contains('clothing') || lower.contains('footwear') || lower.contains('shop')) return Icons.checkroom_rounded;
    if (lower.contains('medicine') || lower.contains('doctor') || lower.contains('health')) return Icons.medical_services_rounded;
    if (lower.contains('insurance')) return Icons.security_rounded;
    if (lower.contains('movie') || lower.contains('theater') || lower.contains('entertainment') || lower.contains('hobby')) return Icons.sports_esports_rounded;
    if (lower.contains('travel') || lower.contains('vacation')) return Icons.flight_takeoff_rounded;
    if (lower.contains('sport') || lower.contains('fitness') || lower.contains('gym')) return Icons.fitness_center_rounded;
    if (lower.contains('education') || lower.contains('course') || lower.contains('learn')) return Icons.school_rounded;
    if (lower.contains('loan') || lower.contains('debt')) return Icons.money_off_rounded;
    if (lower.contains('pet') || lower.contains('vet')) return Icons.pets_rounded;
    if (lower.contains('charity')) return Icons.favorite_rounded;
    if (lower.contains('internet') || lower.contains('communication') || lower.contains('phone')) return Icons.wifi_rounded;
    if (lower.contains('transfer')) return Icons.swap_horiz_rounded;

    return Icons.category_rounded;
  }

  String _getSearchPlaceholder(String locale) {
    return switch (locale) {
      'ru' => 'Поиск по описанию, категории или сумме...',
      'uk' => 'Пошук за описом, категорією або сумою...',
      'pl' => 'Szukaj według opisu, kategorii lub kwoty...',
      'es' => 'Buscar por descripción, categoría o monto...',
      'fr' => 'Recherche par description, catégorie ou montant...',
      _ => 'Search by description, category, or amount...',
    };
  }

  String _getEmptyTitle(String locale, bool isSearch) {
    if (isSearch) {
      return switch (locale) {
        'ru' => 'Ничего не найдено',
        'uk' => 'Нічого не знайдено',
        'pl' => 'Nic nie znaleziono',
        'es' => 'No se encontraron resultados',
        'fr' => 'Aucun résultat trouvé',
        _ => 'No results found',
      };
    } else {
      return switch (locale) {
        'ru' => 'Транзакции отсутствуют',
        'uk' => 'Транзакції відсутні',
        'pl' => 'Brak transakcji',
        'es' => 'No hay transacciones',
        'fr' => 'Aucune transaction',
        _ => 'No transactions',
      };
    }
  }

  String _getEmptyDesc(String locale, bool isSearch) {
    if (isSearch) {
      return switch (locale) {
        'ru' => 'Попробуйте изменить поисковый запрос или сбросить фильтры.',
        'uk' => 'Спробуйте змінити пошуковий запит або скинути фільтри.',
        'pl' => 'Spróbuj zmienić zapytanie lub zresetować filtry.',
        'es' => 'Intente cambiar el término de búsqueda o restablecer los filtros.',
        'fr' => 'Essayez de modifier votre recherche ou de réinitialiser les filtres.',
        _ => 'Try changing your search query or clearing the filter.',
      };
    } else {
      return switch (locale) {
        'ru' => 'В этой категории за выбранный период не найдено ни одной операции.',
        'uk' => 'У цій категорії за вибраний період не знайдено жодної операції.',
        'pl' => 'W tej kategorii w wybranym okresie nie znaleziono żadnych operacji.',
        'es' => 'No se encontraron operaciones en esta categoría para el período seleccionado.',
        'fr' => 'Aucune opération trouvée dans cette catégorie pour la période sélectionnée.',
        _ => 'No operations found in this category for the selected period.',
      };
    }
  }

  String _getTotalLabel(String locale) {
    return switch (locale) {
      'ru' => 'Всего за период',
      'uk' => 'Всього за період',
      'pl' => 'Łącznie za okres',
      'es' => 'Total del periodo',
      'fr' => 'Total pour la période',
      _ => 'Total for period',
    };
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

    final locale = Localizations.localeOf(context).languageCode;

    if (_transactions.isEmpty) {
      return _emptyState(locale, isSearchEmpty: false);
    }

    final filtered = _getFilteredTransactions(l10n);
    final category = FinanceCategories.getCategoryById(widget.args.categoryId);

    // Вычисляем суммарную информацию по отфильтрованным транзакциям
    final totalAmount = filtered.fold<double>(0, (sum, item) => sum + item.amount);
    final isIncome = totalAmount != 0 
        ? totalAmount > 0 
        : FinanceCategories.incomeCategories.any((c) => c.id == category?.id);
    final accentColor = isIncome ? const Color(0xFF2E7D32) : const Color(0xFFC62828);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBgColor = isDark 
        ? Colors.white.withValues(alpha: 0.025) 
        : Colors.white;
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
                      _getCategoryIcon(category?.name),
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
                      _getTotalLabel(locale),
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
                hintText: _getSearchPlaceholder(locale),
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
              ? _emptyState(locale, isSearchEmpty: true)
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16, top: 4),
                  itemCount: filtered.length,
                  itemBuilder: (_, index) {
                    final item = filtered[index];
                    return _StaggeredFadeIn(
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

  Widget _emptyState(String locale, {required bool isSearchEmpty}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accentColor = isSearchEmpty ? const Color(0xFF9E9E9E) : const Color(0xFF3F51B5);

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Glowing Illustration Icon
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
                    isSearchEmpty ? Icons.search_off_rounded : Icons.receipt_long_rounded,
                    color: isDark ? Colors.white70 : accentColor,
                    size: 32,
                  ),
                ),
              ),
              AppSpaces.v24,
              // Main message
              Text(
                _getEmptyTitle(locale, isSearchEmpty),
                style: AppTextStyle.text15w600(
                  color: isDark ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpaces.v8,
              // Helpful subtitle
              Text(
                _getEmptyDesc(locale, isSearchEmpty),
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
}

class _StaggeredFadeIn extends StatefulWidget {
  const _StaggeredFadeIn({
    super.key,
    required this.child,
    required this.index,
  });

  final Widget child;
  final int index;

  @override
  State<_StaggeredFadeIn> createState() => _StaggeredFadeInState();
}

class _StaggeredFadeInState extends State<_StaggeredFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    final delay = Duration(milliseconds: min(widget.index * 40, 300));
    Future.delayed(delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

