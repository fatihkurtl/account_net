import 'package:flutter/material.dart';

class CategoryHelper {
  static Color getCategoryColor(String category) {
    switch (category) {
      case 'Malzeme':
        return Colors.blue;
      case 'İşçilik':
        return Colors.green;
      case 'Nakliye':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  static IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Malzeme':
        return Icons.inventory;
      case 'İşçilik':
        return Icons.engineering;
      case 'Nakliye':
        return Icons.local_shipping;
      default:
        return Icons.category;
    }
  }
}
