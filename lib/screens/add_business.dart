import 'package:account_net/core/components/custom_button.dart';
import 'package:account_net/core/components/custom_dropdown.dart';
import 'package:account_net/core/components/custom_textfield.dart';
import 'package:account_net/core/constants/items.dart';
import 'package:flutter/material.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  _AddBusinessScreenState createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  final businessNameController = TextEditingController();
  final businessEmailController = TextEditingController();
  final businessPhoneController = TextEditingController();
  final yearlyIncomeController = TextEditingController();
  final workersCountController = TextEditingController();
  final businessAddressController = TextEditingController();
  String? selectedSector;

  void addBusiness() {
    debugPrint('Add Company button pressed');
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('İşletme Ekle'),
        backgroundColor: Colors.grey[300],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'lib/assets/images/add_business_screen.png',
                  height: 200,
                ),
                const SizedBox(height: 30),
                Text(
                  'Yeni bir işletme profili oluşturun',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: businessNameController,
                  hintText: 'İşletme Adı',
                  obscureText: false,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                ),
                const SizedBox(height: 10),
                CustomDropdown(
                  hintText: 'İşletme Sektörü Seçin',
                  items: ItemConstants.businessSector,
                  selectedItem: selectedSector,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSector = newValue;
                    });
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: yearlyIncomeController,
                  hintText: 'Yıllık Toplam Gelir',
                  obscureText: false,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: workersCountController,
                  hintText: 'Personel Sayısı',
                  obscureText: false,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: businessEmailController,
                  hintText: 'İşletme E-postası',
                  obscureText: false,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: businessPhoneController,
                  hintText: 'İşletme Telefon Numarası',
                  obscureText: false,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: businessAddressController,
                  hintText: 'İşletme Adresi',
                  obscureText: false,
                  maxLines: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                ),
                const SizedBox(height: 25),
                CustomButton(
                  onTap: addBusiness,
                  buttonText: 'İşletme Ekle',
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Yardıma mı ihtiyacınız var?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'İletişime geçin',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
