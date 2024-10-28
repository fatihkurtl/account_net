import 'package:account_net/core/widgets/reports/recent_transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:account_net/core/widgets/expense_breakdown_chart.dart';
import 'package:account_net/core/widgets/reports/summary_section.dart';
import 'package:account_net/core/widgets/revenue_chart.dart';

class ReportsScreen extends StatelessWidget {
  ReportsScreen({super.key});

  final currencyFormat = NumberFormat.currency(locale: "tr_TR", symbol: "₺");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text(
          'Raporlar',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SummarySection(format: currencyFormat),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: RevenueChart(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ExpenseBreakdownChart(),
            ),
            RecentTransactions(format: currencyFormat),
          ],
        ),
      ),
    );
  }
}
