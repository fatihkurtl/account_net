import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:account_net/core/constants/items.dart';
import 'package:account_net/core/widgets/expense/expense_list.dart';
import 'package:account_net/core/widgets/expense/expense_chart.dart';
import 'package:account_net/core/components/custom_floating_button.dart';
import 'package:account_net/core/widgets/expense/summary_card.dart';

class ExpenseTrackingScreen extends StatefulWidget {
  const ExpenseTrackingScreen({super.key});

  @override
  _ExpenseTrackingScreenState createState() => _ExpenseTrackingScreenState();
}

class _ExpenseTrackingScreenState extends State<ExpenseTrackingScreen> {
  final List<Map<String, dynamic>> _expenses = [];
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'Malzeme';
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addExpense() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _expenses.add({
          'description': _descriptionController.text,
          'amount': double.parse(_amountController.text),
          'category': _selectedCategory,
          'date': _selectedDate,
        });
        _descriptionController.clear();
        _amountController.clear();
        _selectedDate = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gider Takibi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filtering
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SummaryCard(expenses: _expenses),
          ExpenseChart(expenses: _expenses),
          Expanded(
            child: _expenses.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.money_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Henüz gider kaydı yok.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ExpenseList(
                    expenses: _expenses,
                    onDelete: (index) {
                      setState(() {
                        _expenses.removeAt(index);
                      });
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: _showAddExpenseDialog,
        buttonText: 'Gider Ekle',
        icon: Icons.add,
      ),
    );
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Yeni Gider Ekle'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Açıklama'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen bir açıklama girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(labelText: 'Miktar (₺)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen bir miktar girin';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Lütfen geçerli bir sayı girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(labelText: 'Kategori'),
                    items: ItemConstants.expenseItems.map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Tarih'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Ekle'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addExpense();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
