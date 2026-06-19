enum TransactionType {
  income,
  expense;

  int get i => this == income ? 1 : -1;
}
