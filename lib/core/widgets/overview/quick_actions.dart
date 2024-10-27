import 'package:account_net/core/constants/items.dart';
import 'package:flutter/material.dart';
import 'package:account_net/core/components/custom_dropdown.dart';
import 'package:account_net/core/components/custom_textfield.dart';

class QueickActions extends StatefulWidget {
  const QueickActions({super.key});

  @override
  State<QueickActions> createState() => _QueickActionsState();
}

class _QueickActionsState extends State<QueickActions> {
  final amountController = TextEditingController();
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hızlı İşlemler',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(context, 'income', Icons.add, 'Gelir Ekle', Colors.green),
            _buildActionButton(context, 'expense', Icons.remove, 'Gider Ekle', Colors.red),
            _buildActionButton(context, 'invoice', Icons.receipt, 'Fatura Ekle', Colors.blue),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String type, IconData icon, String label, Color color) {
    return ElevatedButton(
      onPressed: () {
        _showActionDialog(context, label, type);
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

  void _showActionDialog(BuildContext context, String action, String type) {
    debugPrint('Type: $type');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(action),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(controller: amountController, hintText: 'Tutar', obscureText: false),
              const SizedBox(height: 16),
              CustomDropdown(
                hintText: 'Tip',
                items: type == 'invoice'
                    ? ItemConstants.invoiceItems
                    : type == 'income'
                        ? ItemConstants.incomeItems
                        : ItemConstants.expenseItems,
                selectedItem: selectedType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedType = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'İptal',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                'Kaydet',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
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
}
