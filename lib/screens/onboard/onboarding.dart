import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      image: 'lib/assets/images/onboarding1.png',
      title: 'İşletme Yönetimi',
      subtitle: 'Modern arayüz ile işletmenizi\nkolayca yönetin',
      primaryColor: const Color(0xFF1E88E5),
      secondaryColor: const Color(0xFF64B5F6),
    ),
    OnboardingData(
      image: 'lib/assets/images/onboarding2.png',
      title: 'Finansal Takip',
      subtitle: 'Gelir ve giderlerinizi\nprofesyonelce takip edin',
      primaryColor: const Color(0xFF43A047),
      secondaryColor: const Color(0xFF81C784),
    ),
    OnboardingData(
      image: 'lib/assets/images/onboarding3.png',
      title: 'Detaylı Raporlar',
      subtitle: 'Grafikler ve analizlerle\nişletmenizi kontrol edin',
      primaryColor: const Color(0xFF5E35B1),
      secondaryColor: const Color(0xFF9575CD),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  _pages[_currentPage].primaryColor,
                  _pages[_currentPage].secondaryColor,
                ],
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Skip button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () => Get.offAllNamed('/'),
                      child: const Text(
                        'Atla',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                // Page content
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              // Image
                              Expanded(
                                flex: 3,
                                child: Image.asset(
                                  _pages[index].image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 40),
                              // Title
                              Text(
                                _pages[index].title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              // Subtitle
                              Text(
                                _pages[index].subtitle,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom controls
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Page indicators
                      Row(
                        children: List.generate(
                          _pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 8),
                            height: 8,
                            width: _currentPage == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                _currentPage == index ? 1 : 0.5,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                      // Next/Start button
                      GestureDetector(
                        onTap: () {
                          if (_currentPage < _pages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Get.offAllNamed('/');
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Text(
                            _currentPage < _pages.length - 1
                                ? 'İleri'
                                : 'Başla',
                            style: TextStyle(
                              color: _pages[_currentPage].primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String subtitle;
  final Color primaryColor;
  final Color secondaryColor;

  OnboardingData({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.primaryColor,
    required this.secondaryColor,
  });
}
