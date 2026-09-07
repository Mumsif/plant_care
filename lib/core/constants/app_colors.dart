import 'package:flutter/material.dart';

/// App color palette matching the Tailwind Design System specifications
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF04442D);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF245C43);
  static const Color onPrimaryContainer = Color(0xFF98D2B3);
  static const Color primaryFixed = Color(0xFFB5F0CF);
  static const Color primaryFixedDim = Color(0xFF99D3B3);
  static const Color onPrimaryFixed = Color(0xFF002113);
  static const Color onPrimaryFixedVariant = Color(0xFF165038);

  static const Color secondary = Color(0xFF186C3D);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFA1F2B6);
  static const Color onSecondaryContainer = Color(0xFF1F7041);
  static const Color secondaryFixed = Color(0xFFA3F4B9);
  static const Color secondaryFixedDim = Color(0xFF88D89E);
  static const Color onSecondaryFixed = Color(0xFF00210E);
  static const Color onSecondaryFixedVariant = Color(0xFF00522A);

  static const Color tertiary = Color(0xFF2F3F35);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF46564C);
  static const Color onTertiaryContainer = Color(0xFFB9CABD);
  static const Color tertiaryFixed = Color(0xFFD5E7D9);
  static const Color tertiaryFixedDim = Color(0xFFB9CBBE);
  static const Color onTertiaryFixed = Color(0xFF101F16);
  static const Color onTertiaryFixedVariant = Color(0xFF3B4A40);

  static const Color surface = Color(0xFFF8FAF6);
  static const Color onSurface = Color(0xFF191C1A);
  static const Color surfaceVariant = Color(0xFFE1E3DF);
  static const Color onSurfaceVariant = Color(0xFF404943);
  static const Color surfaceBright = Color(0xFFF8FAF6);
  static const Color surfaceDim = Color(0xFFD9DBD7);

  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F4F0);
  static const Color surfaceContainer = Color(0xFFEDEEEA);
  static const Color surfaceContainerHigh = Color(0xFFE7E9E5);
  static const Color surfaceContainerHighest = Color(0xFFE1E3DF);

  static const Color inverseSurface = Color(0xFF2E312F);
  static const Color inverseOnSurface = Color(0xFFF0F1ED);
  static const Color inversePrimary = Color(0xFF99D3B3);

  static const Color background = Color(0xFFF8FAF6);
  static const Color onBackground = Color(0xFF191C1A);

  static const Color outline = Color(0xFF707973);
  static const Color outlineVariant = Color(0xFFC0C9C1);
  static const Color surfaceTint = Color(0xFF31694F);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Custom shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.04),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get bottomNavShadow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.05),
          blurRadius: 20,
          offset: const Offset(0, -4),
        ),
      ];

  static List<BoxShadow> get fabShadow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.16),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];
}
