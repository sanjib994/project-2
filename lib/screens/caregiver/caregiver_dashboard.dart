import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/medicine_provider.dart';
import 'reports_screen.dart';
import 'add_medicine_screen.dart';
import 'patient_profile_screen.dart';
import 'manage_medicines_screen.dart';
import 'caregiver_alerts_screen.dart';

class CaregiverDashboard extends StatefulWidget {
  const CaregiverDashboard({super.key});

  @override
  State<CaregiverDashboard> createState() => _CaregiverDashboardState();
}

class _CaregiverDashboardState extends State<CaregiverDashboard> {
  @override
  void initState() {
    super.initState();
    // Check for missed doses
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MedicineProvider>(context, listen: false)
          .checkForMissedDoses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MEDIFIT")),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.jpg'), // Local offline image
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisCount: 2,
          children: [
            _buildMenuCard(context, "Add Medicine", Icons.add_circle,
                Colors.blue, const AddMedicineScreen()),
            _buildMenuCard(context, "Manage Medicines", Icons.medication,
                Colors.teal, const ManageMedicinesScreen()),
            _buildMenuCard(context, "View Reports", Icons.bar_chart,
                Colors.orange, const ReportsScreen()),
            _buildMenuCard(context, "Alerts", Icons.notifications, Colors.red,
                const CaregiverAlertsScreen()),
            _buildMenuCard(
                context, "Elder Monitor", Icons.visibility, Colors.green, null),
            _buildMenuCard(context, "Profile", Icons.person, Colors.purple,
                const PatientProfileScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon,
      Color color, Widget? target) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          if (target != null) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => target));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
