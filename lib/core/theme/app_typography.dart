import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography constants for consistent font hierarchy
/// Optimized for accessibility (WCAG AAA standards)
class AppTypography {
  // Font families
  static const String primaryFont =
      'Lato'; // Clean, readable font for elderly users
  static const String headingFont =
      'Merriweather'; // Serif for better distinction

  /// Display Styles - Large, attention-grabbing text
  static TextStyle displayLarge() {
    return GoogleFonts.merriweather(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      height: 1.2,
      letterSpacing: 0.5,
    );
  }

  static TextStyle displayMedium() {
    return GoogleFonts.merriweather(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      height: 1.3,
      letterSpacing: 0.3,
    );
  }

  static TextStyle displaySmall() {
    return GoogleFonts.merriweather(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      height: 1.3,
      letterSpacing: 0.2,
    );
  }

  /// Headline Styles - Section titles and important content
  static TextStyle headlineLarge() {
    return GoogleFonts.merriweather(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      height: 1.3,
      letterSpacing: 0.2,
    );
  }

  static TextStyle headlineMedium() {
    return GoogleFonts.merriweather(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      height: 1.4,
      letterSpacing: 0.1,
    );
  }

  static TextStyle headlineSmall() {
    return GoogleFonts.merriweather(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 1.4,
      letterSpacing: 0.1,
    );
  }

  /// Title Styles - Card titles and subsections
  static TextStyle titleLarge() {
    return GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      height: 1.4,
      letterSpacing: 0.1,
    );
  }

  static TextStyle titleMedium() {
    return GoogleFonts.lato(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.4,
      letterSpacing: 0.05,
    );
  }

  static TextStyle titleSmall() {
    return GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.5,
      letterSpacing: 0.05,
    );
  }

  /// Body Styles - Main content text
  static TextStyle bodyLarge() {
    return GoogleFonts.lato(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      height: 1.5,
      letterSpacing: 0.0,
    );
  }

  static TextStyle bodyMedium() {
    return GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.5,
      letterSpacing: 0.0,
    );
  }

  static TextStyle bodySmall() {
    return GoogleFonts.lato(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.5,
      letterSpacing: 0.0,
    );
  }

  /// Label Styles - Buttons, badges, and small interactive elements
  static TextStyle labelLarge() {
    return GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      height: 1.3,
      letterSpacing: 0.5,
    );
  }

  static TextStyle labelMedium() {
    return GoogleFonts.lato(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: 0.4,
    );
  }

  static TextStyle labelSmall() {
    return GoogleFonts.lato(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: 0.3,
    );
  }

  /// Custom styles for specific use cases

  /// Medicine name style - Prominent and highly readable
  static TextStyle medicineName() {
    return GoogleFonts.merriweather(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      height: 1.2,
      letterSpacing: 0.5,
    );
  }

  /// Medicine dosage and time - Clear secondary information
  static TextStyle medicineInfo() {
    return GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 1.4,
      letterSpacing: 0.2,
    );
  }

  /// Button text - Clear call-to-action
  static TextStyle buttonText() {
    return GoogleFonts.lato(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      height: 1.3,
      letterSpacing: 0.5,
    );
  }

  /// Caption text - Smallest readable text
  static TextStyle caption() {
    return GoogleFonts.lato(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 1.4,
      letterSpacing: 0.3,
    );
  }

  /// Status badge text
  static TextStyle statusBadge() {
    return GoogleFonts.lato(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      height: 1.2,
      letterSpacing: 0.5,
    );
  }
}
