import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

/// Empty state widget with customizable icon and message
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final double? iconSize;
  final Widget? actionButton;
  final bool animated;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.iconSize = 80,
    this.actionButton,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with fade-in animation
          Icon(
            icon,
            size: iconSize,
            color: iconColor ?? AppColors.divider,
          ),
          const SizedBox(height: 24),
          // Title
          Text(
            title,
            style: AppTypography.headlineSmall().copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          // Subtitle
          if (subtitle != null) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                subtitle!,
                style: AppTypography.bodyMedium().copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          // Action button
          if (actionButton != null) ...[
            const SizedBox(height: 24),
            actionButton!,
          ],
        ],
      ),
    );

    if (animated) {
      return FadeInAnimation(child: widget);
    }
    return widget;
  }
}

/// Fade-in animation wrapper
class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fadeAnimation, child: widget.child);
  }
}

/// Predefined empty states
class EmptyStates {
  static Widget noMedicines({Widget? actionButton}) {
    return EmptyState(
      icon: Icons.calendar_today,
      title: 'No Medicines Today',
      subtitle: 'You have no medicines scheduled for today. Rest and relax!',
      iconColor: AppColors.secondary,
      actionButton: actionButton,
    );
  }

  static Widget noHistory({Widget? actionButton}) {
    return EmptyState(
      icon: Icons.history,
      title: 'No History Yet',
      subtitle: 'Your medicine history will appear here.',
      iconColor: AppColors.secondary,
      actionButton: actionButton,
    );
  }

  static Widget error(String message, {Widget? actionButton}) {
    return EmptyState(
      icon: Icons.error_outline,
      title: 'Something Went Wrong',
      subtitle: message,
      iconColor: AppColors.statusMissed,
      actionButton: actionButton,
    );
  }

  static Widget noResults({Widget? actionButton}) {
    return EmptyState(
      icon: Icons.search_off,
      title: 'No Results Found',
      subtitle: 'Try adjusting your search criteria.',
      iconColor: AppColors.textSecondary,
      actionButton: actionButton,
    );
  }
}
