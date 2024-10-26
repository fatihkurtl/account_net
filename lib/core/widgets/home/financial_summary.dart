import 'package:flutter/material.dart';

class FinancialSummary extends StatefulWidget {
  const FinancialSummary({super.key});

  @override
  State<FinancialSummary> createState() => _FinancialSummaryState();
}

class _FinancialSummaryState extends State<FinancialSummary> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Finansal Özet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueAccent,
                  ),
                ),
                Icon(Icons.account_balance_wallet, color: Colors.blueAccent, size: 28),
              ],
            ),
            const Divider(thickness: 1, height: 32, color: Colors.blueAccent),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem('Gelir', '₺50,000', Colors.green, Icons.trending_up),
                _buildSummaryItem('Gider', '₺30,000', Colors.red, Icons.trending_down),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem('Kâr', '₺20,000', Colors.blue, Icons.attach_money),
                _buildSummaryItem('Bekleyen Faturalar', '₺5,000', Colors.orange, Icons.pending_actions),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String amount, Color color, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color),
            ),
          ],
        ),
      ],
    );
  }
}
