import 'package:flutter/material.dart';
import 'package:account_net/core/components/custom_appbar.dart';
// import 'package:intl/intl.dart';
import 'package:account_net/core/components/custom_date.dart';
import 'package:account_net/core/components/custom_dropdown.dart';
import 'package:account_net/core/components/custom_textfield.dart';
import 'package:account_net/core/widgets/income/income_list.dart';
import 'package:account_net/core/components/custom_floating_button.dart';
import 'package:account_net/core/constants/items.dart';
import 'package:account_net/core/widgets/income/income_chart.dart';
import 'package:account_net/core/widgets/income/summary_card.dart';

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
      backgroundColor: Colors.grey[300],
      appBar: CustomAppBar(
        elevation: 0,
        title: 'Gelir Takibi',
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
          letterSpacing: 0.5,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.grey[800],
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implement filtering
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SummaryCard(incomes: _incomes),
          IncomeChart(incomes: _incomes),
          Expanded(
            child: _incomes.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.account_balance_wallet,
                            size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Henüz gelir kaydı yok.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : IncomeList(
                    incomes: _incomes,
                    onDelete: (index) {
                      setState(
                        () {
                          _incomes.removeAt(index);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: _showAddIncomeDialog,
        buttonText: 'Gelir Ekle',
        icon: Icons.add,
      ),
    );
  }

  void _showAddIncomeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: const Text('Yeni Gelir Ekle'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    controller: _descriptionController,
                    hintText: 'Açıklama',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen bir açıklama girin';
                      }
                      return null;
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  // TextFormField(
                  //   controller: _descriptionController,
                  //   decoration: const InputDecoration(labelText: 'Açıklama'),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Lütfen bir açıklama girin';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _amountController,
                    hintText: 'Miktar (₺)',
                    obscureText: false,
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
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  // TextFormField(
                  //   controller: _amountController,
                  //   decoration: const InputDecoration(labelText: 'Miktar (₺)'),
                  //   keyboardType: TextInputType.number,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Lütfen bir miktar girin';
                  //     }
                  //     if (double.tryParse(value) == null) {
                  //       return 'Lütfen geçerli bir sayı girin';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    hintText: 'Kategori',
                    // value: _selectedCategory,
                    items: ItemConstants.incomeItems,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  // DropdownButtonFormField<String>(
                  //   value: _selectedCategory,
                  //   decoration: const InputDecoration(labelText: 'Kategori'),
                  //   items: ItemConstants.incomeItems.map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _selectedCategory = value!;
                  //     });
                  //   },
                  // ),
                  const SizedBox(height: 16),
                  CustomDateField(
                    hintText: 'Tarih',
                    selectedDate: _selectedDate,
                    onChanged: (date) {
                      setState(() {
                        _selectedDate = date ?? DateTime.now();
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  ),

                  // InkWell(
                  //   onTap: () async {
                  //     final DateTime? picked = await showDatePicker(
                  //       context: context,
                  //       initialDate: _selectedDate,
                  //       firstDate: DateTime(2000),
                  //       lastDate: DateTime(2101),
                  //     );
                  //     if (picked != null && picked != _selectedDate) {
                  //       setState(() {
                  //         _selectedDate = picked;
                  //       });
                  //     }
                  //   },
                  //   child: InputDecorator(
                  //     decoration: const InputDecoration(labelText: 'Tarih'),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                  //         const Icon(Icons.calendar_today),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'İptal',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                'Ekle',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
}
