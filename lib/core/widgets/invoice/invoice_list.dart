import 'package:flutter/material.dart';

class InvoiceList extends StatelessWidget {
  final Map<String, dynamic> invoices;
  const InvoiceList({
    super.key,
    required this.invoices,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.grey[200],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(invoices['description']),
        subtitle: Text('${invoices['type']} - Son Ödeme: ${invoices['dueDate'].toString().split(' ')[0]}'),
        trailing: Text(
          '₺${invoices['amount'].toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
