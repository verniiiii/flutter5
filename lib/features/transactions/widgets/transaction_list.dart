import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_row.dart';
import '../../../shared/widgets/empty_state.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onDelete;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onToggle,
    required this.onDelete,
  });

  double get totalBalance {
    double balance = 0;
    for (final transaction in transactions) {
      if (transaction.isExpense) {
        balance -= transaction.amount;
      } else {
        balance += transaction.amount;
      }
    }
    return balance;
  }

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const EmptyState(
        message: 'Нет транзакций\nДобавьте первую транзакцию',
        icon: Icons.account_balance_wallet,
      );
    }

    return Column(
      children: [
        // Карточка с общим балансом
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Общий баланс',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '${totalBalance.toStringAsFixed(2)} ₽',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: totalBalance >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Список транзакций
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return TransactionRow(
                key: ValueKey(transaction.id),
                transaction: transaction,
                onToggle: onToggle,
                onDelete: onDelete,
              );
            },
          ),
        ),
      ],
    );
  }
}