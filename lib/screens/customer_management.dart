import 'package:account_net/core/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:account_net/core/components/custom_floating_button.dart';
import 'package:account_net/core/widgets/customer/customer_form.dart';
import 'package:account_net/core/widgets/customer/customer_list.dart';

class CustomerManagementScreen extends StatefulWidget {
  const CustomerManagementScreen({super.key});

  @override
  _CustomerManagementScreenState createState() => _CustomerManagementScreenState();
}

class _CustomerManagementScreenState extends State<CustomerManagementScreen> {
  final List<Map<String, dynamic>> _customers = [];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _addCustomer() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _customers.add({
          'id': DateTime.now().millisecondsSinceEpoch,
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'createdAt': DateTime.now(),
          'totalPurchases': 0.0,
        });
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
      });
      Navigator.of(context).pop();
      _showSnackBar('Müşteri başarıyla eklendi');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Müşteri Yönetimi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implement sorting options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            // child: TextField(
            //   controller: _searchController,
            //   decoration: InputDecoration(
            //     hintText: 'Müşteri Ara',
            //     prefixIcon: const Icon(Icons.search),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   onChanged: (value) {
            //     // TODO: Implement search functionality
            //   },
            // ),
            child: CustomTextField(
              hintText: 'Müşteri Ara',
              controller: _searchController,
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
              widthFactor: 0.5,
            ),
          ),
          Expanded(
            child: _customers.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Henüz müşteri kaydı yok.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : CustomerList(
                    customers: _customers,
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    showSnackBar: _showSnackBar,
                  ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        icon: Icons.add,
        buttonText: 'Müşteri Ekle',
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Yeni Müşteri Ekle'),
                content: CustomerForm(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  phoneController: _phoneController,
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
                    onPressed: _addCustomer,
                    child: const Text(
                      'Ekle',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
