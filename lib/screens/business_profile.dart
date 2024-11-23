import 'package:account_net/core/widgets/profile/header.dart';
import 'package:account_net/core/widgets/profile/info_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:account_net/core/widgets/profile/action_buttons.dart';
import 'package:account_net/core/widgets/profile/statistics_section.dart';
import 'package:account_net/core/components/custom_date.dart';
import 'package:account_net/core/components/custom_textfield.dart';
import 'package:account_net/core/components/custom_appbar.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final Map<String, dynamic> businessData = const {
    'name': 'Örnek İşletme A.Ş.',
    'email': 'ornek@isletme.com',
    'phone': '+90 555 123 4567',
    'address': 'Örnek Mahallesi, Test Sokak No:1\nİstanbul/Türkiye',
    'yearlyIncome': '150.000 ₺',
    'foundedDate': '01.01.2020',
    'employeeCount': '25',
    'sector': 'Teknoloji',
    'companyLogoUrl':
        'https://i0.wp.com/amach.com/wp-content/uploads/2023/10/aww-logo-blue-background.png?resize=1024%2C1024&ssl=1',
  };
  DateTime _selectedDate = DateTime.now();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: CustomAppBar(
        elevation: 0,
        title: 'İşletme Profili',
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
          letterSpacing: 0.5,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.grey[800],
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => showCompanyDetails(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(statistics: businessData),
              const SizedBox(height: 30),
              _buildInfoSection(),
              const SizedBox(height: 25),
              StatisticsSection(statistics: businessData),
              const SizedBox(height: 25),
              const ActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      elevation: 3,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'İletişim Bilgileri',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            InfoItem(title: 'E-posta', value: businessData['email'], icon: Icons.email),
            InfoItem(title: 'Telefon', value: businessData['phone'], icon: Icons.phone),
            InfoItem(title: 'Adres', value: businessData['address'], icon: Icons.location_on),
          ],
        ),
      ),
    );
  }

  Future<void> _changePhoto(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          businessData['companyLogoUrl'] = pickedFile.path;
        });
        // Here you would typically upload the new image to your server
        // and update the businessData['companyLogoUrl'] with the new URL
        debugPrint('New photo selected: ${pickedFile.path}');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeriden Seç'),
                onTap: () {
                  Navigator.pop(context);
                  _changePhoto(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Fotoğraf Çek'),
                onTap: () {
                  Navigator.pop(context);
                  _changePhoto(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showCompanyDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(32),
          ),
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
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Hero(
                                      tag: 'company',
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey[400],
                                        backgroundImage: NetworkImage(
                                          businessData['companyLogoUrl'].toString(),
                                          scale: 1,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          _showPhotoOptions();
                                          debugPrint('Change photo tapped');
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.grey[300]!, width: 1.5),
                                          ),
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 20,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'İletişim Bilgileri',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  hintText: 'İşletme Adı',
                                  controller: TextEditingController(text: businessData['name']),
                                  prefixIcon: const Icon(Icons.business),
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  hintText: 'E-posta',
                                  controller: TextEditingController(text: businessData['email']),
                                  prefixIcon: const Icon(Icons.email),
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  hintText: 'Telefon',
                                  controller: TextEditingController(text: businessData['phone']),
                                  prefixIcon: const Icon(Icons.phone),
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  hintText: 'Adres',
                                  controller: TextEditingController(text: businessData['address']),
                                  prefixIcon: const Icon(Icons.location_on),
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'İşletme İstatistikleri',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  hintText: 'Yıllık Gelir',
                                  controller: TextEditingController(text: businessData['yearlyIncome']),
                                  prefixIcon: const Icon(Icons.monetization_on),
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  hintText: 'Çalışan Sayısı',
                                  controller: TextEditingController(
                                    text: businessData['employeeCount'],
                                  ),
                                  prefixIcon: const Icon(Icons.people),
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 16),
                                CustomDateField(
                                  hintText: 'Kuruluş Tarihi',
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  selectedDate: _selectedDate,
                                  onChanged: (date) {
                                    setState(() {
                                      _selectedDate = date ?? DateTime.now();
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue[600],
                                              foregroundColor: Colors.white,
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            icon: const Icon(Icons.save_alt),
                                            label: const Text('Kaydet'),
                                            onPressed: () {
                                              // TODO: Implement edit functionality
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red[600],
                                              foregroundColor: Colors.white,
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            icon: const Icon(Icons.cancel_outlined),
                                            label: const Text('İptal'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              debugPrint('Cancel button tapped');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
