import 'package:account_net/core/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeDetailsPanel extends StatelessWidget {
  final Employee employee;
  final Color? backgroundColor;

  const EmployeeDetailsPanel({
    Key? key,
    required this.employee,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Center(
            child: Column(
              children: [
                Hero(
                  tag: 'employee_${employee.id}',
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[400],
                    backgroundImage: AssetImage(employee.photoUrl.toString()),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    employee.position,
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Status Section
          Row(
            children: [
              Expanded(
                child: _buildStatusCard(
                  'Departman',
                  employee.department,
                  Icons.business,
                  Colors.purple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatusCard(
                  'Maaş Durumu',
                  employee.isSalaryPaid ? 'Ödendi' : 'Bekliyor',
                  Icons.payments,
                  employee.isSalaryPaid ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Details Section
          ..._buildDetailItems(),
        ],
      ),
    );
  }

  Widget _buildStatusCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDetailItems() {
    final details = [
      {
        'icon': Icons.monetization_on,
        'title': 'Maaş',
        'value': '₺${NumberFormat('#,###').format(employee.salary)}',
      },
      {
        'icon': Icons.phone,
        'title': 'Telefon',
        'value': employee.phoneNumber,
        'isLink': true,
      },
      {
        'icon': Icons.email,
        'title': 'E-posta',
        'value': employee.email,
        'isLink': true,
      },
      {
        'icon': Icons.calendar_today,
        'title': 'İşe Başlama Tarihi',
        'value': DateFormat('dd MMMM yyyy', 'tr_TR').format(employee.startDate),
      },
    ];

    return details.map((detail) {
      final bool isLink = detail['isLink'] as bool? ?? false;

      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  detail['icon'] as IconData,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail['title'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      detail['value'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isLink ? Colors.blue[700] : Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              if (isLink)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
