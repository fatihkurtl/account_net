import 'package:account_net/core/widgets/expense_breakdown_chart.dart';
import 'package:flutter/material.dart';
import 'package:account_net/core/widgets/overview/balance_card.dart';
import 'package:account_net/core/widgets/overview/quick_actions.dart';

class FinancialOverviewScreen extends StatelessWidget {
  const FinancialOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Finansal Genel Bakış'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // TODO: Implement refresh logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Veriler yenilendi')),
              );
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceCard(),
            SizedBox(height: 24),
            QueickActions(),
            SizedBox(height: 24),
            ExpenseBreakdownChart(),
          ],
        ),
      ),
    );
  }
}
