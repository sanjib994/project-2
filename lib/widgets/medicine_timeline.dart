import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/medicine_model.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

/// Timeline View for medicine schedules
class MedicineTimeline extends StatelessWidget {
  final List<MedicineModel> medicines;
  final Function(MedicineModel) onMedicineTap;

  const MedicineTimeline({
    super.key,
    required this.medicines,
    required this.onMedicineTap,
  });

  /// Parse time string and return DateTime for sorting
  DateTime _parseTime(String timeStr) {
    try {
      final format = DateFormat('hh:mm a');
      final dateTime = format.parse(timeStr);
      return dateTime;
    } catch (e) {
      return DateTime(2000, 1, 1, 0, 0);
    }
  }

  /// Get status color and icon
  _TimelineItemStatus _getItemStatus(MedicineModel medicine) {
    if (medicine.isTaken) {
      return _TimelineItemStatus(
        color: AppColors.statusTaken,
        icon: Icons.check_circle,
        label: 'Taken',
      );
    }

    final now = DateTime.now();
    final medicineTime = _parseTime(medicine.time);
    final currentTime =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    final medicineDateTime = DateTime(
        now.year, now.month, now.day, medicineTime.hour, medicineTime.minute);

    if (medicineDateTime.isBefore(currentTime)) {
      return _TimelineItemStatus(
        color: AppColors.statusMissed,
        icon: Icons.cancel,
        label: 'Missed',
      );
    } else if (medicineDateTime.difference(currentTime).inMinutes < 30) {
      return _TimelineItemStatus(
        color: AppColors.statusDue,
        icon: Icons.schedule,
        label: 'Due Soon',
      );
    } else {
      return _TimelineItemStatus(
        color: AppColors.statusPending,
        icon: Icons.access_time,
        label: 'Upcoming',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (medicines.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 64,
              color: AppColors.divider,
            ),
            const SizedBox(height: 16),
            Text(
              'No medicines scheduled',
              style: AppTypography.bodyLarge().copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    // Sort medicines by time
    final sortedMedicines = [...medicines];
    sortedMedicines
        .sort((a, b) => _parseTime(a.time).compareTo(_parseTime(b.time)));

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      itemCount: sortedMedicines.length,
      itemBuilder: (context, index) {
        final medicine = sortedMedicines[index];
        final status = _getItemStatus(medicine);
        final isLast = index == sortedMedicines.length - 1;

        return TimelineItem(
          medicine: medicine,
          status: status,
          isLast: isLast,
          onTap: () => onMedicineTap(medicine),
        );
      },
    );
  }
}

/// Individual timeline item
class TimelineItem extends StatelessWidget {
  final MedicineModel medicine;
  final _TimelineItemStatus status;
  final bool isLast;
  final VoidCallback onTap;

  const TimelineItem({
    super.key,
    required this.medicine,
    required this.status,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timeline line and indicator
            Column(
              children: [
                // Circle indicator
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status.color.withOpacity(0.15),
                    border: Border.all(
                      color: status.color,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    status.icon,
                    color: status.color,
                    size: 24,
                  ),
                ),
                // Vertical line (hidden for last item)
                if (!isLast)
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 3,
                        color: AppColors.divider,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Medicine info card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: status.color.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                medicine.name,
                                style: AppTypography.titleMedium().copyWith(
                                  color: AppColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: status.color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                status.label,
                                style: AppTypography.labelSmall().copyWith(
                                  color: status.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  medicine.time,
                                  style: AppTypography.bodySmall().copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_pharmacy,
                                  size: 16,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  medicine.dosage,
                                  style: AppTypography.bodySmall().copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper class for timeline item status
class _TimelineItemStatus {
  final Color color;
  final IconData icon;
  final String label;

  _TimelineItemStatus({
    required this.color,
    required this.icon,
    required this.label,
  });
}
