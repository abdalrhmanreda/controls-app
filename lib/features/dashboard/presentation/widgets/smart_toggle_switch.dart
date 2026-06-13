import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// A beautiful standalone toggle switch with:
/// - Elastic knob animation
/// - Gradient track glow when ON
/// - Ripple pulse on every toggle
class SmartToggleSwitch extends StatefulWidget {
  const SmartToggleSwitch({
    super.key,
    required this.isOn,
    required this.onChanged,
    this.activeColor = const Color(0xFFA8C37A),
    this.label,
    this.width = 52,
    this.height = 30,
  });

  final bool isOn;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final String? label;
  final double width;
  final double height;

  @override
  State<SmartToggleSwitch> createState() => _SmartToggleSwitchState();
}

class _SmartToggleSwitchState extends State<SmartToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseScale;
  late Animation<double> _pulseOpacity;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _pulseScale = Tween<double>(begin: 1.0, end: 2.2).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeOut),
    );
    _pulseOpacity = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _handleTap() {
    _pulseCtrl.forward(from: 0);
    widget.onChanged(!widget.isOn);
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.width.w;
    final h = widget.height.h;
    final knobSize = h - 8.h;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: GoogleFonts.urbanist(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1E17),
            ),
          ),
          SizedBox(width: 10.w),
        ],

        GestureDetector(
          onTap: _handleTap,
          child: AnimatedBuilder(
            animation: _pulseCtrl,
            builder: (context, _) {
              return Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Pulse ring
                  if (_pulseCtrl.value > 0)
                    Transform.scale(
                      scale: _pulseScale.value,
                      child: Container(
                        width: w,
                        height: h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular((h / 2).r),
                          border: Border.all(
                            color: widget.activeColor
                                .withValues(alpha: _pulseOpacity.value),
                            width: 2.w,
                          ),
                        ),
                      ),
                    ),

                  // Track
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    width: w,
                    height: h,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((h / 2).r),
                      gradient: widget.isOn
                          ? LinearGradient(
                              colors: [
                                widget.activeColor.withValues(alpha: 0.8),
                                widget.activeColor,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                      color: widget.isOn ? null : const Color(0xFFF2F3ED),
                      boxShadow: widget.isOn
                          ? [
                              BoxShadow(
                                color: widget.activeColor
                                    .withValues(alpha: 0.40),
                                blurRadius: 12,
                                spreadRadius: 0,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 380),
                      curve: Curves.elasticOut,
                      alignment: widget.isOn
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: knobSize,
                        height: knobSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: widget.isOn
                            ? Icon(
                                Iconsax.tick_circle_copy,
                                color: widget.activeColor,
                                size: knobSize * 0.55,
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
