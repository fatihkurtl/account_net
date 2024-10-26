import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:account_net/core/helpers/income/category.dart';

class IncomeList extends StatefulWidget {
  final List<Map<String, dynamic>> incomes;
  const IncomeList({super.key, required this.incomes});

  @override
  State<IncomeList> createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.incomes.length,
      itemBuilder: (context, index) {
        final income = widget.incomes[index];
        return Dismissible(
          key: Key(income['description']),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              widget.incomes.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gelir kaydı silindi')),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: CategoryHelper.getCategoryColor(income['category']),
                child: Icon(CategoryHelper.getCategoryIcon(income['category']), color: Colors.white),
              ),
              title: Text(income['description']),
              subtitle: Text('${income['category']} - ${DateFormat('dd/MM/yyyy').format(income['date'])}'),
              trailing: Text(
                '₺${income['amount'].toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
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
