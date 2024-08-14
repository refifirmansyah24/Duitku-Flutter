class Transaction {
  final int id;
  final String name;
  final int amount;
  final int categoryId;
  final DateTime transactionDate;

  Transaction({
    required this.id,
    required this.name,
    required this.amount,
    required this.categoryId,
    required this.transactionDate,
  });
}
