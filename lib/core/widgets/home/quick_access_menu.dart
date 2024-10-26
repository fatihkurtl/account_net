import 'package:account_net/core/widgets/home/menu_card.dart';
import 'package:flutter/material.dart';

class QuickAccessMenu extends StatelessWidget {
  const QuickAccessMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hızlı Erişim',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: const [
            MenuCard(title: 'Finansal Genel Bakış', imagePath: 'lib/assets/icons/financial_overview.png', route: '/financial_overview'),
            MenuCard(title: 'Gelir Takibi', imagePath: 'lib/assets/icons/income_tracking.png', route: '/income_tracking'),
            MenuCard(title: 'Gider Takibi', imagePath: 'lib/assets/icons/expense_tracking.png', route: '/expense_tracking'),
            MenuCard(title: 'Fatura Yönetimi', imagePath: 'lib/assets/icons/invoice_management.png', route: '/invoice_management'),
            MenuCard(title: 'Raporlar', imagePath: 'lib/assets/icons/reports.png', route: '/reports'),
            MenuCard(title: 'Müşteri Yönetimi', imagePath: 'lib/assets/icons/customer_management.png', route: '/customer_management'),
          ],
        ),
      ],
    );
  }
}
