import 'package:flutter/material.dart';

/// A lightweight, self-driving entrance animation that fades + slides + scales
/// its child into view. Designed to be stacked with staggered [delay] values to
/// create a smooth cascading reveal across a screen.
class AnimatedEntrance extends StatefulWidget {
  const AnimatedEntrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 560),
    this.offset = const Offset(0, 0.14),
    this.beginScale = 0.96,
    this.curve = Curves.easeOutCubic,
  });

  final Widget child;

  /// How long to wait before this element begins animating in.
  final Duration delay;

  /// Total length of the entrance animation.
  final Duration duration;

  /// Starting translation expressed as a fraction of the child's size.
  final Offset offset;

  /// Scale the child starts at before settling to 1.0.
  final double beginScale;

  final Curve curve;

  @override
  State<AnimatedEntrance> createState() => _AnimatedEntranceState();
}

class _AnimatedEntranceState extends State<AnimatedEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _curved;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _curved = CurvedAnimation(parent: _ctrl, curve: widget.curve);

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curved,
      builder: (context, child) {
        final t = _curved.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(
              widget.offset.dx * (1 - t) * 100,
              widget.offset.dy * (1 - t) * 100,
            ),
            child: Transform.scale(
              scale: widget.beginScale + (1 - widget.beginScale) * t,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
