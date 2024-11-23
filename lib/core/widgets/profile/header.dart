import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Map<String, dynamic> statistics;
  const Header({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade100,
            ),
            child: Center(
              child: Text(
                statistics['name']![0],
                style: TextStyle(fontSize: 48, color: Colors.blue.shade700, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          statistics['name']!,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          statistics['sector']!,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
