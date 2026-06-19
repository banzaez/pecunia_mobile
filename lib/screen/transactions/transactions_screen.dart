import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/l10n/app_localizations.dart';
import 'package:pecunia/models/transaction.dart';
import 'package:pecunia/providers/settings_notifier.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/screen/transactions/transactions_arguments.dart';
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

  @override
  void initState() {
    super.initState();
    _loadTransactions();
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isRoundUp = ref.watch(settingsNotifierProvider.select((s) => s.isRoundUp));
    return Scaffold(
      appBar: CustomAppBar(title: l10n.transactionsTitle),
      body: _list(isRoundUp),
    );
  }

  Widget _list(bool isRoundUp) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: _transactions.length,
      itemBuilder: (_, index) => TransactionItem(
        key: ValueKey(_transactions[index].id),
        transaction: _transactions[index],
        isRoundUp: isRoundUp,
        onDelete: () => _deleteTransaction(_transactions[index].id),
      ),
    );
  }
}
