import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'tv_screen_card.dart';
import 'smart_toggle_switch.dart';
import 'channel_selector.dart';
import 'slider_card.dart';
import 'bounce_tap.dart';

const _kDark = Color(0xFF1A1E17);
const _kGreen = Color(0xFFA8C37A);
const _kMuted = Color(0xFF9E9E8E);

class TvScreenTab extends StatelessWidget {
  final bool isTvOn;
  final bool isPlaying;
  final int channel;
  final int selectedInput;
  final double volume;
  final List<String> inputs;
  final List<String> pictureModes;
  final int selectedPictureMode;
  final int brightness;
  final int contrast;
  final VoidCallback onTogglePower;
  final VoidCallback onTogglePlay;
  final ValueChanged<int> onInputChanged;
  final ValueChanged<int> onPictureModeChanged;
  final ValueChanged<int> onChannelChanged;
  final ValueChanged<int> onBrightnessChanged;
  final ValueChanged<int> onContrastChanged;

  const TvScreenTab({
    super.key,
    required this.isTvOn,
    required this.isPlaying,
    required this.channel,
    required this.selectedInput,
    required this.volume,
    required this.inputs,
    required this.pictureModes,
    required this.selectedPictureMode,
    required this.brightness,
    required this.contrast,
    required this.onTogglePower,
    required this.onTogglePlay,
    required this.onInputChanged,
    required this.onPictureModeChanged,
    required this.onChannelChanged,
    required this.onBrightnessChanged,
    required this.onContrastChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 80.h,
        bottom: 120.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),

          // ── TvScreenCard ─────────────────────────────────────────
          TvScreenCard(
            isOn: isTvOn,
            isPlaying: isPlaying,
            channel: channel,
            selectedInput: selectedInput,
            volume: volume,
            inputs: inputs,
            onTogglePower: onTogglePower,
            onTogglePlay: onTogglePlay,
          ),
          SizedBox(height: 20.h),

          // Power row with SmartToggleSwitch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TV Power',
                style: GoogleFonts.urbanist(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: _kDark,
                ),
              ),
              SmartToggleSwitch(
                isOn: isTvOn,
                activeColor: _kGreen,
                onChanged: (_) => onTogglePower(),
              ),
            ],
          ),
          SizedBox(height: 18.h),

          // Input Source
          Text(
            'Input Source',
            style: GoogleFonts.urbanist(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: _kMuted,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 44.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: inputs.length,
              itemBuilder: (_, i) {
                final selected = i == selectedInput;
                return BounceTap(
                  onTap: () => onInputChanged(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                      color: selected ? _kDark : Colors.white,
                      borderRadius: BorderRadius.circular(22.r),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: _kDark.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        inputs[i],
                        style: GoogleFonts.urbanist(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: selected ? Colors.white : _kDark,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 18.h),

          // Picture Mode
          Text(
            'Picture Mode',
            style: GoogleFonts.urbanist(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: _kMuted,
            ),
          ),
          SizedBox(height: 10.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pictureModes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.w,
              childAspectRatio: 1.4,
            ),
            itemBuilder: (_, i) {
              final selected = i == selectedPictureMode;
              return BounceTap(
                onTap: () => onPictureModeChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: selected ? _kDark : Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: _kDark.withValues(alpha: 0.18),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      pictureModes[i],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.white : _kDark,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 18.h),

          // ── ChannelSelector ──────────────────────────────────────
          ChannelSelector(
            channel: channel,
            onIncrement: () => onChannelChanged((channel + 1).clamp(1, 999)),
            onDecrement: () => onChannelChanged((channel - 1).clamp(1, 999)),
          ),
          SizedBox(height: 14.h),

          // ── SliderCards ──────────────────────────────────────────
          SliderCard(
            label: 'Brightness',
            icon: Iconsax.sun_1_copy,
            value: brightness,
            onChanged: onBrightnessChanged,
          ),
          SizedBox(height: 12.h),
          SliderCard(
            label: 'Contrast',
            icon: Iconsax.sun_fog_copy,
            value: contrast,
            onChanged: onContrastChanged,
          ),
        ],
      ),
    );
  }
}
