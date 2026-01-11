import 'package:flutter/material.dart';

/// Healthcare-inspired color palette for Smart Medicine Reminder
class AppColors {
  // Primary Colors - Teal/Green for wellness & healthcare
  static const Color primary = Color(0xFF00897B); // Teal
  static const Color primaryLight = Color(0xFF4DB8AA); // Light Teal
  static const Color primaryDark = Color(0xFF00695C); // Dark Teal

  // Secondary Colors - Complementary accent
  static const Color secondary = Color(0xFF0288D1); // Sky Blue
  static const Color secondaryLight = Color(0xFF4FC3F7); // Light Blue
  static const Color secondaryDark = Color(0xFF0277BD); // Dark Blue

  // Status Colors
  static const Color statusTaken = Color(0xFF4CAF50); // Green - Medicine taken
  static const Color statusPending = Color(0xFFFFA726); // Orange - Pending
  static const Color statusMissed = Color(0xFFEF5350); // Red - Missed
  static const Color statusDue = Color(0xFFFFB74D); // Amber - Due soon

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFBDBDBD);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);

  // Backgrounds & Gradients
  static const Color gradientStart = Color(0xFF00897B); // Teal
  static const Color gradientEnd = Color(0xFF0288D1); // Blue

  // Alert Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFF57C00);
  static const Color success = Color(0xFF388E3C);
  static const Color info = Color(0xFF1976D2);

  // Shadow
  static const Color shadow = Color(0x1A000000);

  // Category Colors for Medicine Types
  static const List<Color> medicineCategories = [
    Color(0xFF00897B), // Painkillers - Teal
    Color(0xFF0288D1), // Vitamins - Blue
    Color(0xFF7B1FA2), // Antibiotics - Purple
    Color(0xFFD32F2F), // Cardiovascular - Red
    Color(0xFFF57C00), // Digestive - Orange
    Color(0xFF388E3C), // Respiratory - Green
  ];
}
