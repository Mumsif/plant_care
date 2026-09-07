import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Dark theme configured with Material 3 and Manrope typography
ThemeData buildDarkTheme() {
  final baseTextTheme = GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF131513),
    primaryColor: AppColors.primaryFixedDim,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryFixedDim,
      onPrimary: Color(0xFF003822),
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondaryFixedDim,
      onSecondary: Color(0xFF00391C),
      secondaryContainer: Color(0xFF00522A),
      onSecondaryContainer: AppColors.secondaryFixed,
      tertiary: AppColors.tertiaryFixedDim,
      onTertiary: Color(0xFF1B3526),
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      surface: Color(0xFF191C1A),
      onSurface: Color(0xFFE1E3DF),
      surfaceContainerLowest: Color(0xFF0F1110),
      surfaceContainerLow: Color(0xFF1C1F1D),
      surfaceContainer: Color(0xFF202321),
      surfaceContainerHigh: Color(0xFF2B2E2C),
      surfaceContainerHighest: Color(0xFF363937),
      outline: AppColors.outline,
      outlineVariant: Color(0xFF404943),
      inverseSurface: AppColors.surfaceContainerLowest,
      onInverseSurface: AppColors.onSurface,
      inversePrimary: AppColors.primary,
    ),
    textTheme: baseTextTheme.copyWith(
      displayLarge: GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.56,
        color: AppColors.primaryFixedDim,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.22,
        color: AppColors.primaryFixedDim,
      ),
      titleSmall: GoogleFonts.manrope(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFE1E3DF),
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: const Color(0xFFE1E3DF),
      ),
      bodyMedium: GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: const Color(0xFFB9CABD),
      ),
      labelMedium: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: const Color(0xFFE1E3DF),
      ),
      bodySmall: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFB9CABD),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF131513),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.56,
        color: AppColors.primaryFixedDim,
      ),
      iconTheme: const IconThemeData(color: AppColors.primaryFixedDim),
    ),
  );
}
