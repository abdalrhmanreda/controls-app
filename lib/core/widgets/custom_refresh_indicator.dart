import 'dart:math' as math;
import 'package:control_app/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyRefreshIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const MyRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<MyRefreshIndicator> createState() => _MyRefreshIndicatorState();
}

class _MyRefreshIndicatorState extends State<MyRefreshIndicator>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _readyController;

  double _dragOffset = 0.0;
  bool _isRefreshing = false;
  bool _isDragging = false;
  double _startY = 0.0;

  static const double _maxDragOffset = 120.0;
  static const double _triggerOffset = 80.0;

  // We use NotificationListener to get the child's scroll position
  ScrollMetrics? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _readyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _readyController.dispose();
    super.dispose();
  }

  bool get _isAtTop {
    if (_scrollPosition == null) return true;
    return _scrollPosition!.pixels <= 0.0;
  }

  void _onPointerDown(PointerDownEvent event) {
    if (_isRefreshing) return;
    _startY = event.position.dy;
    _isDragging = false;
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_isRefreshing) return;

    final dy = event.position.dy - _startY;

    if (dy > 0 && _isAtTop) {
      // User is pulling down while scroll is at the top
      if (!_isDragging) {
        _isDragging = true;
        _startY = event.position.dy; // Reset start to avoid a jump
      }

      final rawOffset = event.position.dy - _startY;
      double frictionOffset = rawOffset;
      if (rawOffset > _triggerOffset) {
        frictionOffset = _triggerOffset + (rawOffset - _triggerOffset) * 0.35;
      }

      setState(() {
        _dragOffset = frictionOffset.clamp(0.0, _maxDragOffset);
      });

      if (_dragOffset >= _triggerOffset) {
        _readyController.forward();
      } else {
        _readyController.reverse();
      }
    } else if (_isDragging && dy <= 0) {
      // User pushed back up while our indicator was showing
      setState(() {
        _dragOffset = 0.0;
      });
      _readyController.reverse();
      _isDragging = false;
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    if (_isRefreshing) return;

    if (_isDragging && _dragOffset >= _triggerOffset) {
      _handleRefresh();
    } else if (_isDragging) {
      _animateReset();
    }
    _isDragging = false;
  }

  void _animateReset() {
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    final start = _dragOffset;
    controller.addListener(() {
      if (mounted) {
        setState(() {
          _dragOffset = start * (1.0 - controller.value);
        });
      }
    });
    controller.forward().then((_) => controller.dispose());
    _readyController.reverse();
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    _rotationController.repeat();
    setState(() {
      _isRefreshing = true;
      _dragOffset = _triggerOffset;
    });

    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        _rotationController.stop();
        _readyController.reverse();
        setState(() => _isRefreshing = false);

        final controller = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 650),
        );
        final animation = CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
        );

        final double startOffset = _dragOffset;
        animation.addListener(() {
          if (mounted) {
            setState(() {
              _dragOffset = startOffset * (1.0 - animation.value);
            });
          }
        });

        await controller.forward();
        controller.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _scrollPosition = notification.metrics;
        return false; // let the notification bubble up
      },
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerMove: _onPointerMove,
        onPointerUp: _onPointerUp,
        child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. The scrollable content — translate down by drag amount
          Transform.translate(
            offset: Offset(0, _dragOffset),
            child: widget.child,
          ),

          // 2. The animated indicator
          if (_dragOffset > 0 || _isRefreshing)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: _dragOffset,
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _rotationController,
                  _pulseController,
                  _readyController,
                ]),
                builder: (context, _) {
                  final progress = (_dragOffset / _triggerOffset).clamp(
                    0.0,
                    1.0,
                  );
                  final scaleValue = Curves.easeOutBack.transform(
                    _readyController.value.clamp(0.0, 1.0),
                  );

                  return Center(
                    child: Opacity(
                      opacity: Curves.easeIn.transform(progress),
                      child: Transform.scale(
                        scale: (0.55 + 0.45 * scaleValue).clamp(0.0, 1.15),
                        child: _IndicatorCard(
                          child: CustomPaint(
                            size: Size(58.w, 58.w),
                            painter: _ParkingRefreshPainter(
                              progress: _isRefreshing ? 1.0 : progress,
                              rotation: _rotationController.value,
                              pulse: _pulseController.value,
                              isRefreshing: _isRefreshing,
                              isReady: _readyController.value > 0.5,
                              readyProgress: _readyController.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    ),
  );
}
}

class _IndicatorCard extends StatelessWidget {
  final Widget child;
  const _IndicatorCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimaryColor.withValues(alpha: 0.12),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ParkingRefreshPainter extends CustomPainter {
  final double progress;
  final double rotation;
  final double pulse;
  final bool isRefreshing;
  final bool isReady;
  final double readyProgress;

  static const int _trailDots = 3;

  const _ParkingRefreshPainter({
    required this.progress,
    required this.rotation,
    required this.pulse,
    required this.isRefreshing,
    required this.isReady,
    required this.readyProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final activeColor = AppColors.kPrimaryColor;
    final idleColor = AppColors.kGreyColor;
    final color = (isReady || isRefreshing) ? activeColor : idleColor;

    // 1. Pulsing outer glow when active
    if (isReady || isRefreshing) {
      final glowPaint = Paint()
        ..color = activeColor.withValues(alpha: 0.08 + 0.10 * pulse)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
      canvas.drawCircle(center, radius * (0.9 + 0.12 * pulse), glowPaint);
    }

    // 2. Subtle background fill
    final bgPaint = Paint()
      ..color = (isReady || isRefreshing)
          ? activeColor.withValues(alpha: 0.07 + 0.05 * readyProgress)
          : idleColor.withValues(alpha: 0.06);
    canvas.drawCircle(center, radius * 0.88, bgPaint);

    // 3. Track ring
    final trackPaint = Paint()
      ..color = color.withValues(alpha: (isReady || isRefreshing) ? 0.22 : 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8;
    canvas.drawCircle(center, radius * 0.74, trackPaint);

    // 4. Progress / spinner arc
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round;

    if (isRefreshing) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(rotation * 2 * math.pi);

      // Faded trail arc
      canvas.drawArc(
        Rect.fromCircle(center: Offset.zero, radius: radius * 0.74),
        -math.pi / 2,
        math.pi * 1.5,
        false,
        Paint()
          ..color = activeColor.withValues(alpha: 0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.2
          ..strokeCap = StrokeCap.round,
      );

      // Bright leading arc
      canvas.drawArc(
        Rect.fromCircle(center: Offset.zero, radius: radius * 0.74),
        -math.pi / 2,
        math.pi * 0.7,
        false,
        arcPaint,
      );
      canvas.restore();
    } else {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.74),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        arcPaint,
      );
    }

    final innerFill = Paint()
      ..color = (isReady || isRefreshing)
          ? activeColor.withValues(alpha: 0.10 + 0.06 * readyProgress)
          : idleColor.withValues(alpha: 0.06);
    canvas.drawCircle(center, radius * 0.44, innerFill);

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'P',
        style: TextStyle(
          color: color,
          fontSize: 20.sp,
          fontWeight: FontWeight.w900,
          fontFamily: 'Inter',
          letterSpacing: -0.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );

    // 6. Orbiting trail dots when refreshing
    if (isRefreshing) {
      for (int i = 0; i < _trailDots; i++) {
        final angle =
            (rotation * 2 * math.pi) - (i * math.pi * 0.28) - math.pi / 2;
        final orbitRadius = radius * 0.74;
        final dotPos = Offset(
          center.dx + orbitRadius * math.cos(angle),
          center.dy + orbitRadius * math.sin(angle),
        );
        final opacity = (1.0 - i * 0.32).clamp(0.0, 1.0);
        final dotRadius = (4.0 - i * 0.8).clamp(1.5, 4.5);

        canvas.drawCircle(
          dotPos,
          dotRadius,
          Paint()
            ..color = AppColors.kWhiteColor.withValues(alpha: opacity)
            ..style = PaintingStyle.fill,
        );
        canvas.drawCircle(
          dotPos,
          dotRadius,
          Paint()
            ..color = activeColor.withValues(alpha: opacity)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.4,
        );
      }
    }

    // 7. Pull arrow below "P" — flips upward when ready to release
    if (!isRefreshing && progress > 0.15) {
      _drawArrow(canvas, center, radius, color, progress);
    }
  }

  void _drawArrow(
    Canvas canvas,
    Offset center,
    double radius,
    Color color,
    double progress,
  ) {
    final arrowCenter = center + Offset(0, radius * 0.60);
    final flipAngle = math.pi * readyProgress;
    final arrowSize = radius * 0.19;

    canvas.save();
    canvas.translate(arrowCenter.dx, arrowCenter.dy);
    canvas.rotate(flipAngle);

    final path = Path()
      ..moveTo(-arrowSize, -arrowSize * 0.45)
      ..lineTo(0, arrowSize * 0.55)
      ..lineTo(arrowSize, -arrowSize * 0.45);

    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: 0.75 * progress)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ParkingRefreshPainter old) => true;
}
