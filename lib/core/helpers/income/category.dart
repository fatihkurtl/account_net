import 'package:flutter/material.dart';

class CategoryHelper {
  static Color getCategoryColor(String category) {
    switch (category) {
      case 'Satış':
        return Colors.blue;
      case 'Hizmet':
        return Colors.green;
      case 'Kira':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  static IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Satış':
        return Icons.shopping_cart;
      case 'Hizmet':
        return Icons.build;
      case 'Kira':
        return Icons.home;
      default:
        return Icons.attach_money;
    }
  }
}
