import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  void _editCustomer(int index, Map<String, dynamic> customer) {
    _nameController.text = customer['name'];
    _emailController.text = customer['email'];
    _phoneController.text = customer['phone'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Müşteri Düzenle'),
          content: _buildCustomerForm(),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Güncelle'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _customers[index]['name'] = _nameController.text;
                    _customers[index]['email'] = _emailController.text;
                    _customers[index]['phone'] = _phoneController.text;
                  });
                  Navigator.of(context).pop();
                  _showSnackBar('Müşteri başarıyla güncellendi');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteCustomer(int index) {
    setState(() {
      _customers.removeAt(index);
    });
    _showSnackBar('Müşteri silindi');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildCustomerForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'İsim',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir isim girin';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'E-posta',
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir e-posta girin';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Geçerli bir e-posta adresi girin';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Telefon',
              prefixIcon: Icon(Icons.phone),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir telefon numarası girin';
              }
              if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
                return 'Geçerli bir telefon numarası girin';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Müşteri Ara',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
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
                : ListView.builder(
                    itemCount: _customers.length,
                    itemBuilder: (context, index) {
                      final customer = _customers[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => _editCustomer(index, customer),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Düzenle',
                            ),
                            SlidableAction(
                              onPressed: (context) => _deleteCustomer(index),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Sil',
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(customer['name'][0].toUpperCase()),
                          ),
                          title: Text(customer['name']),
                          subtitle: Text(customer['email']),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Toplam Alışveriş',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                '₺${customer['totalPurchases'].toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          onTap: () {
                            // TODO: Implement customer details view
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Yeni Müşteri Ekle'),
                content: _buildCustomerForm(),
                actions: [
                  TextButton(
                    child: const Text('İptal'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ElevatedButton(
                    onPressed: _addCustomer,
                    child: const Text('Ekle'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
