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
        const Text('Hızlı İşlemler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(context, Icons.add, 'Gelir Ekle', Colors.green),
            _buildActionButton(context, Icons.remove, 'Gider Ekle', Colors.red),
            _buildActionButton(context, Icons.receipt, 'Fatura Ekle', Colors.blue),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, Color color) {
    return ElevatedButton(
      onPressed: () {
        _showActionDialog(context, label);
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

  void _showActionDialog(BuildContext context, String action) {
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
                items: const ['Kira', 'Satış', 'Hizmet', 'Diğer'],
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
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Kaydet'),
              onPressed: () {
                // TODO: Implement save logic
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
