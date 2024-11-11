import 'package:account_net/core/widgets/settings/section_tile.dart';
import 'package:account_net/core/widgets/settings/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:account_net/core/components/custom_appbar.dart';

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
      appBar: CustomAppBar(
        elevation: 0,
        title: 'Ayarlar',
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
      ),
      body: ListView(
        children: [
          const SectionTile(
            title: 'Genel',
          ),
          SettingsItem(
            title: 'Karanlık Mod',
            trailing: Switch(
              value: _darkMode,
              inactiveTrackColor: Colors.grey[300],
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
              activeColor: Colors.black,
            ),
          ),
          SettingsItem(
            title: 'Bildirimler',
            trailing: Switch(
              value: _notifications,
              inactiveTrackColor: Colors.grey[300],
              onChanged: (value) {
                setState(() {
                  _notifications = value;
                });
              },
              activeColor: Colors.black,
            ),
          ),
          SettingsItem(
            title: 'Dil',
            trailing: DropdownButton<String>(
              value: _language,
              onChanged: (String? newValue) {
                setState(() {
                  _language = newValue!;
                });
              },
              items: <String>['Türkçe', 'English', 'Deutsch']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SectionTile(
            title: 'Hesap',
          ),
          SettingsItem(
            title: 'Profili Düzenle',
            onTap: () {
              // Profil düzenleme sayfasına yönlendirme
            },
          ),
          SettingsItem(
            title: 'Şifre Değiştir',
            onTap: () {
              // Şifre değiştirme sayfasına yönlendirme
            },
          ),
          SettingsItem(
            title: 'Hesabı Sil',
            titleColor: Colors.red.shade600,
            icon: Icons.warning,
            iconColor: Colors.red.shade600,
            onTap: () {
              // Hesabı silme islemi
            },
          ),
          const SectionTile(
            title: 'Diğer',
          ),
          SettingsItem(
            title: 'Hakkında',
            onTap: () {
              // Hakkında sayfasına yönlendirme
            },
          ),
          SettingsItem(
            title: 'Çıkış Yap',
            onTap: () {
              // Çıkış yapma islemi
            },
          ),
        ],
      ),
    );
  }
}
