class TransactionsArguments {
  final int walletId;
  final int categoryId;
  final DateTime startDate;
  final DateTime endDate;

  TransactionsArguments({
    required this.walletId,
    required this.categoryId,
    required this.startDate,
    required this.endDate,
  });
}
