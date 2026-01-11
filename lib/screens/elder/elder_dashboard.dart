import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../providers/medicine_provider.dart';
import '../../widgets/medicine_progress_ring.dart';
import '../../widgets/medicine_timeline.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/mode_switcher_button.dart';
import '../../core/utils/toast_notification.dart';
import '../../services/firestore_service.dart';

class ElderDashboard extends StatefulWidget {
  const ElderDashboard({super.key});

  @override
  State<ElderDashboard> createState() => _ElderDashboardState();
}

class _ElderDashboardState extends State<ElderDashboard> {
  @override
  void initState() {
    super.initState();
    // Start listening to the medicine list immediately
    Provider.of<MedicineProvider>(context, listen: false).fetchMedicines();
  }

  @override
  Widget build(BuildContext context) {
    final medProvider = Provider.of<MedicineProvider>(context);
    final today = DateFormat('EEEE').format(DateTime.now()); // e.g., "Monday"

    // Filter medicines for today
    final todaysMedicines =
        medProvider.medicines.where((med) => med.days.contains(today)).toList();

    // Count completed medicines
    final completedCount = todaysMedicines.where((med) => med.isTaken).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Medicines Today",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          ModeSwitcherButton(isCompact: true),
        ],
      ),
      body: todaysMedicines.isEmpty
          ? EmptyStates.noMedicines()
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Progress Ring Section
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: MedicineProgressRing(
                      totalMedicines: todaysMedicines.length,
                      completedMedicines: completedCount,
                    ),
                  ),
                  // Timeline Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Today\'s Schedule',
                          style: AppTypography.headlineSmall().copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${todaysMedicines.length} medicines',
                          style: AppTypography.bodyMedium().copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Timeline View
                  SizedBox(
                    height: todaysMedicines.length * 140,
                    child: MedicineTimeline(
                      medicines: todaysMedicines,
                      onMedicineTap: (medicine) {
                        HapticFeedback.heavyImpact();
                        FirestoreService().updateMedicineStatus(
                            medicine.id, !medicine.isTaken);
                        ToastNotification.success(
                          context,
                          medicine.isTaken
                              ? 'Medicine marked as pending'
                              : 'Great! Medicine marked as taken',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
