import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:account_net/core/widgets/home/quick_access_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('İşletme Yönetimi'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              debugPrint('Ayarlar butonuna basıldı');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
            color: Colors.grey[200],
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Center(
                    child: Text(
                      'L O G O',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text(
                    'Anasayfa',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, '/home');
                    debugPrint('Anasayfa butonuna basıldı');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.note),
                  title: const Text(
                    'Notlar',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/notes');
                    debugPrint('Notlar butonuna basıldı');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text(
                    'Ayarlar',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, '/home');
                    debugPrint('Ayarlar butonuna basıldı');
                  },
                ),
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFinancialSummary(),
              const SizedBox(height: 24),
              _buildRevenueChart(),
              const SizedBox(height: 24),
              const QuickAccessMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinancialSummary() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Finansal Özet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem('Gelir', '₺50,000', Colors.green),
                _buildSummaryItem('Gider', '₺30,000', Colors.red),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem('Kâr', '₺20,000', Colors.blue),
                _buildSummaryItem('Bekleyen Faturalar', '₺5,000', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _buildRevenueChart() {
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
                  'Gelir Grafiği',
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
              height: 150,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const labels = ['O', 'Ş', 'M', 'N', 'M', 'H'];
                          if (value.toInt() >= 0 && value.toInt() < labels.length) {
                            return Text(
                              labels[value.toInt()],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 6,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3),
                        FlSpot(1, 1),
                        FlSpot(2, 4),
                        FlSpot(3, 2),
                        FlSpot(4, 5),
                        FlSpot(5, 3),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Colors.blue,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      // tooltipBgColor: Colors.blue,
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          return LineTooltipItem(
                            '${(barSpot.y * 20000).toInt()} ₺',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
