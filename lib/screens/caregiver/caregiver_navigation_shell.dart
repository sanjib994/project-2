import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../providers/medicine_provider.dart';
import 'caregiver_dashboard.dart';
import 'add_medicine_screen.dart';
import 'manage_medicines_screen.dart';
import 'reports_screen.dart';
import 'caregiver_alerts_screen.dart';

class CaregiverNavigationShell extends StatefulWidget {
  const CaregiverNavigationShell({super.key});

  @override
  State<CaregiverNavigationShell> createState() =>
      _CaregiverNavigationShellState();
}

class _CaregiverNavigationShellState extends State<CaregiverNavigationShell>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<Widget> _screens;
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();
    // Check for missed doses on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MedicineProvider>(context, listen: false)
          .checkForMissedDoses();
    });

    _screens = [
      const CaregiverDashboard(),
      const ManageMedicinesScreen(),
      const ReportsScreen(),
      const CaregiverAlertsScreen(),
    ];

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleAddMedicinePress() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      PageTransitions.slideUpTransition(const AddMedicineScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavItemTapped,
        items: [
          BottomNavItem(
            icon: Icons.home,
            label: 'Dashboard',
          ),
          BottomNavItem(
            icon: Icons.medication,
            label: 'Medicines',
          ),
          BottomNavItem(
            icon: Icons.bar_chart,
            label: 'Reports',
          ),
          BottomNavItem(
            icon: Icons.notifications,
            label: 'Alerts',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleAddMedicinePress,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_circle, size: 28),
        label: const Text(
          'Add Medicine',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        elevation: 8,
        heroTag: 'add_medicine_fab',
        extendedPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
