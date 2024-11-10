import 'package:account_net/core/components/custom_textfield.dart';
import 'package:flutter/material.dart';

class CustomerForm extends StatefulWidget {
  final GlobalKey formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const CustomerForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextFormField(
            //   controller: widget.nameController,
            //   decoration: const InputDecoration(
            //     labelText: 'İsim',
            //     prefixIcon: Icon(Icons.person),
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Lütfen bir isim girin';
            //     }
            //     return null;
            //   },
            // ),
            CustomTextField(
              hintText: 'İsim',
              controller: widget.nameController,
              prefixIcon: const Icon(Icons.person),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir isim girin';
                }
                return null;
              },
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
            const SizedBox(height: 16),
            // TextFormField(
            //   controller: widget.emailController,
            //   decoration: const InputDecoration(
            //     labelText: 'E-posta',
            //     prefixIcon: Icon(Icons.email),
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Lütfen bir e-posta girin';
            //     }
            //     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            //       return 'Geçerli bir e-posta adresi girin';
            //     }
            //     return null;
            //   },
            // ),
            CustomTextField(
              hintText: 'E-posta',
              controller: widget.emailController,
              prefixIcon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir e-posta girin';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Geçerli bir e-posta adresi girin';
                }
                return null;
              },
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
            const SizedBox(height: 16),
            // TextFormField(
            //   controller: widget.phoneController,
            //   decoration: const InputDecoration(
            //     labelText: 'Telefon',
            //     prefixIcon: Icon(Icons.phone),
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Lütfen bir telefon numarası girin';
            //     }
            //     if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
            //       return 'Geçerli bir telefon numarası girin';
            //     }
            //     return null;
            //   },
            // ),
            CustomTextField(
              hintText: 'Telefon',
              controller: widget.phoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir telefon numarası girin';
                }
                if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
                  return 'Geçerli bir telefon numarası girin';
                }
                return null;
              },
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
      ),
    );
  }
}
