import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'tv_dpad.dart';
import 'volume_slider.dart';
import 'bounce_tap.dart';

const _kDark = Color(0xFF1A1E17);
const _kGreen = Color(0xFFA8C37A);
const _kSurface = Color(0xFFF2F3ED);
const _kMuted = Color(0xFF9E9E8E);

class TvControlCard extends StatelessWidget {
  final bool isTvOn;
  final bool isPlaying;
  final double volume;
  final VoidCallback onTogglePower;
  final VoidCallback onTogglePlay;
  final ValueChanged<double> onVolumeChanged;
  final ValueChanged<String> onDirectionPressed;
  final VoidCallback? onBackPressed;
  final VoidCallback? onHomePressed;
  final VoidCallback? onRewindPressed;
  final VoidCallback? onFastForwardPressed;

  const TvControlCard({
    super.key,
    required this.isTvOn,
    required this.isPlaying,
    required this.volume,
    required this.onTogglePower,
    required this.onTogglePlay,
    required this.onVolumeChanged,
    required this.onDirectionPressed,
    this.onBackPressed,
    this.onHomePressed,
    this.onRewindPressed,
    this.onFastForwardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Smart TV Control',
            style: GoogleFonts.urbanist(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: _kDark,
              letterSpacing: 0.1,
            ),
          ),
          SizedBox(height: 22.h),

          // Power button
          BounceTap(
            onTap: onTogglePower,
            beginScale: 0.88,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              width: 62.w,
              height: 62.w,
              decoration: BoxDecoration(
                color: isTvOn ? _kDark : _kSurface,
                shape: BoxShape.circle,
                boxShadow: isTvOn
                    ? [
                        BoxShadow(
                          color: _kDark.withValues(alpha: 0.30),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : [],
              ),
              child: Icon(
                Iconsax.flash_circle_copy,
                color: isTvOn ? _kGreen : _kMuted,
                size: 26.sp,
              ),
            ),
          ),
          SizedBox(height: 22.h),

          // Back / D-pad / Home
          AnimatedOpacity(
            opacity: isTvOn ? 1.0 : 0.35,
            duration: const Duration(milliseconds: 300),
            child: AbsorbPointer(
              absorbing: !isTvOn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _controlBtn(
                    icon: Iconsax.undo_copy,
                    onTap: () => onBackPressed?.call(),
                  ),
                  TvDpad(
                    onDirectionPressed: onDirectionPressed,
                  ),
                  _controlBtn(
                    icon: Iconsax.home_copy,
                    onTap: () => onHomePressed?.call(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 22.h),

          // Media row
          AnimatedOpacity(
            opacity: isTvOn ? 1.0 : 0.35,
            duration: const Duration(milliseconds: 300),
            child: AbsorbPointer(
              absorbing: !isTvOn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _controlBtn(
                    icon: Iconsax.previous_copy,
                    onTap: () => onRewindPressed?.call(),
                  ),
                  SizedBox(width: 26.w),
                  _playPauseBtn(),
                  SizedBox(width: 26.w),
                  _controlBtn(
                    icon: Iconsax.next_copy,
                    onTap: () => onFastForwardPressed?.call(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 26.h),

          // Volume
          AnimatedOpacity(
            opacity: isTvOn ? 1.0 : 0.35,
            duration: const Duration(milliseconds: 300),
            child: AbsorbPointer(
              absorbing: !isTvOn,
              child: VolumeSlider(
                volume: volume,
                isEnabled: isTvOn,
                onVolumeChanged: onVolumeChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlBtn({required IconData icon, required VoidCallback onTap}) {
    return BounceTap(
      onTap: onTap,
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(icon, color: _kDark, size: 20.sp),
      ),
    );
  }

  Widget _playPauseBtn() {
    return BounceTap(
      onTap: onTogglePlay,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 62.w,
        height: 62.w,
        decoration: BoxDecoration(
          color: _kGreen,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _kGreen.withValues(alpha: 0.45),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(
          isPlaying ? Iconsax.pause_copy : Iconsax.play_copy,
          color: Colors.white,
          size: 28.sp,
        ),
      ),
    );
  }
}
