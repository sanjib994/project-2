import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Primary Color
      primaryColor: AppColors.primary,
      primarySwatch: MaterialColor(
        AppColors.primary.value,
        const <int, Color>{
          50: Color(0xFFE0F2F1),
          100: Color(0xFFB2DFDB),
          200: Color(0xFF80CBC4),
          300: Color(0xFF4DB8AA),
          400: Color(0xFF26A69A),
          500: Color(0xFF00897B),
          600: Color(0xFF00796B),
          700: Color(0xFF00695C),
          800: Color(0xFF004D40),
          900: Color(0xFF003D33),
        },
      ),

      // Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.statusTaken,
        error: AppColors.error,
        surface: AppColors.surface,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 4,
        shadowColor: AppColors.shadow,
        centerTitle: true,
        titleTextStyle: AppTypography.headlineLarge().copyWith(
          color: AppColors.white,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.buttonText(),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.buttonText(),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 4,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: AppTypography.bodyMedium().copyWith(
          color: AppColors.textSecondary,
        ),
        hintStyle: AppTypography.bodyMedium().copyWith(
          color: AppColors.textLight,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.primary,
        size: 24,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge().copyWith(
          color: AppColors.textPrimary,
        ),
        displayMedium: AppTypography.displayMedium().copyWith(
          color: AppColors.textPrimary,
        ),
        displaySmall: AppTypography.displaySmall().copyWith(
          color: AppColors.textPrimary,
        ),
        headlineLarge: AppTypography.headlineLarge().copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTypography.headlineMedium().copyWith(
          color: AppColors.textPrimary,
        ),
        headlineSmall: AppTypography.headlineSmall().copyWith(
          color: AppColors.textPrimary,
        ),
        titleLarge: AppTypography.titleLarge().copyWith(
          color: AppColors.textPrimary,
        ),
        titleMedium: AppTypography.titleMedium().copyWith(
          color: AppColors.textPrimary,
        ),
        titleSmall: AppTypography.titleSmall().copyWith(
          color: AppColors.textPrimary,
        ),
        bodyLarge: AppTypography.bodyLarge().copyWith(
          color: AppColors.textPrimary,
        ),
        bodyMedium: AppTypography.bodyMedium().copyWith(
          color: AppColors.textSecondary,
        ),
        bodySmall: AppTypography.bodySmall().copyWith(
          color: AppColors.textSecondary,
        ),
        labelLarge: AppTypography.labelLarge().copyWith(
          color: AppColors.textPrimary,
        ),
        labelMedium: AppTypography.labelMedium().copyWith(
          color: AppColors.textSecondary,
        ),
        labelSmall: AppTypography.labelSmall().copyWith(
          color: AppColors.textLight,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.background,
    );
  }
}
