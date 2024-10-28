import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentTransactions extends StatefulWidget {
  final NumberFormat format;
  const RecentTransactions({super.key, required this.format});

  @override
  _RecentTransactionsState createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.grey[200],
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Son İşlemler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: index % 2 == 0 ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    child: Icon(
                      index % 2 == 0 ? Icons.arrow_upward : Icons.arrow_downward,
                      color: index % 2 == 0 ? Colors.green : Colors.red,
                    ),
                  ),
                  title: Text('İşlem ${index + 1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days: index)))),
                  trailing: Text(
                    widget.format.format((index + 1) * 1000),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: index % 2 == 0 ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
