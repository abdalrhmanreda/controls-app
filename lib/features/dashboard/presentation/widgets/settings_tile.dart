import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'bounce_tap.dart';

const _kDark = Color(0xFF1A1E17);
const _kSurface = Color(0xFFF2F3ED);
const _kMuted = Color(0xFF9E9E8E);

/// A compact settings list tile with icon, label, value, chevron.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: onTap,
      beginScale: 0.97,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: _kDark, size: 18.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.urbanist(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: _kDark,
                ),
              ),
            ),
            Text(
              value,
              style: GoogleFonts.urbanist(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: _kMuted,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Iconsax.arrow_right_3_copy, color: _kMuted, size: 14.sp),
          ],
        ),
      ),
    );
  }
}
