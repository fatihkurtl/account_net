import 'package:account_net/core/components/drawer/custom_drawer_item.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[600],
                    child: const Text(
                      'LOGO',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'İşletme Adı',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  CustomDrawerItem(
                    icon: Icons.home,
                    title: 'Anasayfa',
                    onTap: () {
                      Navigator.pop(context);
                      debugPrint('Anasayfa butonuna basıldı');
                    },
                  ),
                  CustomDrawerItem(
                    icon: Icons.business,
                    title: 'İşletme Profili',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, '/business_profile');
                      debugPrint('İşletme Profili butonuna basıldı');
                    },
                  ),
                  CustomDrawerItem(
                      icon: Icons.monetization_on,
                      title: 'Kur Bilgileri',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, '/currency_info');
                        debugPrint('Kur Bilgileri butonuna basıldı');
                      }),
                  CustomDrawerItem(
                    icon: Icons.note,
                    title: 'Notlar',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/notes');
                      debugPrint('Notlar butonuna basıldı');
                    },
                  ),
                  CustomDrawerItem(
                    icon: Icons.settings,
                    title: 'Ayarlar',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/settings');
                      debugPrint('Ayarlar butonuna basıldı');
                    },
                  ),
                  const Divider(),
                  CustomDrawerItem(
                    icon: Icons.info_outline,
                    title: 'Hakkında',
                    onTap: () {
                      Navigator.pop(context);
                      _showAboutDialog(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'version 1.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: const Text('Hakkında'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Bu uygulama, işletmenizi yönetmenize yardımcı olmak için tasarlanmıştır.'),
              const SizedBox(height: 20),
              const Text('Geliştirici: Fatih Kurt'),
              InkWell(
                  child: const Text(
                    'Geliştirici Web Sitesi',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    debugPrint('Geliştirici Web Sitesi butonuna basıldı');
                  }),
              const SizedBox(height: 10),
              const Text('Uygulama Versiyonu: 1.0.0'),
              const SizedBox(height: 10),
              InkWell(
                  child: const Text(
                    'Uygulama Web Sitesi',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    debugPrint('Uygulama Web Sitesi butonuna basıldı');
                  }),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Kapat',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
