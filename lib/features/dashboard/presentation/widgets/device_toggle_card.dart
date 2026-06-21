import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pressable_scale.dart';

// ─── Shared Design Tokens (package-private) ───────────────────────
const kCardDark = Color(0xFF1A1E17);
const kCardMuted = Color(0xFF9E9E8E);
const kCardSurface = Color(0xFFF2F3ED);

/// A full card toggle with explosive ripple + icon bounce + glow animations.
class DeviceToggleCard extends StatefulWidget {
  const DeviceToggleCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isOn,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isOn;
  final Color color;
  final VoidCallback onTap;

  @override
  State<DeviceToggleCard> createState() => _DeviceToggleCardState();
}

class _DeviceToggleCardState extends State<DeviceToggleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _ripple;
  late Animation<double> _iconScale;
  late Animation<double> _glowOpacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _ripple = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _ctrl, curve: const Interval(0, 0.65, curve: Curves.easeOut)),
    );

    _iconScale = TweenSequence([
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 1.35), weight: 25),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.35, end: 0.90), weight: 30),
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.90, end: 1.05), weight: 25),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.05, end: 1.0), weight: 20),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _glowOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _ctrl, curve: const Interval(0.4, 1.0, curve: Curves.easeOut)),
    );

    // Start at correct position without animation
    if (widget.isOn) _ctrl.value = 1.0;
  }

  @override
  void didUpdateWidget(DeviceToggleCard old) {
    super.didUpdateWidget(old);
    if (widget.isOn != old.isOn) {
      if (widget.isOn) {
        _ctrl.forward(from: 0);
      } else {
        _ctrl.reverse(from: 1);
      }
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          final t = _ctrl.value;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: widget.isOn ? kCardDark : Colors.white,
              borderRadius: BorderRadius.circular(22.r),
              boxShadow: [
                BoxShadow(
                  color: widget.isOn
                      ? widget.color.withValues(alpha: 0.28 * t)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: 22 * t,
                  spreadRadius: 2 * t,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // ── Explosive ripple fill ──────────────────────────
                Positioned.fill(
                  child: CustomPaint(
                    painter: _RipplePainter(
                      color: widget.color,
                      progress: _ripple.value,
                    ),
                  ),
                ),

                // ── Content ────────────────────────────────────────
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Icon with glow ring
                        Transform.scale(
                          scale: _iconScale.value,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Glow ring behind icon
                              if (t > 0)
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 36.w + (8.0 * _glowOpacity.value).w,
                                  height: 36.w + (8.0 * _glowOpacity.value).w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.color
                                        .withValues(alpha: 0.18 * _glowOpacity.value),
                                  ),
                                ),
                              Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: BoxDecoration(
                                  color: widget.isOn
                                      ? widget.color.withValues(alpha: 0.20)
                                      : kCardSurface,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  widget.icon,
                                  color: widget.isOn ? widget.color : kCardMuted,
                                  size: 17.sp,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Mini toggle switch
                        _SmallToggle(
                          isOn: widget.isOn,
                          color: widget.color,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          style: GoogleFonts.urbanist(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: widget.isOn ? Colors.white : kCardDark,
                          ),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: GoogleFonts.urbanist(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: widget.isOn ? widget.color : kCardMuted,
                          ),
                          child: Text(widget.isOn ? 'Active' : 'Off'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─── Ripple Painter ───────────────────────────────────────────────
class _RipplePainter extends CustomPainter {
  final Color color;
  final double progress; // 0..1

  const _RipplePainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    // Max radius that covers the entire card diagonally
    final maxR = size.width * 1.6;
    final r = maxR * progress;

    // Opacity: ramps up quickly then fades out
    final opacity = progress < 0.4
        ? (progress / 0.4) * 0.25
        : (1 - (progress - 0.4) / 0.6) * 0.25;

    final paint = Paint()
      ..color = color.withValues(alpha: opacity.clamp(0, 1))
      ..style = PaintingStyle.fill;

    // Originate from bottom-right (where toggle switch lives)
    canvas.drawCircle(Offset(size.width, size.height), r, paint);

    // Secondary smaller ripple ring
    if (progress > 0.15) {
      final r2 = maxR * (progress - 0.15).clamp(0, 0.85);
      final o2 = (opacity * 0.5).clamp(0.0, 0.15);
      canvas.drawCircle(
        Offset(size.width, size.height),
        r2,
        Paint()
          ..color = color.withValues(alpha: o2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(_RipplePainter old) => old.progress != progress;
}

// ─── Mini Toggle Switch inside the card ───────────────────────────
class _SmallToggle extends StatelessWidget {
  const _SmallToggle({required this.isOn, required this.color});

  final bool isOn;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      width: 36.w,
      height: 20.h,
      padding: EdgeInsets.all(2.5.w),
      decoration: BoxDecoration(
        color: isOn ? color.withValues(alpha: 0.85) : kCardSurface,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: isOn
            ? [BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 8, offset: const Offset(0, 2))]
            : [],
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 350),
        curve: Curves.elasticOut,
        alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 15.w,
          height: 15.w,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
