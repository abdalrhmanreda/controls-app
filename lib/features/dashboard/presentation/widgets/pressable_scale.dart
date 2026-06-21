import 'package:flutter/material.dart';
import 'bounce_tap.dart';

/// Wraps any widget with a tactile "press" feel using BounceTap.
class PressableScale extends StatelessWidget {
  const PressableScale({
    super.key,
    required this.child,
    this.onTap,
    this.pressedScale = 0.95,
    this.duration = const Duration(milliseconds: 130),
  });

  final Widget child;
  final VoidCallback? onTap;
  final double pressedScale;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap,
      beginScale: pressedScale,
      duration: duration,
      child: child,
    );
  }
}

