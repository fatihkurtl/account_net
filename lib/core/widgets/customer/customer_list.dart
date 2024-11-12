import 'package:account_net/core/widgets/customer/customer_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          child: Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.55,
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
            child: Container(
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
                onTap: () {
                  // TODO: Implement customer details view
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
