import 'package:account_net/features/auth/auth_helpers.dart';
import 'package:account_net/features/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:account_net/core/components/custom_button.dart';
import 'package:account_net/core/components/custom_progress.dart';
import 'package:account_net/core/components/custom_snackbar.dart';
import 'package:account_net/core/components/custom_textfield.dart';
import 'package:account_net/core/components/square_tile.dart';
import 'package:account_net/features/auth/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final authHelpers = AuthHelpers();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signCustomerIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final response = await AuthService.authenticate(
          route: '/login/',
          body: {
            'email': emailController.text,
            'password': passwordController.text,
          },
        );
        if (mounted) setState(() => _isLoading = false);
        debugPrint('Response: $response');

        final apiResponse = ApiResponse.fromJson(response);

        if (apiResponse.statusCode == 202) {
          CustomSnackBar.show(
            context: context,
            message: apiResponse.body.message,
            type: SnackBarType.success,
          );
          await authHelpers.saveData('token', response['body']['token']);
          Navigator.pushNamed(context, '/add_business');
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

  void signGoogleIn() {
    debugPrint('Sign In with Google button pressed');
  }

  void signfacebookIn() {
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
                        'lib/assets/images/login_screen.png',
                        height: 200,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Tekrar hoş geldin, seni özledik!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'E-Posta',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen bir e-posta girin';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
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
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                debugPrint('Forgot Password? button pressed');
                              },
                              child: Text(
                                'Şifrenizi mi unuttunuz?',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomButton(
                        buttonText: 'Giriş Yap',
                        onTap: _isLoading ? null : signCustomerIn,
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                      ),
                      const SizedBox(height: 50),
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
                          SquareTile(imagePath: 'lib/assets/icons/google.png', onTap: signGoogleIn),
                          const SizedBox(width: 25),
                          SquareTile(imagePath: 'lib/assets/icons/facebook.png', onTap: signfacebookIn),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Üye değil misiniz?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              'Şimdi kayıt olun',
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
