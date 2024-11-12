import 'package:flutter/material.dart';
import 'package:account_net/core/widgets/customer/customer_form.dart';

class CustomerList extends StatefulWidget {
  final List<Map<String, dynamic>> customers;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final Function showSnackBar;
  const CustomerList({
    super.key,
    required this.customers,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.showSnackBar,
  });

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  void _editCustomer(int index, Map<String, dynamic> customer) {
    widget.nameController.text = customer['name'];
    widget.emailController.text = customer['email'];
    widget.phoneController.text = customer['phone'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: const Text('Müşteri Düzenle'),
          content: CustomerForm(
            formKey: widget.formKey,
            nameController: widget.nameController,
            emailController: widget.emailController,
            phoneController: widget.phoneController,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
              ),
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
                'Güncelle',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (widget.formKey.currentState!.validate()) {
                  setState(() {
                    widget.customers[index]['name'] =
                        widget.nameController.text;
                    widget.customers[index]['email'] =
                        widget.emailController.text;
                    widget.customers[index]['phone'] =
                        widget.phoneController.text;
                  });
                  Navigator.of(context).pop();
                  widget.showSnackBar('Müşteri başarıyla güncellendi');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteCustomer(int index) async {
    final bool? confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: const Text('Müşteriyi Sil'),
          content:
              const Text('Bu müşteriyi silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
              ),
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
                'Sil',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      setState(() {
        widget.customers.removeAt(index);
      });
      widget.showSnackBar('Müşteri silindi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.customers.length,
      itemBuilder: (context, index) {
        final customer = widget.customers[index];
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
            onTap: () => _showCustomerDetails(context, index, customer),
          ),
        );
      },
    );
  }

  void _showCustomerDetails(
      BuildContext context, int index, Map<String, dynamic> customer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) => Stack(
            clipBehavior: Clip.none,
            children: [
              CustomScrollView(
                controller: scrollController,
                slivers: [
                  // Drag Handle
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  // Customer Details
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Center(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: Text(
                                    customer['name'][0].toUpperCase(),
                                    style: const TextStyle(fontSize: 32),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  customer['name'],
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Info Cards
                          _buildInfoCard(
                            'E-posta',
                            customer['email'],
                            Icons.email,
                            Colors.blue,
                          ),
                          _buildInfoCard(
                            'Telefon',
                            customer['phone'],
                            Icons.phone,
                            Colors.green,
                          ),
                          _buildInfoCard(
                            'Toplam Alışveriş',
                            '₺${customer['totalPurchases'].toStringAsFixed(2)}',
                            Icons.shopping_cart,
                            Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Action Buttons
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[600],
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.edit),
                                label: const Text('Düzenle'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _editCustomer(index, customer);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[600],
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.delete_outline),
                                label: const Text('Sil'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _deleteCustomer(index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Close Button
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[400]?.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.grey[800], size: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
