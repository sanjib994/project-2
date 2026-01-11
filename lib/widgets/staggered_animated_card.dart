import 'package:flutter/material.dart';

/// Animated card with staggered entrance animation
class StaggeredAnimatedCard extends StatefulWidget {
  final Widget child;
  final int delayIndex;
  final Duration delayBetweenCards;
  final Duration animationDuration;
  final Curve curve;

  const StaggeredAnimatedCard({
    super.key,
    required this.child,
    required this.delayIndex,
    this.delayBetweenCards = const Duration(milliseconds: 100),
    this.animationDuration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<StaggeredAnimatedCard> createState() => _StaggeredAnimatedCardState();
}

class _StaggeredAnimatedCardState extends State<StaggeredAnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Calculate delay for this card
    final delay = widget.delayIndex * widget.delayBetweenCards.inMilliseconds;

    // Slide animation - from bottom
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          delay / widget.animationDuration.inMilliseconds,
          (delay + widget.animationDuration.inMilliseconds) /
              widget.animationDuration.inMilliseconds,
          curve: widget.curve,
        ),
      ),
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          delay / widget.animationDuration.inMilliseconds,
          (delay + widget.animationDuration.inMilliseconds) /
              widget.animationDuration.inMilliseconds,
          curve: widget.curve,
        ),
      ),
    );

    // Scale animation - slight grow effect
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          delay / widget.animationDuration.inMilliseconds,
          (delay + widget.animationDuration.inMilliseconds) /
              widget.animationDuration.inMilliseconds,
          curve: widget.curve,
        ),
      ),
    );

    // Start animation after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Batch animated cards builder for lists
class StaggeredAnimatedList extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int delayBetweenCards;
  final int animationDuration;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const StaggeredAnimatedList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.delayBetweenCards = 100,
    this.animationDuration = 600,
    this.physics,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return StaggeredAnimatedCard(
          delayIndex: index,
          delayBetweenCards: Duration(milliseconds: delayBetweenCards),
          animationDuration: Duration(milliseconds: animationDuration),
          child: itemBuilder(context, index),
        );
      },
    );
  }
}

/// Fade in animation for immediate elements
class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeIn,
  });

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
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
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
