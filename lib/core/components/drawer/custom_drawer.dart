import 'package:flutter/material.dart';
import 'package:account_net/screens/webview.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:account_net/core/components/drawer/custom_drawer_item.dart';

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
                    icon: Icons.person,
                    title: 'Personel Listesi',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/employees');
                      debugPrint('Personel Listesi butonuna basıldı');
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
                  CustomDrawerItem(
                    icon: Icons.info_outline,
                    title: 'Hakkında',
                    onTap: () {
                      Navigator.pop(context);
                      _showAboutDialog(context);
                    },
                  ),
                  const Divider(),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => WebViewPage(
                  //             url: dotenv.env['BUY_ME_A_COFFEE_URL'] ??
                  //                 'https://buymeacoffee.com/fatihkurt',
                  //             title: 'Buy Me a Coffee',
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     child: Container(
                  //       padding: const EdgeInsets.symmetric(vertical: 8),
                  //       decoration: BoxDecoration(
                  //         color: const Color(0xFFFF813F),
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //       child: const Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Icon(
                  //             Icons.coffee,
                  //             color: Colors.white,
                  //           ),
                  //           SizedBox(width: 8),
                  //           Text(
                  //             'Buy me a coffee',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewPage(
                              url: dotenv.env['BUY_ME_A_COFFEE_URL'] ??
                                  'https://buymeacoffee.com/fatihkurt',
                              title: 'Buy Me a Coffee',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://www.owlstown.com/assets/icons/bmc-yellow-button-e91f626c5320efe1868dd75673b6edae7d0e2e4f059d40cd3287a7c8536805e6.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
