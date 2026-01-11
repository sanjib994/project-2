import 'package:flutter/material.dart';
import '../core/theme/app_typography.dart';

class AnimatedActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  final Offset offset;
  final Animation<double> animation;

  const AnimatedActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    required this.offset,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset * (1 - animation.value),
      child: ScaleTransition(
        scale: animation,
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          heroTag: label,
          elevation: 6,
          mini: true,
          child: Icon(icon),
        ),
      ),
    );
  }
}

class ExpandableFAB extends StatefulWidget {
  final List<ExpandableFABAction> actions;
  final Color primaryColor;
  final Color? backgroundColor;
  final double distance;

  const ExpandableFAB({
    super.key,
    required this.actions,
    required this.primaryColor,
    this.backgroundColor,
    this.distance = 120.0,
  });

  @override
  State<ExpandableFAB> createState() => _ExpandableFABState();
}

class ExpandableFABAction {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  ExpandableFABAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
  });
}

class _ExpandableFABState extends State<ExpandableFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFAB() {
    if (_isOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Dimmed background when expanded
        if (_isOpen)
          GestureDetector(
            onTap: _toggleFAB,
            child: ScaleTransition(
              scale: _animation,
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        // Action buttons
        ...List.generate(
          widget.actions.length,
          (index) {
            final action = widget.actions[index];
            final dx = widget.distance * -0.7 * index.toDouble();
            final dy = widget.distance * -0.5;

            return AnimatedActionButton(
              icon: action.icon,
              label: action.label,
              backgroundColor:
                  action.color ?? widget.primaryColor.withOpacity(0.9),
              foregroundColor: Colors.white,
              onPressed: () {
                _toggleFAB();
                Future.delayed(const Duration(milliseconds: 200), () {
                  action.onPressed();
                });
              },
              offset: Offset(dx, dy),
              animation: _animation,
            );
          },
        ),
        // Primary FAB
        FloatingActionButton(
          onPressed: _toggleFAB,
          backgroundColor: widget.primaryColor,
          foregroundColor: Colors.white,
          elevation: 8,
          heroTag: 'expandable_fab',
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animation,
          ),
        ),
      ],
    );
  }
}

class SimpleFABAction {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  SimpleFABAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
  });
}

/// Floating action button with label visible on hover/near the button
class LabeledFAB extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  const LabeledFAB({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    this.foregroundColor = Colors.white,
  });

  @override
  State<LabeledFAB> createState() => _LabeledFABState();
}

class _LabeledFABState extends State<LabeledFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _animationController.forward(),
      onExit: (_) => _animationController.reverse(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: widget.backgroundColor.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  widget.label,
                  style: AppTypography.labelSmall().copyWith(
                    color: widget.foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: widget.onPressed,
            backgroundColor: widget.backgroundColor,
            foregroundColor: widget.foregroundColor,
            elevation: 8,
            child: Icon(widget.icon),
          ),
        ],
      ),
    );
  }
}
