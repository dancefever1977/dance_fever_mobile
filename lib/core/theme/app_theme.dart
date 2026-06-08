import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Electric Pulse Material 3 Theme
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    final colorScheme = const ColorScheme.dark(
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
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
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.inverseOnSurface,
      inversePrimary: AppColors.inversePrimary,
      surfaceTint: AppColors.surfaceTint,
    );

    final textTheme = GoogleFonts.nunitoSansTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          height: 1.1,
          letterSpacing: -0.5,
          color: AppColors.onSurface,
        ),
        displayMedium: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          height: 1.1,
          color: AppColors.onSurface,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          height: 1.2,
          color: AppColors.onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 1.3,
          color: AppColors.onSurface,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: AppColors.onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: AppColors.onSurface,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.0,
          letterSpacing: 0.7,
          color: AppColors.onSurface,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.0,
          color: AppColors.onSurface,
        ),
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.background,
      brightness: Brightness.dark,
    );
  }
}
