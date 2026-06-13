import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class VolumeSlider extends StatelessWidget {
  final double volume;
  final ValueChanged<double> onVolumeChanged;
  final bool isEnabled;

  const VolumeSlider({
    super.key,
    required this.volume,
    required this.onVolumeChanged,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double trackW = constraints.maxWidth;
        return AbsorbPointer(
          absorbing: !isEnabled,
          child: GestureDetector(
            onHorizontalDragUpdate: (d) {
              final pct = (d.localPosition.dx / trackW).clamp(0.0, 1.0);
              onVolumeChanged((pct * 100).roundToDouble());
            },
            onTapDown: (d) {
              final pct = (d.localPosition.dx / trackW).clamp(0.0, 1.0);
              onVolumeChanged((pct * 100).roundToDouble());
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                children: [
                  // Empty track
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    color: const Color(0xFFF0F0EA),
                  ),

                  // Filled amber gradient track
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 80),
                    height: 40.h,
                    width: trackW * (volume / 100),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFEDD7B5), Color(0xFFD4A96A)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),

                  // Icon + label overlay
                  SizedBox(
                    height: 40.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            volume > 0
                                ? Iconsax.volume_high_copy
                                : Iconsax.volume_mute_copy,
                            color: const Color(0xFF8B7D6B),
                            size: 17.sp,
                          ),
                          Row(
                            children: [
                              Icon(
                                Iconsax.volume_low_copy,
                                color: const Color(0xFF8B7D6B),
                                size: 14.sp,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                volume.toInt().toString(),
                                style: GoogleFonts.urbanist(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF8B7D6B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
