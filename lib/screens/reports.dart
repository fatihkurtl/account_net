import 'package:flutter/material.dart';
import 'package:account_net/core/components/custom_appbar.dart';
import 'package:account_net/core/widgets/reports/recent_transactions.dart';
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
      appBar: CustomAppBar(
        elevation: 0,
        title: 'Raporlar',
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
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[300],
      //   title: const Text(
      //     'Raporlar',
      //     style: TextStyle(fontWeight: FontWeight.w600),
      //   ),
      //   elevation: 0,
      //   foregroundColor: Colors.black87,
      // ),
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
