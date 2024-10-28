import 'package:account_net/core/components/custom_date.dart';
import 'package:account_net/core/components/custom_dropdown.dart';
import 'package:account_net/core/components/custom_floating_button.dart';
import 'package:account_net/core/components/custom_textfield.dart';
import 'package:account_net/core/constants/items.dart';
import 'package:account_net/core/widgets/invoice/invoice_list.dart';
import 'package:flutter/material.dart';

class InvoiceManagementScreen extends StatefulWidget {
  const InvoiceManagementScreen({super.key});

  @override
  _InvoiceManagementScreenState createState() => _InvoiceManagementScreenState();
}

class _InvoiceManagementScreenState extends State<InvoiceManagementScreen> {
  final List<Map<String, dynamic>> _invoices = [];
  final DateTime _selectedDate = DateTime.now();

  void _addInvoice() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String description = '';
        double amount = 0;
        String type = 'Elektrik';
        DateTime dueDate = DateTime.now();

        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.grey[300],
          title: const Text('Fatura Ekle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  onChanged: (value) => description = value,
                  hintText: 'Açıklama',
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  onChanged: (value) => amount = double.tryParse(value) ?? 0,
                  keyboardType: TextInputType.number,
                  hintText: 'Tutar',
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                CustomDropdown(
                  hintText: 'Tür',
                  items: ItemConstants.invoiceItems,
                  // selectedItem: type,
                  onChanged: (String? newValue) {
                    setState(() {
                      type = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomDateField(
                  hintText: 'Son Ödeme Tarihi',
                  selectedDate: _selectedDate,
                  onChanged: (date) async {
                    setState(() {
                      dueDate = date!;
                    });
                  },
                ),
              ],
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
                setState(() {
                  _invoices.add({
                    'description': description,
                    'amount': amount,
                    'type': type,
                    'dueDate': dueDate,
                  });
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Fatura Yönetimi'),
      ),
      body: ListView.builder(
        itemCount: _invoices.length,
        itemBuilder: (context, index) {
          final invoice = _invoices[index];
          return InvoiceList(
            invoices: invoice,
          );
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        icon: Icons.add,
        onPressed: _addInvoice,
        buttonText: 'Fatura Ekle',
      ),
    );
  }
}
