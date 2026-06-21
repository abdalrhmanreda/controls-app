import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ClimateCard extends StatelessWidget {
  const ClimateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Climate',
                style: GoogleFonts.urbanist(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1E17),
                ),
              ),
              Icon(
                Iconsax.wind_2_copy,
                color: const Color(0xFFA8C37A),
                size: 20.sp,
              ),
            ],
          ),
          Row(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1100),
                curve: Curves.easeOutCubic,
                builder: (context, t, _) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 44.w,
                        height: 44.w,
                        child: CircularProgressIndicator(
                          value: 0.72 * t,
                          strokeWidth: 3.5.w,
                          backgroundColor: const Color(0xFFF1F3EC),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFE5C8A6)),
                        ),
                      ),
                      Text(
                        '${(22 * t).round()}°',
                        style: GoogleFonts.urbanist(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1E17),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Auto Mode',
                    style: GoogleFonts.urbanist(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1E17),
                    ),
                  ),
                  Text(
                    'Normal',
                    style: GoogleFonts.urbanist(
                      fontSize: 10.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
