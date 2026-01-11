import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../widgets/bottom_navigation_bar.dart';
import 'elder_dashboard.dart';
import 'todays_medicines_screen.dart';
import 'medicine_history_screen.dart';
import 'emergency_sos_screen.dart';
import 'settings_screen.dart';

class ElderNavigationShell extends StatefulWidget {
  const ElderNavigationShell({super.key});

  @override
  State<ElderNavigationShell> createState() => _ElderNavigationShellState();
}

class _ElderNavigationShellState extends State<ElderNavigationShell>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<Widget> _screens;
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();
    _screens = [
      const ElderDashboard(),
      const TodaysMedicinesScreen(),
      const MedicineHistoryScreen(),
      const SettingsScreen(),
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

  void _handleSOSButtonPress() {
    HapticFeedback.heavyImpact();
    Navigator.of(context).push(
      PageTransitions.slideUpTransition(const EmergencySosScreen()),
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
            label: 'Home',
          ),
          BottomNavItem(
            icon: Icons.medication,
            label: 'Today',
          ),
          BottomNavItem(
            icon: Icons.history,
            label: 'History',
          ),
          BottomNavItem(
            icon: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // SOS FAB
          FloatingActionButton.extended(
            onPressed: _handleSOSButtonPress,
            backgroundColor: AppColors.statusMissed,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.emergency),
            label: const Text('SOS'),
            heroTag: 'sos_fab',
            elevation: 8,
            extendedPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const SizedBox(height: 16),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
