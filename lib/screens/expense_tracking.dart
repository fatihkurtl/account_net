import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseTrackingScreen extends StatefulWidget {
  const ExpenseTrackingScreen({Key? key}) : super(key: key);

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
          _buildSummaryCard(),
          _buildExpenseChart(),
          Expanded(
            child: _expenses.isEmpty
                ? Center(
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
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) {
                      final expense = _expenses[index];
                      return Dismissible(
                        key: Key(expense['description']),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            _expenses.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gider kaydı silindi')),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getCategoryColor(expense['category']),
                              child: Icon(_getCategoryIcon(expense['category']), color: Colors.white),
                            ),
                            title: Text(expense['description']),
                            subtitle: Text('${expense['category']} - ${DateFormat('dd/MM/yyyy').format(expense['date'])}'),
                            trailing: Text(
                              '₺${expense['amount'].toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddExpenseDialog(),
        label: Text('Gider Ekle'),
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard() {
    double totalExpense = _expenses.fold(0, (sum, item) => sum + item['amount']);
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Toplam Gider', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              '₺${totalExpense.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseChart() {
    if (_expenses.isEmpty) return SizedBox.shrink();

    Map<String, double> categoryTotals = {};
    for (var expense in _expenses) {
      categoryTotals[expense['category']] = (categoryTotals[expense['category']] ?? 0) + expense['amount'];
    }

    List<PieChartSectionData> sections = categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        color: _getCategoryColor(entry.key),
        value: entry.value,
        title: '${(entry.value / _expenses.fold(0, (sum, item) => sum + item['amount']) * 100).toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gider Dağılımı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yeni Gider Ekle'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Açıklama'),
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
                    decoration: InputDecoration(labelText: 'Miktar (₺)'),
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
                    decoration: InputDecoration(labelText: 'Kategori'),
                    items: ['Malzeme', 'İşçilik', 'Nakliye', 'Diğer'].map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
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
                      decoration: InputDecoration(labelText: 'Tarih'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                          Icon(Icons.calendar_today),
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
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Ekle'),
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Malzeme':
        return Colors.blue;
      case 'İşçilik':
        return Colors.green;
      case 'Nakliye':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Malzeme':
        return Icons.inventory;
      case 'İşçilik':
        return Icons.engineering;
      case 'Nakliye':
        return Icons.local_shipping;
      default:
        return Icons.category;
    }
  }
}
