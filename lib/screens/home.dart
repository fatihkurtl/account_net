import 'package:account_net/core/widgets/revenue_chart.dart';
import 'package:flutter/material.dart';
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
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
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
              const RevenueChart(),
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
}
