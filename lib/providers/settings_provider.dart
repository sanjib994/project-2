import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool _notificationSounds = true;
  bool _voiceReminders = true;
  String _fontSize = 'Medium';
  String _language = 'English';

  bool get notificationSounds => _notificationSounds;
  bool get voiceReminders => _voiceReminders;
  String get fontSize => _fontSize;
  String get language => _language;

  double get fontScale {
    switch (_fontSize) {
      case 'Small':
        return 0.8;
      case 'Large':
        return 1.2;
      case 'Medium':
      default:
        return 1.0;
    }
  }

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationSounds = prefs.getBool('notificationSounds') ?? true;
    _voiceReminders = prefs.getBool('voiceReminders') ?? true;
    _fontSize = prefs.getString('fontSize') ?? 'Medium';
    _language = prefs.getString('language') ?? 'English';
    notifyListeners();
  }

  Future<void> setNotificationSounds(bool value) async {
    _notificationSounds = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationSounds', value);
    notifyListeners();
  }

  Future<void> setVoiceReminders(bool value) async {
    _voiceReminders = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('voiceReminders', value);
    notifyListeners();
  }

  Future<void> setFontSize(String value) async {
    _fontSize = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fontSize', value);
    notifyListeners();
  }

  Future<void> setLanguage(String value) async {
    _language = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', value);
    notifyListeners();
  }

  TextTheme getTextTheme(TextTheme baseTheme) {
    final scale = fontScale;
    return baseTheme.copyWith(
      displayLarge: baseTheme.displayLarge?.copyWith(
          fontSize: (baseTheme.displayLarge?.fontSize ?? 32) * scale),
      displayMedium: baseTheme.displayMedium?.copyWith(
          fontSize: (baseTheme.displayMedium?.fontSize ?? 28) * scale),
      displaySmall: baseTheme.displaySmall?.copyWith(
          fontSize: (baseTheme.displaySmall?.fontSize ?? 24) * scale),
      headlineLarge: baseTheme.headlineLarge?.copyWith(
          fontSize: (baseTheme.headlineLarge?.fontSize ?? 24) * scale),
      headlineMedium: baseTheme.headlineMedium?.copyWith(
          fontSize: (baseTheme.headlineMedium?.fontSize ?? 20) * scale),
      headlineSmall: baseTheme.headlineSmall?.copyWith(
          fontSize: (baseTheme.headlineSmall?.fontSize ?? 18) * scale),
      titleLarge: baseTheme.titleLarge
          ?.copyWith(fontSize: (baseTheme.titleLarge?.fontSize ?? 20) * scale),
      titleMedium: baseTheme.titleMedium
          ?.copyWith(fontSize: (baseTheme.titleMedium?.fontSize ?? 18) * scale),
      titleSmall: baseTheme.titleSmall
          ?.copyWith(fontSize: (baseTheme.titleSmall?.fontSize ?? 16) * scale),
      bodyLarge: baseTheme.bodyLarge
          ?.copyWith(fontSize: (baseTheme.bodyLarge?.fontSize ?? 18) * scale),
      bodyMedium: baseTheme.bodyMedium
          ?.copyWith(fontSize: (baseTheme.bodyMedium?.fontSize ?? 16) * scale),
      bodySmall: baseTheme.bodySmall
          ?.copyWith(fontSize: (baseTheme.bodySmall?.fontSize ?? 14) * scale),
      labelLarge: baseTheme.labelLarge
          ?.copyWith(fontSize: (baseTheme.labelLarge?.fontSize ?? 16) * scale),
      labelMedium: baseTheme.labelMedium
          ?.copyWith(fontSize: (baseTheme.labelMedium?.fontSize ?? 14) * scale),
      labelSmall: baseTheme.labelSmall
          ?.copyWith(fontSize: (baseTheme.labelSmall?.fontSize ?? 12) * scale),
    );
  }
}
