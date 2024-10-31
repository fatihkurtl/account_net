import 'package:flutter/material.dart';
import 'package:account_net/core/components/custom_appbar.dart';
import 'package:account_net/core/components/drawer/custom_drawer.dart';
import 'package:account_net/core/widgets/home/financial_summary.dart';
import 'package:account_net/core/widgets/revenue_chart.dart';
import 'package:account_net/core/widgets/home/quick_access_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'icon': Icons.info,
      'iconColor': Colors.blue,
      'title': 'Finansal rapor güncellendi.',
      'subtitle': '2 saat önce',
    },
    {
      'icon': Icons.info,
      'iconColor': Colors.blue,
      'title': 'Yeni bir gelir kaydı eklendi.',
      'subtitle': '5 saat önce',
    },
    {
      'icon': Icons.warning,
      'iconColor': Colors.orange,
      'title': 'Fatura ödeme tarihi yaklaşıyor.',
      'subtitle': '1 gün önce',
    },
  ];
  Widget _buildNotificationButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.grey[800],
              size: 26,
            ),
            onPressed: () {
              _showNotificationPanel(context);
            },
          ),
          Positioned(
            right: 10,
            top: 12,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red[400],
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 8,
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bildirimler',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Expanded(
                child: _notifications.isEmpty
                    ? const Center(
                        child: Text('Bildirim yok.'),
                      )
                    : ListView.builder(
                        itemCount: _notifications.length,
                        itemBuilder: (context, index) {
                          final notification = _notifications[index];
                          return Dismissible(
                            key: Key(notification['title']),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                _notifications.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${notification['title']} silindi')),
                              );
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: ListTile(
                              leading: Icon(
                                notification['icon'],
                                color: notification['iconColor'],
                              ),
                              title: Text(notification['title']),
                              subtitle: Text(notification['subtitle']),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: CustomAppBar(
        elevation: 0,
        title: 'AccountNet',
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
                  Icons.menu,
                  color: Colors.grey[800],
                ),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          _buildNotificationButton(context),
        ],
      ),
      drawer: const CustomDrawer(),
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
