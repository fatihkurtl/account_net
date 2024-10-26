import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class IncomeTrackingScreen extends StatefulWidget {
  const IncomeTrackingScreen({super.key});

  @override
  _IncomeTrackingScreenState createState() => _IncomeTrackingScreenState();
}

class _IncomeTrackingScreenState extends State<IncomeTrackingScreen> {
  final List<Map<String, dynamic>> _incomes = [];
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'Satış';
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addIncome() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _incomes.add({
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
        title: const Text('Gelir Takibi'),
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
          _buildIncomeChart(),
          Expanded(
            child: _incomes.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.account_balance_wallet, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Henüz gelir kaydı yok.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _incomes.length,
                    itemBuilder: (context, index) {
                      final income = _incomes[index];
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
                            _incomes.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Gelir kaydı silindi')),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getCategoryColor(income['category']),
                              child: Icon(_getCategoryIcon(income['category']), color: Colors.white),
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
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddIncomeDialog(),
        label: const Text('Gelir Ekle'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard() {
    double totalIncome = _incomes.fold(0, (sum, item) => sum + item['amount']);
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Toplam Gelir', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              '₺${totalIncome.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeChart() {
    if (_incomes.isEmpty) return const SizedBox.shrink();

    Map<String, double> categoryTotals = {};
    for (var income in _incomes) {
      categoryTotals[income['category']] = (categoryTotals[income['category']] ?? 0) + income['amount'];
    }

    List<PieChartSectionData> sections = categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        color: _getCategoryColor(entry.key),
        value: entry.value,
        title: '${(entry.value / _incomes.fold(0, (sum, item) => sum + item['amount']) * 100).toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gelir Dağılımı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
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

  void _showAddIncomeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Yeni Gelir Ekle'),
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
                    items: ['Satış', 'Hizmet', 'Kira', 'Diğer'].map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
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
                  _addIncome();
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
      case 'Satış':
        return Colors.blue;
      case 'Hizmet':
        return Colors.green;
      case 'Kira':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Satış':
        return Icons.shopping_cart;
      case 'Hizmet':
        return Icons.build;
      case 'Kira':
        return Icons.home;
      default:
        return Icons.attach_money;
    }
  }
}
