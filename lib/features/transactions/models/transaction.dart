class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime createdAt;
  final bool isExpense; // true - расход, false - доход
  final String category;

  const Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.createdAt,
    required this.isExpense,
    required this.category,
  });

  Transaction copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    DateTime? createdAt,
    bool? isExpense,
    String? category,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      isExpense: isExpense ?? this.isExpense,
      category: category ?? this.category,
    );
  }
}