import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:account_net/screens/onboard/onboarding.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:account_net/screens/currency_info.dart';
import 'package:account_net/screens/employees.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:account_net/screens/add_business.dart';
import 'package:account_net/screens/business_profile.dart';
import 'package:account_net/screens/customer_management.dart';
import 'package:account_net/screens/expense_tracking.dart';
import 'package:account_net/screens/financial_overview.dart';
import 'package:account_net/screens/home.dart';
import 'package:account_net/screens/income_tracking.dart';
import 'package:account_net/screens/invoice_management.dart';
import 'package:account_net/screens/login.dart';
import 'package:account_net/screens/notes.dart';
import 'package:account_net/screens/register.dart';
import 'package:account_net/screens/reports.dart';
import 'package:account_net/screens/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
  await dotenv.load(fileName: ".env");
  if (WebViewPlatform.instance is AndroidWebViewController) {
    AndroidWebViewController.enableDebugging(true);
  }
  runApp(const MarbleWorkshopApp());
}

class MarbleWorkshopApp extends StatelessWidget {
  const MarbleWorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kurumsal Yönetim Sistemi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.blueAccent,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/register': (context) => const RegisterScreen(),
        '/': (context) => const LoginScreen(),
        '/add_business': (context) => const AddBusinessScreen(),
        '/home': (context) => const HomeScreen(),
        '/financial_overview': (context) => const FinancialOverviewScreen(),
        '/expense_tracking': (context) => const ExpenseTrackingScreen(),
        '/income_tracking': (context) => const IncomeTrackingScreen(),
        '/invoice_management': (context) => const InvoiceManagementScreen(),
        '/reports': (context) => ReportsScreen(),
        '/customer_management': (context) => const CustomerManagementScreen(),
        '/business_profile': (context) => const BusinessProfileScreen(),
        '/notes': (context) => const NotesScreen(),
        '/employees': (context) => const EmployeeListScreen(),
        '/currency_info': (context) => const CurrencyInfoScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
