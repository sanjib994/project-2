import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/elder/elder_dashboard.dart';
import '../screens/caregiver/caregiver_dashboard.dart';
import '../screens/caregiver/add_medicine_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String elderDash = '/elder-dashboard';
  static const String caregiverDash = '/caregiver-dashboard';
  static const String addMedicine = '/add-medicine';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginScreen(),
      elderDash: (context) => const ElderDashboard(),
      caregiverDash: (context) => const CaregiverDashboard(),
      addMedicine: (context) => const AddMedicineScreen(),
    };
  }
}