import 'package:flutter/material.dart';

class InvoiceManagementScreen extends StatefulWidget {
  const InvoiceManagementScreen({super.key});

  @override
  _InvoiceManagementScreenState createState() => _InvoiceManagementScreenState();
}

class _InvoiceManagementScreenState extends State<InvoiceManagementScreen> {
  final List<Map<String, dynamic>> _invoices = [];

  void _addInvoice() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String description = '';
        double amount = 0;
        String type = 'Elektrik';
        DateTime dueDate = DateTime.now();

        return AlertDialog(
          title: const Text('Fatura Ekle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Açıklama'),
                  onChanged: (value) => description = value,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Tutar'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => amount = double.tryParse(value) ?? 0,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: type,
                  decoration: const InputDecoration(labelText: 'Tür'),
                  items: ['Elektrik', 'Su', 'Doğalgaz', 'İnternet', 'Diğer'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      type = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: dueDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != dueDate) {
                      setState(() {
                        dueDate = picked;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Son Ödeme Tarihi',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    child: Text(dueDate.toString().split(' ')[0]),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Ekle'),
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
      appBar: AppBar(title: const Text('Fatura Yönetimi')),
      body: ListView.builder(
        itemCount: _invoices.length,
        itemBuilder: (context, index) {
          final invoice = _invoices[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(invoice['description']),
              subtitle: Text('${invoice['type']} - Son Ödeme: ${invoice['dueDate'].toString().split(' ')[0]}'),
              trailing: Text(
                '₺${invoice['amount'].toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addInvoice,
        child: const Icon(Icons.add),
      ),
    );
  }
}
