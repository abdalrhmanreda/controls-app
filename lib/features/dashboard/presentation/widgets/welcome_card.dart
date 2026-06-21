import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

const _kGreen = Color(0xFFA8C37A);

class WelcomeCard extends StatefulWidget {
  final String name;
  final String email;
  final String greeting;
  final int activeDevicesCount;

  const WelcomeCard({
    super.key,
    required this.name,
    required this.email,
    required this.greeting,
    this.activeDevicesCount = 3,
  });

  @override
  State<WelcomeCard> createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1E17), Color(0xFF2D3828)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.greeting},',
                  style: GoogleFonts.urbanist(
                      fontSize: 13.sp, color: Colors.white60),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.name,
                  style: GoogleFonts.urbanist(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                if (widget.email.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    widget.email,
                    style: GoogleFonts.urbanist(
                      fontSize: 12.sp,
                      color: Colors.white70,
                    ),
                  ),
                ],
                SizedBox(height: 10.h),
                _statusChip(
                  icon: Iconsax.electricity_copy,
                  count: widget.activeDevicesCount,
                  color: _kGreen,
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _ctrl,
            builder: (context, child) {
              final t = Curves.easeInOut.transform(_ctrl.value);
              return Transform.translate(
                offset: Offset(0, -4 * t),
                child: Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: _kGreen.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _kGreen.withValues(alpha: 0.15 + 0.25 * t),
                        blurRadius: 12 + 14 * t,
                        spreadRadius: 1 + 2 * t,
                      ),
                    ],
                  ),
                  child: child,
                ),
              );
            },
            child: Icon(Iconsax.home_2_copy, color: _kGreen, size: 30.sp),
          ),
        ],
      ),
    );
  }

  Widget _statusChip({
    required IconData icon,
    required int count,
    required Color color,
  }) {
    final textStyle = GoogleFonts.urbanist(
        fontSize: 11.sp, fontWeight: FontWeight.w600, color: color);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: count > 0 ? 0.18 : 0.10),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12.sp),
          SizedBox(width: 4.w),
          // Animated rolling counter when devices toggle on/off.
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.6),
                end: Offset.zero,
              ).animate(anim),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: Text(
              '$count',
              key: ValueKey(count),
              style: textStyle,
            ),
          ),
          Text(
            count == 1 ? ' device on' : ' devices on',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
