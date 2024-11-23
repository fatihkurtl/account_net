import 'package:flutter/material.dart';
import 'package:account_net/core/components/custom_button.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onTap: () => Navigator.pushNamed(context, '/reports'),
          buttonText: 'Raporları Görüntüle',
        ),
        const SizedBox(height: 15),
        CustomButton(
          onTap: () => Navigator.pushNamed(context, '/financial_overview'),
          buttonText: 'İşlemleri Görüntüle',
        ),
      ],
    );
  }
}
