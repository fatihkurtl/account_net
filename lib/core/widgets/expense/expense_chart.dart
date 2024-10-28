import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:account_net/core/helpers/expense/category.dart';

class ExpenseChart extends StatefulWidget {
  final List<Map<String, dynamic>> expenses;
  const ExpenseChart({super.key, required this.expenses});

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  @override
  Widget build(BuildContext context) {
    if (widget.expenses.isEmpty) return const SizedBox.shrink();

    Map<String, double> categoryTotals = {};
    for (var expense in widget.expenses) {
      categoryTotals[expense['category']] = (categoryTotals[expense['category']] ?? 0) + expense['amount'];
    }

    List<PieChartSectionData> sections = categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        color: CategoryHelper.getCategoryColor(entry.key),
        value: entry.value,
        title: '${(entry.value / widget.expenses.fold(0, (sum, item) => sum + item['amount']) * 100).toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gider Dağılımı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
