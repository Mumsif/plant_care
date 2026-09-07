import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_care/features/onboarding/onboarding_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  // Main intro animation controller
  late AnimationController _introController;
  late Animation<double> _fadeUpAnimation;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _circleProgress;
  late Animation<double> _leafProgress;
  late Animation<double> _dotsFadeAnimation;

  // Background subtle drift animation controller
  late AnimationController _driftController;

  // Bottom dots pulse animation controller
  late AnimationController _pulseController;

  // Theme Colors from Tailwind design specs
  static const Color kBackground = Color(0xFFF8FAF6);
  static const Color kPrimary = Color(0xFF04442D);
  static const Color kSecondary = Color(0xFF186C3D);
  static const Color kPrimaryContainer = Color(0xFF245C43);
  static const Color kPrimaryFixed = Color(0xFFB5F0CF);
  static const Color kOnSurfaceVariant = Color(0xFF404943);
  static const Color kSurfaceTint = Color(0xFF31694F);

  @override
  void initState() {
    super.initState();

    // Intro Animation (2.2s total duration)
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    // Fade & Slide up for main content
    _fadeUpAnimation = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    );

    _slideUpAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
    ));

    // Outer Circle Draw Animation
    _circleProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.05, 0.65, curve: Curves.easeInOutCubic),
      ),
    );

    // Inner Leaf Growth Animation with elastic pop
    _leafProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.38, 0.88, curve: Curves.easeOutBack),
      ),
    );

    // Bottom dots entrance
    _dotsFadeAnimation = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.68, 1.0, curve: Curves.easeOut),
    );

    // Subtle drift for ambient background leaves (20s loop)
    _driftController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);

    // Continuous pulsing for bottom loading dots
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Start intro sequence
    _introController.forward();

    // Smooth navigation to OnboardingScreen after splash intro finishes
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _introController.dispose();
    _driftController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Stack(
        children: [
          // -------------------------------------------------------------
          // Ambient Background Decorations (Animated Drifting Abstract Shapes)
          // -------------------------------------------------------------
          // Top Right Abstract Leaf
          AnimatedBuilder(
            animation: _driftController,
            builder: (context, child) {
              final drift = _driftController.value;
              return Positioned(
                top: -128 + (15 * drift),
                right: -128 - (15 * drift),
                width: 384,
                height: 384,
                child: Transform.rotate(
                  angle: (3 * drift) * math.pi / 180,
                  child: child,
                ),
              );
            },
            child: CustomPaint(
              painter: AmbientBlobPainter(
                color: kPrimary.withValues(alpha: 0.03),
                isTopRight: true,
              ),
            ),
          ),

          // Bottom Left Abstract Leaf
          AnimatedBuilder(
            animation: _driftController,
            builder: (context, child) {
              final drift = _driftController.value;
              return Positioned(
                bottom: -160 + (10 * drift),
                left: -80 - (20 * drift),
                width: 480,
                height: 480,
                child: Transform.rotate(
                  angle: (-2 * drift) * math.pi / 180,
                  child: child,
                ),
              );
            },
            child: CustomPaint(
              painter: AmbientBlobPainter(
                color: kSecondary.withValues(alpha: 0.04),
                isTopRight: false,
              ),
            ),
          ),

          // -------------------------------------------------------------
          // Main Splash Content Container
          // -------------------------------------------------------------
          Center(
            child: FadeTransition(
              opacity: _fadeUpAnimation,
              child: SlideTransition(
                position: _slideUpAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Animated Logo Assembly (128x128)
                    SizedBox(
                      width: 128,
                      height: 128,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Subtle backdrop glow
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryFixed.withValues(alpha: 0.4),
                                  blurRadius: 36,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                          ),

                          // SVG Logo Painter
                          AnimatedBuilder(
                            animation: _introController,
                            builder: (context, child) {
                              return CustomPaint(
                                size: const Size(128, 128),
                                painter: PlantCareLogoPainter(
                                  circleProgress: _circleProgress.value,
                                  leafProgress: _leafProgress.value,
                                  color: kPrimaryContainer,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24), // mb-stack-gap-lg

                    // Title
                    Text(
                      'PlantCare',
                      style: GoogleFonts.manrope(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryContainer,
                        letterSpacing: -0.56,
                        height: 36 / 28,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8), // mb-stack-gap-sm

                    // Tagline
                    Text(
                      'Grow better, every day',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: kOnSurfaceVariant.withValues(alpha: 0.9),
                        height: 24 / 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // -------------------------------------------------------------
          // Subtle Loading Indicator (Pulsing 3-dots at bottom)
          // -------------------------------------------------------------
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _dotsFadeAnimation,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPulsingDot(0.0),
                      const SizedBox(width: 8),
                      _buildPulsingDot(0.2),
                      const SizedBox(width: 8),
                      _buildPulsingDot(0.4),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulsingDot(double delayFraction) {
    final progress = (_pulseController.value + delayFraction) % 1.0;
    // Pulsing opacity between 0.15 and 0.70
    final opacity = 0.15 + 0.55 * (0.5 * (1 + math.sin(progress * 2 * math.pi)));

    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kSurfaceTint.withValues(alpha: opacity),
      ),
    );
  }
}

/// Custom painter for the animated PlantCare SVG logo
class PlantCareLogoPainter extends CustomPainter {
  final double circleProgress;
  final double leafProgress;
  final Color color;

  PlantCareLogoPainter({
    required this.circleProgress,
    required this.leafProgress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 120x120 viewBox scale
    final scale = size.width / 120.0;
    canvas.save();
    canvas.scale(scale);

    // 1. Draw Outer Growth Circle
    if (circleProgress > 0) {
      final circlePaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: const Offset(60, 60), radius: 54),
        -math.pi / 2,
        2 * math.pi * circleProgress,
        false,
        circlePaint,
      );
    }

    // 2. Draw Realistic Botanical Leaf with origin at stem base (60, 102)
    if (leafProgress > 0) {
      canvas.save();
      // Animate growth from stem base
      canvas.translate(60, 102);
      canvas.scale(leafProgress, leafProgress);
      canvas.translate(-60, -102);

      // --- Stem (Petiole) ---
      final stemPaint = Paint()
        ..color = const Color(0xFF1A5233)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round;

      final stemPath = Path();
      stemPath.moveTo(60, 102);
      stemPath.cubicTo(60, 94, 59.5, 86, 59.5, 78);
      canvas.drawPath(stemPath, stemPaint);

      // --- Companion Baby Leaf (Sprout on right) ---
      final companionPath = Path();
      companionPath.moveTo(59.5, 84);
      companionPath.cubicTo(68, 82, 78, 75, 83, 67);
      companionPath.cubicTo(83, 62, 75, 63, 69, 68);
      companionPath.cubicTo(63, 73, 60, 79, 59.5, 84);
      companionPath.close();

      final companionPaint = Paint()
        ..shader = const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFF246C45),
            Color(0xFF3DA36C),
          ],
        ).createShader(const Rect.fromLTRB(59.5, 62, 83, 84))
        ..style = PaintingStyle.fill;

      canvas.drawPath(companionPath, companionPaint);

      // --- Main Leaf: Left Half (Shaded natural foliage) ---
      final leftHalfPath = Path();
      leftHalfPath.moveTo(59.5, 78);
      leftHalfPath.cubicTo(45, 74, 33, 58, 33, 44);
      leftHalfPath.cubicTo(33, 32, 45, 22, 60, 18);
      leftHalfPath.cubicTo(59.6, 38, 59.5, 58, 59.5, 78);
      leftHalfPath.close();

      final leftPaint = Paint()
        ..shader = const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFF164E2F),
            Color(0xFF226B43),
          ],
        ).createShader(const Rect.fromLTRB(33, 18, 60, 78))
        ..style = PaintingStyle.fill;

      canvas.drawPath(leftHalfPath, leftPaint);

      // --- Main Leaf: Right Half (Sunlit fresh foliage) ---
      final rightHalfPath = Path();
      rightHalfPath.moveTo(60, 18);
      rightHalfPath.cubicTo(75, 22, 87, 32, 87, 44);
      rightHalfPath.cubicTo(87, 58, 75, 74, 59.5, 78);
      rightHalfPath.cubicTo(59.5, 58, 59.6, 38, 60, 18);
      rightHalfPath.close();

      final rightPaint = Paint()
        ..shader = const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFF2B794E),
            Color(0xFF3BA26A),
          ],
        ).createShader(const Rect.fromLTRB(59.5, 18, 87, 78))
        ..style = PaintingStyle.fill;

      canvas.drawPath(rightHalfPath, rightPaint);

      // --- Central Midrib Vein ---
      final midribPaint = Paint()
        ..color = const Color(0xFFA5F0C6).withValues(alpha: 0.40)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..strokeCap = StrokeCap.round;

      final midribPath = Path();
      midribPath.moveTo(59.5, 78);
      midribPath.cubicTo(59.5, 58, 59.7, 38, 60, 19);
      canvas.drawPath(midribPath, midribPaint);

      // --- Lateral Veins (Secondary venation) ---
      final veinPaint = Paint()
        ..color = const Color(0xFFA5F0C6).withValues(alpha: 0.30)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round;

      final veinsPath = Path();
      // Left lateral veins
      veinsPath.moveTo(59.5, 68);
      veinsPath.cubicTo(54, 65, 48, 63, 42, 60);

      veinsPath.moveTo(59.6, 54);
      veinsPath.cubicTo(52, 50, 45, 47, 39, 44);

      veinsPath.moveTo(59.8, 40);
      veinsPath.cubicTo(53, 36, 48, 33, 45, 30);

      // Right lateral veins
      veinsPath.moveTo(59.5, 68);
      veinsPath.cubicTo(65, 65, 71, 63, 77, 60);

      veinsPath.moveTo(59.6, 54);
      veinsPath.cubicTo(67, 50, 74, 47, 80, 44);

      veinsPath.moveTo(59.8, 40);
      veinsPath.cubicTo(66, 36, 71, 33, 74, 30);

      // Companion leaf midrib
      veinsPath.moveTo(60, 83);
      veinsPath.cubicTo(67, 78, 74, 73, 80, 68);

      canvas.drawPath(veinsPath, veinPaint);

      canvas.restore();
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant PlantCareLogoPainter oldDelegate) {
    return oldDelegate.circleProgress != circleProgress ||
        oldDelegate.leafProgress != leafProgress ||
        oldDelegate.color != color;
  }
}

/// Custom painter for the ambient organic leaf/blob shapes in the background
class AmbientBlobPainter extends CustomPainter {
  final Color color;
  final bool isTopRight;

  AmbientBlobPainter({required this.color, required this.isTopRight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scale = size.width / 200.0;
    canvas.save();
    canvas.scale(scale);
    canvas.translate(100, 100);

    final path = Path();
    if (isTopRight) {
      path.moveTo(38.5, -59.8);
      path.cubicTo(52.6, -50.2, 68.8, -43.0, 76.5, -30.2);
      path.cubicTo(84.2, -17.4, 83.4, 1.0, 76.5, 15.6);
      path.cubicTo(69.6, 30.2, 56.7, 40.9, 43.3, 49.2);
      path.cubicTo(30.0, 57.5, 15.0, 63.4, 0.3, 62.9);
      path.cubicTo(-14.4, 62.5, -28.8, 55.7, -42.6, 47.3);
      path.cubicTo(-56.4, 38.9, -69.6, 28.8, -75.4, 14.7);
      path.cubicTo(-81.2, 0.6, -79.6, -17.6, -70.6, -31.6);
      path.cubicTo(-61.6, -45.6, -45.2, -55.4, -30.3, -64.5);
      path.cubicTo(-15.4, -73.6, -2.0, -82.0, 9.3, -79.9);
      path.cubicTo(20.6, -77.8, 41.2, -65.2, 38.5, -59.8);
      path.close();
    } else {
      path.moveTo(43.7, -74.6);
      path.cubicTo(56.1, -65.7, 65.2, -51.7, 71.7, -36.8);
      path.cubicTo(78.2, -21.9, 82.1, -6.1, 79.5, 8.7);
      path.cubicTo(76.9, 23.5, 67.8, 37.3, 55.9, 47.8);
      path.cubicTo(44.0, 58.3, 29.3, 65.5, 13.7, 70.0);
      path.cubicTo(-1.9, 74.5, -18.4, 76.3, -33.1, 71.2);
      path.cubicTo(-47.8, 66.1, -60.7, 54.1, -68.8, 40.1);
      path.cubicTo(-76.9, 26.1, -80.2, 10.1, -78.0, -4.9);
      path.cubicTo(-75.8, -19.9, -68.1, -33.9, -57.4, -44.7);
      path.cubicTo(-46.7, -55.5, -33.0, -63.1, -19.5, -69.3);
      path.cubicTo(-6.0, -75.5, 7.3, -80.3, 21.5, -79.1);
      path.cubicTo(35.7, -77.9, 50.8, -70.7, 43.7, -74.6);
      path.close();
    }

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}