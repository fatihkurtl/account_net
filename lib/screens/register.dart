import 'package:account_net/core/components/custom_button.dart';
import 'package:account_net/core/components/custom_textfield.dart';
import 'package:account_net/core/components/square_tile.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signCustomerUp() {
    debugPrint('Sign In button pressed');
  }

  void signGoogleUp() {
    debugPrint('Sign In with Google button pressed');
  }

  void signAppleUp() {
    debugPrint('Sign In with Apple button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // const Icon(
                //   Icons.lock,
                //   size: 100,
                // ),
                Image.asset(
                  'lib/assets/images/register_screen.png',
                  height: 200,
                ),
                const SizedBox(height: 50),
                Text(
                  'İşletmeniz için bir hesap oluşturalım',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Ad Soyad',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: phoneController,
                  hintText: 'Telefon (+90 555 555 55 55)',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: emailController,
                  hintText: 'E-posta',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Şifre',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: 'Şifre Tekrarı',
                  obscureText: true,
                ),
                // const SizedBox(height: 10),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'Forgot Password?',
                //         style: TextStyle(color: Colors.grey[600]),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 25),
                CustomButton(
                  buttonText: 'Hesap Oluştur',
                  onTap: signCustomerUp,
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'ya da şöyle devam edin',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'lib/assets/icons/google.png', onTap: signGoogleUp),
                    const SizedBox(width: 25),
                    SquareTile(imagePath: 'lib/assets/icons/apple.png', onTap: signAppleUp),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hesabınız var mı?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text(
                        'Giriş yapın',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
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
