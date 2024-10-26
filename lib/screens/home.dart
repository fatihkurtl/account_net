import 'package:account_net/core/widgets/home/financial_summary.dart';
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
        backgroundColor: Colors.grey[300],
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
          color: Colors.grey[300],
          child: Stack(
            children: [
              ListView(
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
                    leading: const Icon(Icons.business),
                    title: const Text(
                      'İşletme Profili',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/business_profile');
                      debugPrint('İşletme Profili butonuna basıldı');
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
                  const SizedBox(height: 50),
                ],
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: Text(
                  'version 1.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FinancialSummary(),
              SizedBox(height: 24),
              RevenueChart(),
              SizedBox(height: 24),
              QuickAccessMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
