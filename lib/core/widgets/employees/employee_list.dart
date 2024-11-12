import 'package:flutter/material.dart';
import 'package:account_net/core/models/employee.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;
  final VoidCallback onSalaryPaid;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EmployeeListItem({
    required this.employee,
    required this.onSalaryPaid,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: employee.photoUrl != null
              ? AssetImage(employee.photoUrl!)
              : const AssetImage('assets/default_avatar.png') as ImageProvider,
        ),
        title: Text(
          employee.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${employee.position} • ${employee.department}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                employee.isSalaryPaid
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: employee.isSalaryPaid ? Colors.green : Colors.grey,
              ),
              onPressed: onSalaryPaid,
            ),
          ],
        ),
      ),
    );
  }
}
