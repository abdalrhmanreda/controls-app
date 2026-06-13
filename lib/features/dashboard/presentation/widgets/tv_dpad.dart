import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TvDpad extends StatefulWidget {
  final ValueChanged<String> onDirectionPressed;

  const TvDpad({super.key, required this.onDirectionPressed});

  @override
  State<TvDpad> createState() => _TvDpadState();
}

class _TvDpadState extends State<TvDpad> with SingleTickerProviderStateMixin {
  String? _pressedDirection;
  late AnimationController _rippleCtrl;

  @override
  void initState() {
    super.initState();
    _rippleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _rippleCtrl.dispose();
    super.dispose();
  }

  void _handleTap(String direction) {
    setState(() => _pressedDirection = direction);
    _rippleCtrl.forward().then((_) {
      _rippleCtrl.reverse().then((_) {
        if (mounted) setState(() => _pressedDirection = null);
      });
    });
    widget.onDirectionPressed(direction);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer dotted background circle
        GestureDetector(
          onTapDown: (details) {
            final double size = 165.w;
            final double centerX = size / 2;
            final double centerY = size / 2;
            final double localX = details.localPosition.dx - centerX;
            final double localY = details.localPosition.dy - centerY;

            // Ignore taps too close to center (OK button area)
            if ((localX * localX + localY * localY) < (22.w * 22.w)) return;

            if (localY.abs() > localX.abs()) {
              _handleTap(localY < 0 ? 'UP' : 'DOWN');
            } else {
              _handleTap(localX < 0 ? 'LEFT' : 'RIGHT');
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 165.w,
            height: 165.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEDEEE8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CustomPaint(
              painter: _DotPatternPainter(),
            ),
          ),
        ),

        // UP arrow dot
        Positioned(
          top: 12.h,
          child: _directionDot('UP'),
        ),
        // DOWN arrow dot
        Positioned(
          bottom: 12.h,
          child: _directionDot('DOWN'),
        ),
        // LEFT arrow dot
        Positioned(
          left: 12.w,
          child: _directionDot('LEFT'),
        ),
        // RIGHT arrow dot
        Positioned(
          right: 12.w,
          child: _directionDot('RIGHT'),
        ),

        // Center OK button
        GestureDetector(
          onTap: () => _handleTap('OK'),
          child: AnimatedScale(
            scale: _pressedDirection == 'OK' ? 0.88 : 1.0,
            duration: const Duration(milliseconds: 150),
            child: Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _directionDot(String dir) {
    final isPressed = _pressedDirection == dir;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: isPressed ? 9.w : 6.w,
      height: isPressed ? 9.w : 6.w,
      decoration: BoxDecoration(
        color: isPressed
            ? Colors.white.withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.70),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.50)
      ..style = PaintingStyle.fill;

    const double spacing = 9.5;
    final double radius = size.width / 2;
    final Offset center = Offset(radius, size.height / 2);

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        final Offset pt = Offset(x, y);
        if ((pt - center).distance < radius - 8) {
          canvas.drawCircle(pt, 1.4, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
