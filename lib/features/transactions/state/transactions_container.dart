import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../screens/transactions_list_screen.dart';
import '../screens/transaction_form_screen.dart';

enum Screen { list, form }

class TransactionsContainer extends StatefulWidget {
  const TransactionsContainer({super.key});

  @override
  State<TransactionsContainer> createState() => _TransactionsContainerState();
}

class _TransactionsContainerState extends State<TransactionsContainer> {
  final List<Transaction> _transactions = [];
  Screen _currentScreen = Screen.list;

  void _showList() {
    setState(() => _currentScreen = Screen.list);
  }

  void _showForm() {
    setState(() => _currentScreen = Screen.form);
  }

  void _addTransaction(String title, String description, double amount, bool isExpense, String category) {
    setState(() {
      final newTransaction = Transaction(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
        description: description,
        amount: amount,
        createdAt: DateTime.now(),
        isExpense: isExpense,
        category: category,
      );
      _transactions.insert(0, newTransaction); // Добавляем в начало списка
      _currentScreen = Screen.list;
    });
  }

  void _toggleTransaction(String id) {
    setState(() {
      final index = _transactions.indexWhere((t) => t.id == id);
      if (index != -1) {
        final transaction = _transactions[index];
        _transactions[index] = transaction.copyWith(
          isExpense: !transaction.isExpense,
        );
      }
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentScreen) {
      case Screen.list:
        return TransactionsListScreen(
          transactions: _transactions,
          onAdd: _showForm,
          onToggle: _toggleTransaction,
          onDelete: _deleteTransaction,
        );
      case Screen.form:
        return TransactionFormScreen(
          onSave: _addTransaction,
          onCancel: _showList,
        );
    }
  }
}