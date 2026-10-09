import 'package:flutter/material.dart';

/// App color palette matching Tailwind color definitions from TRUCKLOAD UAE design specs
abstract final class AppColors {
  // Backgrounds & Surfaces
  static const Color background = Color(0xFF111317);
  static const Color surface = Color(0xFF111317);
  static const Color surfaceContainerLowest = Color(0xFF0C0E12);
  static const Color surfaceContainerLow = Color(0xFF1A1C20);
  static const Color surfaceContainer = Color(0xFF1E2024);
  static const Color surfaceContainerHigh = Color(0xFF282A2E);
  static const Color surfaceContainerHighest = Color(0xFF333539);
  static const Color surfaceVariant = Color(0xFF333539);
  static const Color surfaceBright = Color(0xFF37393E);
  static const Color surfaceDim = Color(0xFF111317);

  // Primary (Amber / Warm Gold)
  static const Color primary = Color(0xFFFFC081);
  static const Color primaryFixedDim = Color(0xFFFFB870);
  static const Color primaryFixed = Color(0xFFFFDCBE);
  static const Color primaryContainer = Color(0xFFFF9800);
  static const Color onPrimary = Color(0xFF4A2800);
  static const Color onPrimaryContainer = Color(0xFF653900);
  static const Color surfaceTint = Color(0xFFFFB870);

  // Secondary (Signal Green)
  static const Color secondary = Color(0xFF4AE176);
  static const Color secondaryFixed = Color(0xFF6BFF8F);
  static const Color secondaryFixedDim = Color(0xFF4AE176);
  static const Color secondaryContainer = Color(0xFF00B954);
  static const Color onSecondary = Color(0xFF003915);
  static const Color onSecondaryContainer = Color(0xFF004119);

  // Tertiary (Aero Blue / Cyan)
  static const Color tertiary = Color(0xFF8BD5FF);
  static const Color tertiaryContainer = Color(0xFF00BEFD);
  static const Color tertiaryFixedDim = Color(0xFF79D1FF);
  static const Color onTertiary = Color(0xFF003549);

  // Text & On-Surface
  static const Color onSurface = Color(0xFFE2E2E8);
  static const Color onSurfaceVariant = Color(0xFFDBC2AD);
  static const Color onBackground = Color(0xFFE2E2E8);

  // Borders & Outlines
  static const Color outline = Color(0xFFA38D7A);
  static const Color outlineVariant = Color(0xFF554434);

  // Error
  static const Color error = Color(0xFFFFB4AB);
  static const Color errorContainer = Color(0xFF93000A);
}
