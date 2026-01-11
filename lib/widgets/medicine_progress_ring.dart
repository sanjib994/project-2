import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

/// Progress Ring Widget displaying daily medicine completion percentage
class MedicineProgressRing extends StatefulWidget {
  final int totalMedicines;
  final int completedMedicines;
  final Duration animationDuration;

  const MedicineProgressRing({
    super.key,
    required this.totalMedicines,
    required this.completedMedicines,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  State<MedicineProgressRing> createState() => _MedicineProgressRingState();
}

class _MedicineProgressRingState extends State<MedicineProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.totalMedicines > 0
          ? widget.completedMedicines / widget.totalMedicines
          : 0,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCubic));

    _animationController.forward();
  }

  @override
  void didUpdateWidget(MedicineProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.completedMedicines != widget.completedMedicines) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.totalMedicines > 0
            ? widget.completedMedicines / widget.totalMedicines
            : 0,
      ).animate(CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOutCubic));

      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = widget.totalMedicines > 0
        ? (widget.completedMedicines / widget.totalMedicines * 100)
            .toStringAsFixed(0)
        : '0';

    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background circle
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.secondary.withOpacity(0.1),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
            // Animated progress ring
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ProgressRingPainter(
                    progress: _animation.value,
                    backgroundColor: AppColors.divider,
                    progressColor: _animation.value >= 1.0
                        ? AppColors.statusTaken
                        : AppColors.secondary,
                  ),
                  size: const Size(200, 200),
                );
              },
            ),
            // Center content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$percentage%',
                  style: AppTypography.displayMedium().copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Completed',
                  style: AppTypography.bodyMedium().copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${widget.completedMedicines}/${widget.totalMedicines}',
                  style: AppTypography.titleMedium().copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
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

/// Custom painter for the progress ring
class ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth = 12;

  ProgressRingPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);

    // Background ring
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = backgroundColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // Progress ring with gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      colors: [
        progressColor.withOpacity(0.6),
        progressColor,
        progressColor.withOpacity(0.8),
      ],
      startAngle: -1.57, // Start from top
    );

    canvas.drawArc(
      rect,
      -1.57, // Start from top
      (progress * 2 * 3.141592653589793), // Full circle based on progress
      false,
      Paint()
        ..shader = gradient.createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
