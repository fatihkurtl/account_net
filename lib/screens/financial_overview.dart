import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FinancialOverviewScreen extends StatelessWidget {
  const FinancialOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 24),
            _buildQuickActions(context),
            const SizedBox(height: 24),
            _buildExpenseBreakdownChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Toplam Bakiye', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 8),
            const Text('₺10,000', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBalanceItem('Aylık Gelir', '₺5,000', Colors.green),
                _buildBalanceItem('Aylık Gider', '₺3,000', Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceItem(String title, String amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(amount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hızlı İşlemler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(context, Icons.add, 'Gelir Ekle', Colors.green),
            _buildActionButton(context, Icons.remove, 'Gider Ekle', Colors.red),
            _buildActionButton(context, Icons.receipt, 'Fatura Ekle', Colors.blue),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, Color color) {
    return ElevatedButton(
      onPressed: () {
        _showActionDialog(context, label);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  void _showActionDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(action),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Miktar (₺)',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Kaydet'),
              onPressed: () {
                // TODO: Implement save logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$action kaydedildi')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildExpenseBreakdownChart() {
    return Card(
      elevation: 4,
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
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      color: Colors.red,
                      value: 40,
                      title: '40%',
                      radius: 50,
                      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    PieChartSectionData(
                      color: Colors.blue,
                      value: 30,
                      title: '30%',
                      radius: 50,
                      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: 15,
                      title: '15%',
                      radius: 50,
                      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    PieChartSectionData(
                      color: Colors.yellow,
                      value: 15,
                      title: '15%',
                      radius: 50,
                      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendItem(Colors.red, 'Kira'),
                _buildLegendItem(Colors.blue, 'Personel'),
                _buildLegendItem(Colors.green, 'Malzeme'),
                _buildLegendItem(Colors.yellow, 'Diğer'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
