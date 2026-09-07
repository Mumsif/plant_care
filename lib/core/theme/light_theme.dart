import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Light theme configured with Material 3 and Manrope typography
ThemeData buildLightTheme() {
  final baseTextTheme = GoogleFonts.manropeTextTheme();

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      surfaceContainerLowest: AppColors.surfaceContainerLowest,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.inverseOnSurface,
      inversePrimary: AppColors.inversePrimary,
    ),
    textTheme: baseTextTheme.copyWith(
      displayLarge: GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.56,
        color: AppColors.primary,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.22,
        color: AppColors.primary,
      ),
      titleSmall: GoogleFonts.manrope(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.onSurface,
      ),
      bodyMedium: GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.onSurfaceVariant,
      ),
      labelMedium: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: AppColors.onSurface,
      ),
      bodySmall: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurfaceVariant,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.56,
        color: AppColors.primary,
      ),
      iconTheme: const IconThemeData(color: AppColors.primary),
    ),
  );
}
