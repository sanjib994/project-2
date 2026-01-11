import 'package:flutter/material.dart';
import 'dart:math';
import '../core/theme/app_colors.dart';

/// Animated check mark for status changes
class AnimatedCheckmark extends StatefulWidget {
  final Duration duration;
  final double size;
  final Color color;

  const AnimatedCheckmark({
    super.key,
    this.duration = const Duration(milliseconds: 600),
    this.size = 48,
    this.color = AppColors.statusTaken,
  });

  @override
  State<AnimatedCheckmark> createState() => _AnimatedCheckmarkState();
}

class _AnimatedCheckmarkState extends State<AnimatedCheckmark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Icon(
          Icons.check_circle,
          size: widget.size,
          color: widget.color,
        ),
      ),
    );
  }
}

/// Animated ripple effect for status changes
class RippleAnimation extends StatefulWidget {
  final Duration duration;
  final Color color;
  final double size;

  const RippleAnimation({
    super.key,
    this.duration = const Duration(milliseconds: 800),
    this.color = AppColors.statusTaken,
    this.size = 80,
  });

  @override
  State<RippleAnimation> createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _radiusAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _radiusAnimation = Tween<double>(begin: 0, end: widget.size / 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.5, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: _radiusAnimation.value * 2,
            height: _radiusAnimation.value * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withOpacity(_opacityAnimation.value),
              border: Border.all(
                color: widget.color.withOpacity(_opacityAnimation.value * 0.5),
                width: 2,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Status badge flip animation
class StatusBadgeFlip extends StatefulWidget {
  final bool isTaken;
  final Duration duration;

  const StatusBadgeFlip({
    super.key,
    required this.isTaken,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<StatusBadgeFlip> createState() => _StatusBadgeFlipState();
}

class _StatusBadgeFlipState extends State<StatusBadgeFlip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(StatusBadgeFlip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isTaken != widget.isTaken) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        final angle = _rotationAnimation.value * 3.14159;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: widget.isTaken
                  ? AppColors.statusTaken
                  : AppColors.statusPending,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.isTaken ? 'TAKEN' : 'PENDING',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Shake animation for errors
class ShakeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ShakeAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<ShakeAnimation> createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _offsetAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticIn));

    // Shake effect
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
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
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        // Create shake effect
        final shakes = 6;
        final progress = _controller.value;
        final shake =
            sin(progress * shakes * 3.14159 * 2) * (1 - progress) * 0.01;

        return Transform.translate(
          offset: Offset(shake, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
