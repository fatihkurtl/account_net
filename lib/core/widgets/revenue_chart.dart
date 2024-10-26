import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RevenueChart extends StatefulWidget {
  const RevenueChart({super.key});

  @override
  _RevenueChartState createState() => _RevenueChartState();
}

class _RevenueChartState extends State<RevenueChart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Aylık Gelir Trendi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '65.000 ₺',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        interval: 20000,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()} ₺',
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const labels = ['O', 'Ş', 'M', 'N', 'M', 'H', 'T', 'A', 'E', 'E', 'K', 'A'];
                          if (value.toInt() >= 0 && value.toInt() < labels.length) {
                            return Text(
                              labels[value.toInt()],
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(
                        toY: 30000,
                        color: Colors.blue.withGreen(200).withOpacity(0.7),
                        width: 15,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                        toY: -15000,
                        color: Colors.red.withOpacity(0.7),
                        width: 15,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(
                        toY: -35000,
                        color: Colors.red.withOpacity(0.7),
                        width: 15,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(
                        toY: 35000,
                        color: Colors.red.withOpacity(0.7),
                        width: 15,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    ]),
                    BarChartGroupData(x: 4, barRods: [
                      BarChartRodData(
                        toY: 40000,
                        color: Colors.blue.withGreen(200).withOpacity(0.7),
                        width: 15,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    ]),
                    BarChartGroupData(x: 5, barRods: [
                      BarChartRodData(
                        toY: -10000,
                        color: Colors.red.withOpacity(0.7),
                        width: 15,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    ]),
                    BarChartGroupData(x: 6, barRods: [
                      BarChartRodData(
                        toY: 50000,
                        color: Colors.blue.withGreen(200).withOpacity(0.7),
                        width: 15,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    ]),
                    BarChartGroupData(x: 7, barRods: [
                      BarChartRodData(
                        toY: 30000,
                        color: Colors.blue.withGreen(200).withOpacity(0.7),
                        width: 15,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    ]),
                    BarChartGroupData(x: 8, barRods: [
                      BarChartRodData(
                        toY: 30000,
                        color: Colors.blue.withGreen(200).withOpacity(0.7),
                        width: 15,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
