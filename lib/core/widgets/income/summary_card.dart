import 'package:flutter/material.dart';

class SummaryCard extends StatefulWidget {
  final List<Map<String, dynamic>> incomes;
  const SummaryCard({super.key, required this.incomes});

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  @override
  Widget build(BuildContext context) {
    double totalIncome = widget.incomes.fold(0, (sum, item) => sum + item['amount']);
    return Card(
      color: Colors.grey[200],
      elevation: 4,
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
}
