import 'package:flutter/material.dart';

/// Custom Page Transitions
class PageTransitions {
  /// Smooth fade transition
  static Route<T> fadeTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// Slide from right transition
  static Route<T> slideRightTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// Slide from left transition
  static Route<T> slideLeftTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// Slide from bottom transition
  static Route<T> slideUpTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// Scale transition with fade
  static Route<T> scaleTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        final tween = Tween(begin: begin, end: end);
        final scaleAnimation = animation.drive(tween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  /// Bounce transition
  static Route<T> bounceTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        final curve = Curves.elasticOut;
        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        final scaleAnimation = animation.drive(tween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
    );
  }

  /// Combined slide and fade transition
  static Route<T> slideAndFadeTransition<T>(
    Widget page, {
    bool fromRight = true,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin =
            fromRight ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}

/// Extension to easily use transitions with Navigator
extension NavigationExtension on BuildContext {
  Future<T?> pushWithFadeTransition<T>(Widget page) {
    return Navigator.of(this).push(PageTransitions.fadeTransition<T>(page));
  }

  Future<T?> pushWithSlideRightTransition<T>(Widget page) {
    return Navigator.of(this)
        .push(PageTransitions.slideRightTransition<T>(page));
  }

  Future<T?> pushWithSlideLeftTransition<T>(Widget page) {
    return Navigator.of(this)
        .push(PageTransitions.slideLeftTransition<T>(page));
  }

  Future<T?> pushWithSlideUpTransition<T>(Widget page) {
    return Navigator.of(this).push(PageTransitions.slideUpTransition<T>(page));
  }

  Future<T?> pushWithScaleTransition<T>(Widget page) {
    return Navigator.of(this).push(PageTransitions.scaleTransition<T>(page));
  }

  Future<T?> pushWithBounceTransition<T>(Widget page) {
    return Navigator.of(this).push(PageTransitions.bounceTransition<T>(page));
  }

  Future<T?> pushWithSlideAndFadeTransition<T>(Widget page,
      {bool fromRight = true}) {
    return Navigator.of(this).push(
      PageTransitions.slideAndFadeTransition<T>(page, fromRight: fromRight),
    );
  }
}
