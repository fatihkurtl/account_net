import 'package:flutter/material.dart';

class StatisticsSection extends StatelessWidget {
  final Map<String, dynamic> statistics;
  const StatisticsSection({
    super.key,
    required this.statistics,
  });

  Widget _buildStatItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'İşletme İstatistikleri',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            _buildStatItem('Yıllık Gelir', statistics['yearlyIncome']!),
            _buildStatItem('Çalışan Sayısı', statistics['employeeCount']!),
            _buildStatItem('Kuruluş Tarihi', statistics['foundedDate']!),
          ],
        ),
      ),
    );
  }
}
