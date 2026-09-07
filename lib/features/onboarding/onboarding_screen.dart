import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Design Tokens
  static const Color kBackground = Color(0xFFF8FAF6);
  static const Color kPrimary = Color(0xFF04442D);
  static const Color kOnPrimary = Colors.white;
  static const Color kOnSurface = Color(0xFF191C1A);
  static const Color kOnSurfaceVariant = Color(0xFF404943);
  static const Color kSurfaceVariant = Color(0xFFE1E3DF);
  static const Color kPrimaryFixedDim = Color(0xFF99D3B3);
  static const Color kSecondaryContainer = Color(0xFFA1F2B6);
  static const Color kOnSecondaryContainer = Color(0xFF1F7041);
  static const Color kSecondaryFixed = Color(0xFFA3F4B9);

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      title: 'Organise your plants',
      description: 'Keep all your plants in one beautiful and simple space.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCSz3TTdz0gR19LjZ9AsKDrrVI98reE5F4dmdO9LTMUCuXT7ETJh7huoZevadHe-7DjhZ1qLPkLz5-B08-zI2fFIo6hXEBlFDRahTPTrOUjfGhZtCeareIt8WVwAapDgMJ8v9FD6aE9wqV-v7fIPlh-0W3IvoSRV4fqo9ewZv6rZ7n02ZIu0I-fZfajf6dkkcWTM9QkvztGR6AjWF2IVBUvGfjbk7Qs3oBwMps9LIg5Xkw7G8TLl783',
      buttonText: 'Next',
    ),
    _OnboardingData(
      title: 'Never forget to water',
      description:
          'Get gentle reminders based on the needs of every plant. Keep them thriving with personalized care schedules.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAudtF5sMRnrHnQQBVho7D7LJoaGxSOTvRpcYimUjvxTdlgawo3RzrYQs6bTT_C6h27DwWSmIkxkm6YNKvtLj3Cz9CXm7urSvTRaw7bmLaH_tICdSuAAhaairvGv9z4xo80dN2jDEfUh31nt_RhHNlFe5LfX2oYjc2iD9cplBKEcdQUyN60ish9hxzlmupHfatpwTQnj2VIHtTm9eWKdo0UNOl9H7neN3wjfPkcXjkHqwfHmxrtIiex',
      buttonText: 'Next',
    ),
    _OnboardingData(
      title: 'Help your plants grow',
      description:
          'Discover simple care tips and build better plant-care habits.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCA1oQrj1r2elKudJw5MaZzGPZqZfzrus8fY11AOdqlejQ_skyEbnecBEkLYq24UFmPggv4QT418p8UNZQwmQ-QuXKuHvZrB0lM76m9ernuTWosEtVcJy3khuML4JnaxRTSzCfiSuqJ-bnsslLTiQcLDhOwfxHfLeutKuxmtGJGYUzl15L60kMBNZPKAnQ28QEiQEzuAZ3oi6d4JYN40s4YSRSo_PAks4aMvovVRvl-zwCRYezJSAp8',
      buttonText: 'Get Started',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else {
      // Finished onboarding
      _finishOnboarding();
    }
  }

  void _skipOnboarding() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  void _finishOnboarding() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AppShell(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar (Skip / Back)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _currentPage > 0
                        ? IconButton(
                            icon: const Icon(Icons.arrow_back, color: kOnSurfaceVariant),
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOutCubic,
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                    _currentPage < _pages.length - 1
                        ? TextButton(
                            onPressed: _skipOnboarding,
                            child: Text(
                              'Skip',
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kPrimary.withValues(alpha: 0.8),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),

            // PageView Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return _buildPage(index, page);
                },
              ),
            ),

            // Bottom Actions & Page Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                children: [
                  // Smooth Animated Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      final isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        height: 8.0,
                        width: isActive ? 32.0 : 8.0,
                        decoration: BoxDecoration(
                          color: isActive ? kPrimary : kSurfaceVariant,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 32),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimary,
                        foregroundColor: kOnPrimary,
                        elevation: 0,
                        shadowColor: kPrimary.withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _pages[_currentPage].buttonText,
                            style: GoogleFonts.manrope(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: kOnPrimary,
                            ),
                          ),
                          if (_currentPage < _pages.length - 1) ...[
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, size: 20),
                          ],
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
    );
  }

  Widget _buildPage(int index, _OnboardingData page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Container with Ambient Organic Shape
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background Ambient Glow & Blob
                if (index == 0)
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      color: kPrimaryFixedDim.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(60),
                    ),
                  )
                else if (index == 1)
                  Container(
                    width: 270,
                    height: 270,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: kSecondaryFixed.withValues(alpha: 0.35),
                          blurRadius: 70,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    width: 270,
                    height: 270,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: kSecondaryContainer.withValues(alpha: 0.4),
                          blurRadius: 70,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                  ),

                // Main Illustration Image with Error Fallback
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    page.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/splash_plant.png',
                        fit: BoxFit.contain,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kPrimary,
                          strokeWidth: 2.5,
                        ),
                      );
                    },
                  ),
                ),

                // Floating Glassmorphism Reminder Card on Screen 2
                if (index == 1)
                  Positioned(
                    bottom: 0,
                    right: 12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.6),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kPrimary.withValues(alpha: 0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: kSecondaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.water_drop,
                                  color: kOnSecondaryContainer,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Water Monstera',
                                    style: GoogleFonts.manrope(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: kOnSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Today, 10:00 AM',
                                    style: GoogleFonts.manrope(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: kOnSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Title
          Text(
            page.title,
            style: GoogleFonts.manrope(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: kPrimary,
              letterSpacing: -0.56,
              height: 36 / 28,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              page.description,
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: kOnSurfaceVariant,
                height: 24 / 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final String title;
  final String description;
  final String imageUrl;
  final String buttonText;

  const _OnboardingData({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.buttonText,
  });
}
