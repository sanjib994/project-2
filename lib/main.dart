import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/medicine_provider.dart';
import 'providers/medicine_history_provider.dart';
import 'providers/alert_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/elder/todays_medicines_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MedicineProvider()),
        ChangeNotifierProvider(create: (_) => MedicineHistoryProvider()),
        ChangeNotifierProvider(create: (_) => AlertProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            title: 'Smart Medicine Reminder',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
              textTheme: settingsProvider.getTextTheme(const TextTheme(
                displayLarge:
                    TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                displayMedium:
                    TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                displaySmall:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                headlineLarge:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                headlineMedium:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                headlineSmall:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                titleLarge:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                titleMedium:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                titleSmall:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                bodyLarge: TextStyle(fontSize: 18),
                bodyMedium: TextStyle(fontSize: 16),
                bodySmall: TextStyle(fontSize: 14),
                labelLarge:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                labelMedium:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                labelSmall:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )),
            ),
            home: const TodaysMedicinesScreen(), // Starting screen
          );
        },
      ),
    );
  }
}
