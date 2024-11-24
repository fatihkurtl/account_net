import 'package:flutter/material.dart';
import 'package:account_net/core/components/custom_snackbar.dart';
import 'package:account_net/features/models/api_response.dart';
import 'package:account_net/core/components/custom_progress.dart';
import 'package:account_net/core/components/custom_button.dart';
import 'package:account_net/core/components/custom_textfield.dart';
import 'package:account_net/core/components/square_tile.dart';
import 'package:account_net/features/auth/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signCustomerUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final response = await AuthService.authenticate(
          route: '/register/',
          body: {
            'name': nameController.text,
            'email': emailController.text,
            'phone': phoneController.text,
            'password': passwordController.text,
            'password_confirm': confirmPasswordController.text,
          },
        );
        if (mounted) setState(() => _isLoading = false);
        debugPrint('Response: $response');

        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.statusCode == 201) {
          CustomSnackBar.show(
            context: context,
            message: apiResponse.body.message,
            type: SnackBarType.success,
          );
          Navigator.pushNamed(context, '/');
        } else {
          String errorMessage = apiResponse.body.message;
          if (apiResponse.body.errors != null) {
            errorMessage += '\n${apiResponse.body.errors!.values.join('\n')}';
          }
          CustomSnackBar.show(
            context: context,
            message: errorMessage,
            type: SnackBarType.error,
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          CustomSnackBar.show(
            context: context,
            message: 'Bir hata oluştu, lütfen tekrar deneyin',
            type: SnackBarType.error,
          );
        }
      }
    }
  }

  void signGoogleUp() {
    debugPrint('Sign In with Google button pressed');
  }

  void signFacebookUp() {
    debugPrint('Sign In with Facebook button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen bir isim girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: phoneController,
                        hintText: 'Telefon (+90 555 555 55 55)',
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen bir telefon numarası girin';
                          } else if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
                            return 'Geçerli bir telefon numarası girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'E-posta',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen bir e-posta girin';
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Geçerli bir e-posta adresi girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Şifre',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen bir şifre girin';
                          } else if (value.length < 6) {
                            return 'Şifreniz en az 6 karakter olmalıdır';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: confirmPasswordController,
                        hintText: 'Şifre Tekrarı',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen şifrenizi tekrar girin';
                          } else if (value != passwordController.text) {
                            return 'Şifreler eşleşmiyor';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      CustomButton(
                        buttonText: 'Hesap Oluştur',
                        onTap: _isLoading ? null : signCustomerUp,
                        margin: const EdgeInsets.symmetric(horizontal: 25),
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
                          SquareTile(imagePath: 'lib/assets/icons/facebook.png', onTap: signFacebookUp),
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
            if (_isLoading) const CustomProgressBar(),
          ],
        ),
      ),
    );
  }
}
