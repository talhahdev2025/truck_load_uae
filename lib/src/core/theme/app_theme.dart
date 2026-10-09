import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Central theme configuration for Truckload UAE Flutter Web app
abstract final class AppTheme {
  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
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
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceContainerLow: AppColors.surfaceContainerLow,
        surfaceContainer: AppColors.surfaceContainer,
        surfaceContainerHigh: AppColors.surfaceContainerHigh,
        surfaceContainerHighest: AppColors.surfaceContainerHighest,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        error: AppColors.error,
        onError: Color(0xFF690005),
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: GoogleFonts.manrope(
          fontSize: 56,
          height: 64 / 56,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.68,
          color: AppColors.onSurface,
        ),
        displayMedium: GoogleFonts.manrope(
          fontSize: 40,
          height: 48 / 40,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          color: AppColors.onSurface,
        ),
        displaySmall: GoogleFonts.manrope(
          fontSize: 28,
          height: 36 / 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.56,
          color: AppColors.onSurface,
        ),
        headlineLarge: GoogleFonts.manrope(
          fontSize: 40,
          height: 48 / 40,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          color: AppColors.onSurface,
        ),
        headlineMedium: GoogleFonts.manrope(
          fontSize: 28,
          height: 36 / 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.56,
          color: AppColors.onSurface,
        ),
        headlineSmall: GoogleFonts.manrope(
          fontSize: 22,
          height: 30 / 22,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.33,
          color: AppColors.onSurface,
        ),
        titleLarge: GoogleFonts.manrope(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
        ),
        titleMedium: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
        ),
        bodyLarge: GoogleFonts.manrope(
          fontSize: 18,
          height: 28 / 18,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.18,
          color: AppColors.onSurfaceVariant,
        ),
        bodyMedium: GoogleFonts.manrope(
          fontSize: 15,
          height: 24 / 15,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceVariant,
        ),
        bodySmall: GoogleFonts.manrope(
          fontSize: 13,
          height: 20 / 13,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurfaceVariant,
        ),
        labelLarge: GoogleFonts.manrope(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.14,
          color: AppColors.onSurface,
        ),
        labelMedium: GoogleFonts.manrope(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.24,
          color: AppColors.onSurfaceVariant,
        ),
        labelSmall: GoogleFonts.manrope(
          fontSize: 11,
          height: 14 / 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.55,
          color: AppColors.onSurfaceVariant,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLow,
        hintStyle: GoogleFonts.manrope(
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
          fontSize: 15,
        ),
        labelStyle: GoogleFonts.manrope(
          color: AppColors.onSurfaceVariant,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.24,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryContainer,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
