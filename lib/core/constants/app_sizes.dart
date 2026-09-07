import 'package:flutter/material.dart';

/// Spacing and sizing tokens matching the Tailwind design specs
class AppSizes {
  AppSizes._();

  // Spacing tokens
  static const double unit = 8.0;
  static const double stackGapSm = 8.0;
  static const double stackGapMd = 16.0;
  static const double stackGapLg = 24.0;
  static const double sectionPadding = 32.0;
  static const double marginHorizontal = 24.0;

  // Border Radius tokens
  static const double radiusDefault = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radius2Xl = 24.0;
  static const double radiusFull = 9999.0;

  static const BorderRadius roundedSm = BorderRadius.all(Radius.circular(radiusDefault));
  static const BorderRadius roundedMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius roundedLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius roundedXl = BorderRadius.all(Radius.circular(radiusXl));
  static const BorderRadius roundedCard = BorderRadius.all(Radius.circular(radius2Xl));
  static const BorderRadius roundedFull = BorderRadius.all(Radius.circular(radiusFull));
}
