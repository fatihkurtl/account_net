import 'package:account_net/core/helpers/income/category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class IncomeChart extends StatefulWidget {
  final List<Map<String, dynamic>> incomes;
  const IncomeChart({super.key, required this.incomes});

  @override
  State<IncomeChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  @override
  Widget build(BuildContext context) {
    if (widget.incomes.isEmpty) return const SizedBox.shrink();

    Map<String, double> categoryTotals = {};
    for (var income in widget.incomes) {
      categoryTotals[income['category']] = (categoryTotals[income['category']] ?? 0) + income['amount'];
    }

    List<PieChartSectionData> sections = categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        color: CategoryHelper.getCategoryColor(entry.key),
        value: entry.value,
        title: '${(entry.value / widget.incomes.fold(0, (sum, item) => sum + item['amount']) * 100).toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gelir Dağılımı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
