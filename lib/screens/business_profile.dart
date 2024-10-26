import 'package:account_net/core/components/custom_button.dart';
import 'package:flutter/material.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  _BusinessProfileScreenState createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  // Örnek işletme verileri
  final Map<String, dynamic> businessData = {
    'name': 'Örnek İşletme A.Ş.',
    'email': 'ornek@isletme.com',
    'phone': '+90 555 123 4567',
    'address': 'Örnek Mahallesi, Test Sokak No:1\nİstanbul/Türkiye',
    'monthlyIncome': '150.000 ₺',
    'foundedDate': '01.01.2020',
    'employeeCount': '25',
    'sector': 'Teknoloji',
  };

  void editBusiness() {
    debugPrint('Düzenle butonuna basıldı');
    Navigator.pushNamed(context, '/edit-business');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('İşletme Profili'),
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: editBusiness,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  child: Text(
                    businessData['name']![0],
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  businessData['name']!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildInfoSection(),
              const SizedBox(height: 25),
              _buildStatisticsSection(),
              const SizedBox(height: 25),
              CustomButton(
                onTap: () => Navigator.pushNamed(context, '/business-reports'),
                buttonText: 'Raporları Görüntüle',
              ),
              const SizedBox(height: 15),
              CustomButton(
                onTap: () => Navigator.pushNamed(context, '/business-transactions'),
                buttonText: 'İşlemleri Görüntüle',
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoItem(Icons.email, 'E-posta', businessData['email']!),
            const Divider(),
            _buildInfoItem(Icons.phone, 'Telefon', businessData['phone']!),
            const Divider(),
            _buildInfoItem(Icons.location_on, 'Adres', businessData['address']!),
            const Divider(),
            _buildInfoItem(Icons.business, 'Sektör', businessData['sector']!),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'İşletme İstatistikleri',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildStatItem('Aylık Gelir', businessData['monthlyIncome']!),
            _buildStatItem('Çalışan Sayısı', businessData['employeeCount']!),
            _buildStatItem('Kuruluş Tarihi', businessData['foundedDate']!),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
