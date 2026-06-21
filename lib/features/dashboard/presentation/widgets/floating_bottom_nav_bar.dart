import 'package:flutter/material.dart';
import 'bounce_tap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

const _kDark = Color(0xFF1A1E17);
const _kGreen = Color(0xFF8FBF5A);

class _NavSpec {
  const _NavSpec(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<_NavSpec> _items = [
  _NavSpec(Iconsax.home_2_copy, 'Home'),
  _NavSpec(Iconsax.monitor_copy, 'Screen'),
  _NavSpec(Iconsax.mobile_copy, 'Remote'),
  _NavSpec(Iconsax.setting_2_copy, 'Settings'),
];

class FloatingBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexSelected;

  const FloatingBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onIndexSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: _kDark,
        borderRadius: BorderRadius.circular(36.r),
        boxShadow: [
          BoxShadow(
            color: _kDark.withValues(alpha: 0.40),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < _items.length; i++)
            _NavItem(
              spec: _items[i],
              isSelected: i == selectedIndex,
              onTap: () => onIndexSelected(i),
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.spec,
    required this.isSelected,
    required this.onTap,
  });

  final _NavSpec spec;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 16.w : 12.w),
        decoration: BoxDecoration(
          color: isSelected ? _kGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: _kGreen.withValues(alpha: 0.45),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with a subtle bounce when it becomes selected.
            TweenAnimationBuilder<double>(
              key: ValueKey(isSelected),
              tween: Tween(begin: isSelected ? 0.7 : 1.0, end: 1.0),
              duration: const Duration(milliseconds: 480),
              curve: Curves.elasticOut,
              builder: (context, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: Icon(
                spec.icon,
                color: isSelected ? _kDark : Colors.white.withValues(alpha: 0.40),
                size: 22.sp,
              ),
            ),

            // Label reveals horizontally only for the selected item.
            ClipRect(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 420),
                curve: Curves.easeOutCubic,
                child: isSelected
                    ? Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          spec.label,
                          style: GoogleFonts.urbanist(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w800,
                            color: _kDark,
                            letterSpacing: 0.2,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
