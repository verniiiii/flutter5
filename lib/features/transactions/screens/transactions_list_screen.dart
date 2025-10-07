import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_list.dart';

class TransactionsListScreen extends StatelessWidget {
  final List<Transaction> transactions;
  final VoidCallback onAdd;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onDelete;

  const TransactionsListScreen({
    super.key,
    required this.transactions,
    required this.onAdd,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Финансовый трекер'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_chart),
            onPressed: onAdd,
            tooltip: 'Добавить транзакцию',
          ),
        ],
      ),
      body: TransactionList(
        transactions: transactions,
        onToggle: onToggle,
        onDelete: onDelete,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}