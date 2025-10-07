import 'package:flutter/material.dart';

class TransactionFormScreen extends StatefulWidget {
  final void Function(String title, String description, double amount, bool isExpense, String category) onSave;
  final VoidCallback onCancel;

  const TransactionFormScreen({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();

  bool _isExpense = true;
  final List<String> _categories = [
    'Еда', 'Транспорт', 'Развлечения', 'Одежда',
    'Здоровье', 'Образование', 'Дом', 'Другое'
  ];
  String _selectedCategory = 'Еда';

  void _submit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;

    if (title.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заполните название и сумму (больше 0)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    widget.onSave(title, description, amount, _isExpense, _selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая транзакция'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onCancel,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Тип транзакции (доход/расход)
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment<bool>(
                  value: true,
                  label: Text('Расход'),
                  icon: Icon(Icons.arrow_upward),
                ),
                ButtonSegment<bool>(
                  value: false,
                  label: Text('Доход'),
                  icon: Icon(Icons.arrow_downward),
                ),
              ],
              selected: {_isExpense},
              onSelectionChanged: (Set<bool> newSelection) {
                setState(() {
                  _isExpense = newSelection.first;
                });
              },
            ),

            const SizedBox(height: 20),

            // Поле названия
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Название *',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Поле описания
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Описание',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Поле суммы
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Сумма *',
                border: OutlineInputBorder(),
                prefixText: '₽ ',
              ),
            ),

            const SizedBox(height: 16),

            // Выбор категории
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Категория',
                border: OutlineInputBorder(),
              ),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),

            const SizedBox(height: 30),

            // Кнопка сохранения
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Добавить транзакцию'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}