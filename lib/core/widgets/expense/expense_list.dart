import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:account_net/core/helpers/expense/category.dart';

class ExpenseList extends StatefulWidget {
  final List<Map<String, dynamic>> expenses;
  final Function(int) onDelete;
  const ExpenseList({super.key, required this.expenses, required this.onDelete});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.expenses.length,
      itemBuilder: (context, index) {
        final expense = widget.expenses[index];
        return Dismissible(
          key: Key(expense['description']),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            widget.onDelete(index);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gider kaydı silindi')),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[200],
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: CategoryHelper.getCategoryColor(expense['category']),
                child: Icon(CategoryHelper.getCategoryIcon(expense['category']), color: Colors.white),
              ),
              title: Text(expense['description']),
              subtitle: Text('${expense['category']} - ${DateFormat('dd/MM/yyyy').format(expense['date'])}'),
              trailing: Text(
                '₺${expense['amount'].toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
