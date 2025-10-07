import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionRow extends StatelessWidget {
  final Transaction transaction;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onDelete;

  const TransactionRow({
    super.key,
    required this.transaction,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final color = transaction.isExpense ? Colors.red : Colors.green;
    final icon = transaction.isExpense ? Icons.arrow_upward : Icons.arrow_downward;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        transaction.title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          decoration: transaction.isExpense ? TextDecoration.none : TextDecoration.none,
        ),
      ),
      subtitle: Text(
        '${transaction.category} • ${transaction.createdAt.day}.${transaction.createdAt.month}.${transaction.createdAt.year}',
      ),
      trailing: Text(
        '${transaction.isExpense ? '-' : '+'}${transaction.amount.toStringAsFixed(2)} ₽',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onTap: () => onToggle(transaction.id),
    );
  }
}