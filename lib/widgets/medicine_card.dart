import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/medicine_model.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/helpers/medicine_category_helper.dart';

class MedicineCard extends StatefulWidget {
  final MedicineModel medicine;
  final VoidCallback onTap;
  final Function(MedicineModel)? onSwipe;

  const MedicineCard({
    super.key,
    required this.medicine,
    required this.onTap,
    this.onSwipe,
  });

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  late Offset _dragStartPosition;
  late MedicineCategory _category;

  @override
  void initState() {
    super.initState();
    _category =
        MedicineCategoryHelper.getCategoryFromName(widget.medicine.name);
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    _dragStartPosition = details.globalPosition;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    const swipeThreshold = 100.0;
    final swipeDistance = details.globalPosition.dx - _dragStartPosition.dx;

    // Swipe right to mark as taken
    if (swipeDistance > swipeThreshold && !widget.medicine.isTaken) {
      widget.onSwipe?.call(widget.medicine) ?? widget.onTap();
      // Haptic feedback
      HapticFeedback.mediumImpact();
    }
  }

  /// Calculate days until refill
  String _getDaysUntilRefill() {
    if (widget.medicine.refillDate == null) return '';
    final now = DateTime.now();
    final difference = widget.medicine.refillDate!.difference(now).inDays;

    if (difference < 0) {
      return 'Refill needed!';
    } else if (difference == 0) {
      return 'Refill today';
    } else if (difference == 1) {
      return 'Refill tomorrow';
    } else {
      return 'Refill in $difference days';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = widget.medicine.isTaken
        ? AppColors.statusTaken
        : AppColors.statusPending;
    final cardBackgroundColor = widget.medicine.isTaken
        ? AppColors.statusTaken.withOpacity(0.1)
        : AppColors.statusPending.withOpacity(0.05);

    final categoryIcon = MedicineCategoryHelper.getCategoryIcon(_category);
    final categoryColor = MedicineCategoryHelper.getCategoryColor(_category);
    final hasRefillInfo = widget.medicine.refillDate != null;
    final refillWarning = hasRefillInfo &&
        widget.medicine.refillDate!.difference(DateTime.now()).inDays <= 3;

    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: statusColor.withOpacity(0.3),
            width: 2,
          ),
        ),
        color: cardBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: Icon, Medicine info, Status Badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category icon with gradient background
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          categoryColor.withOpacity(0.3),
                          categoryColor.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: categoryColor.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          categoryIcon,
                          size: 32,
                          color: categoryColor,
                        ),
                        // Checkmark overlay if taken
                        if (widget.medicine.isTaken)
                          Positioned(
                            bottom: -4,
                            right: -4,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.statusTaken,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 14,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Medicine info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Medicine name with category
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.medicine.name,
                                style: AppTypography.medicineName().copyWith(
                                  color: AppColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Dosage
                        Text(
                          'Dosage: ${widget.medicine.dosage}',
                          style: AppTypography.medicineInfo().copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Time
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.medicine.time,
                              style: AppTypography.bodySmall().copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Status Badge Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Main status badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.medicine.isTaken ? 'TAKEN' : 'PENDING',
                          style: AppTypography.statusBadge().copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      // Category label badge
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: categoryColor.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          MedicineCategoryHelper.getCategoryName(_category),
                          style: AppTypography.labelSmall().copyWith(
                            color: categoryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Remaining doses and refill info
              if (widget.medicine.remainingDoses != null ||
                  widget.medicine.refillDate != null)
                Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: refillWarning
                            ? AppColors.statusDue.withOpacity(0.1)
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: refillWarning
                              ? AppColors.statusDue.withOpacity(0.3)
                              : AppColors.divider,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Remaining doses
                          if (widget.medicine.remainingDoses != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.inventory_2,
                                  size: 16,
                                  color: widget.medicine.remainingDoses! <= 5
                                      ? AppColors.statusMissed
                                      : AppColors.textSecondary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${widget.medicine.remainingDoses} doses left',
                                  style: AppTypography.bodySmall().copyWith(
                                    color: widget.medicine.remainingDoses! <= 5
                                        ? AppColors.statusMissed
                                        : AppColors.textSecondary,
                                    fontWeight:
                                        widget.medicine.remainingDoses! <= 5
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          // Refill countdown
                          if (widget.medicine.refillDate != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: refillWarning
                                      ? AppColors.statusDue
                                      : AppColors.textSecondary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _getDaysUntilRefill(),
                                  style: AppTypography.bodySmall().copyWith(
                                    color: refillWarning
                                        ? AppColors.statusDue
                                        : AppColors.textSecondary,
                                    fontWeight: refillWarning
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              // Action button
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: widget.onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: statusColor,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.medicine.isTaken)
                        const Icon(Icons.check_circle, size: 20),
                      if (!widget.medicine.isTaken)
                        const Icon(Icons.add_circle, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        widget.medicine.isTaken
                            ? 'MARK AS NOT TAKEN'
                            : 'MARK AS TAKEN',
                        style: AppTypography.buttonText().copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Swipe hint for untaken medicines
              if (!widget.medicine.isTaken)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      '← Swipe right to mark taken',
                      style: AppTypography.caption().copyWith(
                        color: AppColors.textLight,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
