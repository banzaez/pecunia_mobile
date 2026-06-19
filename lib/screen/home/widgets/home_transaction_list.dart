import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pecunia/providers/transaction_notifier.dart';
import 'package:pecunia/screen/home/home_controller.dart';
import 'package:pecunia/widgets/transaction_item.dart';

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

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(
        top: widget.topPadding,
        bottom: widget.bottomPadding,
      ),
      clipBehavior: Clip.none,
      itemCount: transactions.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (_, index) {
        if (index >= transactions.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final transaction = transactions[index];
        return TransactionItem(
          key: ValueKey(transaction.id),
          transaction: transaction,
          isRoundUp: widget.isRoundUp,
          onDelete: () => _deleteTransaction(transaction.id),
          edgeToEdge: true,
        );
      },
    );
  }
}
