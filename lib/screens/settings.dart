import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  String _language = 'Türkçe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Ayarlar'),
        backgroundColor: Colors.grey[400],
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSectionTitle('Genel'),
          _buildSettingItem(
            title: 'Karanlık Mod',
            trailing: Switch(
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
              activeColor: Colors.black,
            ),
          ),
          _buildSettingItem(
            title: 'Bildirimler',
            trailing: Switch(
              value: _notifications,
              onChanged: (value) {
                setState(() {
                  _notifications = value;
                });
              },
              activeColor: Colors.black,
            ),
          ),
          _buildSettingItem(
            title: 'Dil',
            trailing: DropdownButton<String>(
              value: _language,
              onChanged: (String? newValue) {
                setState(() {
                  _language = newValue!;
                });
              },
              items: <String>['Türkçe', 'English', 'Deutsch'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          _buildSectionTitle('Hesap'),
          _buildSettingItem(
            title: 'Profili Düzenle',
            onTap: () {
              // Profil düzenleme sayfasına yönlendirme
            },
          ),
          _buildSettingItem(
            title: 'Şifre Değiştir',
            onTap: () {
              // Şifre değiştirme sayfasına yönlendirme
            },
          ),
          _buildSectionTitle('Diğer'),
          _buildSettingItem(
            title: 'Hakkında',
            onTap: () {
              // Hakkında sayfasına yönlendirme
            },
          ),
          _buildSettingItem(
            title: 'Çıkış Yap',
            onTap: () {
              // Çıkış yapma işlemi
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[800]),
      ),
      trailing: trailing,
      onTap: onTap,
      tileColor: Colors.grey[350],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
