import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/staggered_animated_card.dart';
import '../../providers/medicine_provider.dart';
import '../../models/medicine_model.dart';
import '../../services/firestore_service.dart';
import 'medicine_history_screen.dart';
import 'emergency_sos_screen.dart';
import 'settings_screen.dart';

class TodaysMedicinesScreen extends StatefulWidget {
  const TodaysMedicinesScreen({super.key});

  @override
  State<TodaysMedicinesScreen> createState() => _TodaysMedicinesScreenState();
}

class _TodaysMedicinesScreenState extends State<TodaysMedicinesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MedicineProvider>(context, listen: false).fetchMedicines();
  }

  Widget _buildQuickActionCard(BuildContext context, String title,
      IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 120,
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTypography.labelMedium().copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medProvider = Provider.of<MedicineProvider>(context);
    final today = DateFormat('EEEE').format(DateTime.now());

    // Filter medicines for today
    final todaysMedicines =
        medProvider.medicines.where((med) => med.days.contains(today)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Today's Medicines",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: todaysMedicines.isEmpty
                ? const Center(
                    child: Text(
                      "No medicines scheduled for today.",
                      style: TextStyle(
                          fontSize: 20, color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: todaysMedicines.length,
                    itemBuilder: (context, index) {
                      final med = todaysMedicines[index];
                      return StaggeredAnimatedCard(
                        delayIndex: index,
                        child: MedicineCardToday(medicine: med),
                      );
                    },
                  ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickActionCard(
                      context,
                      "View History",
                      Icons.history,
                      AppColors.secondary,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MedicineHistoryScreen()),
                        );
                      },
                    ),
                    _buildQuickActionCard(
                      context,
                      "Settings",
                      Icons.settings,
                      AppColors.statusDue,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsScreen()),
                        );
                      },
                    ),
                    _buildQuickActionCard(
                      context,
                      "Emergency",
                      Icons.warning,
                      AppColors.statusMissed,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmergencySosScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineCardToday extends StatelessWidget {
  final MedicineModel medicine;

  const MedicineCardToday({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeParts = medicine.time.split(' ');
    final timeStr = timeParts[0];
    final period = timeParts[1];
    final timeFormat = DateFormat('hh:mm');
    final parsedTime = timeFormat.parse(timeStr);
    final scheduledTime = DateTime(now.year, now.month, now.day,
        parsedTime.hour + (period == 'PM' ? 12 : 0), parsedTime.minute);

    String status;
    Color cardColor;
    Color buttonColor;
    String buttonText;

    if (medicine.isTaken) {
      status = 'Taken';
      cardColor = Colors.green.shade50;
      buttonColor = Colors.green;
      buttonText = 'TAKEN';
    } else if (now.isAfter(scheduledTime)) {
      status = 'Missed';
      cardColor = Colors.red.shade50;
      buttonColor = Colors.red;
      buttonText = 'MISSED';
    } else {
      status = 'Pending';
      cardColor = Colors.white;
      buttonColor = Colors.blue;
      buttonText = 'MARK AS TAKEN';
    }

    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.medication, size: 40, color: Colors.blue),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Dosage: ${medicine.dosage}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Time: ${medicine.time}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: buttonColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: medicine.isTaken || now.isAfter(scheduledTime)
                        ? null
                        : () {
                            FirestoreService()
                                .updateMedicineStatus(medicine.id, true);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
