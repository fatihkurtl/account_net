import 'package:flutter/material.dart';
import 'package:account_net/core/widgets/home/financial_summary.dart';
import 'package:account_net/core/widgets/revenue_chart.dart';
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
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[600],
                      child: const Text(
                        'LOGO',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'İşletme Adı',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildDrawerItem(
                      icon: Icons.home,
                      title: 'Anasayfa',
                      onTap: () {
                        Navigator.pop(context);
                        debugPrint('Anasayfa butonuna basıldı');
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.business,
                      title: 'İşletme Profili',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/business_profile');
                        debugPrint('İşletme Profili butonuna basıldı');
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.note,
                      title: 'Notlar',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/notes');
                        debugPrint('Notlar butonuna basıldı');
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.settings,
                      title: 'Ayarlar',
                      onTap: () {
                        Navigator.pop(context); // Drawer'ı kapat
                        Navigator.pushNamed(context, '/settings');
                        debugPrint('Ayarlar butonuna basıldı');
                      },
                    ),
                    const Divider(),
                    _buildDrawerItem(
                      icon: Icons.info_outline,
                      title: 'Hakkında',
                      onTap: () {
                        Navigator.pop(context);
                        _showAboutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
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

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
      ),
      onTap: onTap,
      dense: true,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.grey[350],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: const Text('Hakkında'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Bu uygulama, işletmenizi yönetmenize yardımcı olmak için tasarlanmıştır.'),
              const SizedBox(height: 20),
              const Text('Geliştirici: Fatih Kurt'),
              InkWell(
                  child: const Text(
                    'Geliştirici Web Sitesi',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    debugPrint('Geliştirici Web Sitesi butonuna basıldı');
                  }),
              const SizedBox(height: 10),
              const Text('Uygulama Versiyonu: 1.0.0'),
              const SizedBox(height: 10),
              InkWell(
                  child: const Text(
                    'Uygulama Web Sitesi',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    debugPrint('Uygulama Web Sitesi butonuna basıldı');
                  }),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Kapat',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
