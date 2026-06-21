import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'settings_section.dart';
import 'smart_toggle_switch.dart';
import 'settings_tile.dart';
import 'bounce_tap.dart';

const _kDark = Color(0xFF1A1E17);
const _kSurface = Color(0xFFF2F3ED);
const _kMuted = Color(0xFF9E9E8E);
const _kGreenDot = Color(0xFF8FBF5A);

class SettingsTab extends StatelessWidget {
  final List<String> soundModes;
  final int selectedSoundMode;
  final ValueChanged<int> onSoundModeChanged;
  final bool sleepTimerOn;
  final ValueChanged<bool> onSleepTimerToggle;
  final int sleepMins;
  final ValueChanged<int> onSleepMinsChanged;
  final ValueChanged<String> onTileTap;

  const SettingsTab({
    super.key,
    required this.soundModes,
    required this.selectedSoundMode,
    required this.onSoundModeChanged,
    required this.sleepTimerOn,
    required this.onSleepTimerToggle,
    required this.sleepMins,
    required this.onSleepMinsChanged,
    required this.onTileTap,
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
          Text(
            'Settings',
            style: GoogleFonts.urbanist(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: _kDark,
            ),
          ),
          SizedBox(height: 20.h),

          // Sound mode
          SettingsSection(
            title: 'Sound Mode',
            child: Wrap(
              spacing: 8.w,
              children: List.generate(soundModes.length, (i) {
                final selected = i == selectedSoundMode;
                return BounceTap(
                  onTap: () => onSoundModeChanged(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? _kDark : _kSurface,
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
                    child: Text(
                      soundModes[i],
                      style: GoogleFonts.urbanist(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.white : _kDark,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 12.h),

          // Sleep Timer with SmartToggleSwitch
          SettingsSection(
            title: 'Sleep Timer',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sleepTimerOn ? '$sleepMins minutes' : 'Disabled',
                      style: GoogleFonts.urbanist(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: _kMuted,
                      ),
                    ),
                    // ── SmartToggleSwitch ─────────────────────────
                    SmartToggleSwitch(
                      isOn: sleepTimerOn,
                      activeColor: _kGreenDot,
                      onChanged: onSleepTimerToggle,
                    ),
                  ],
                ),
                if (sleepTimerOn) ...[
                  SizedBox(height: 10.h),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: _kDark,
                      inactiveTrackColor: _kSurface,
                      thumbColor: _kDark,
                      overlayColor: _kDark.withValues(alpha: 0.1),
                      trackHeight: 4.h,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 8.r,
                      ),
                    ),
                    child: Slider(
                      value: sleepMins.toDouble(),
                      min: 10,
                      max: 120,
                      divisions: 11,
                      onChanged: (v) => onSleepMinsChanged(v.toInt()),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // Info tiles using SettingsTile
          ...[
            ('Display Name', 'Living Room TV', Iconsax.monitor_copy),
            ('Resolution', '4K Ultra HD', Iconsax.cpu_setting_copy),
            ('Network', 'Connected • WiFi', Iconsax.wifi_copy),
            ('Software', 'v3.2.1 (Latest)', Iconsax.info_circle_copy),
          ].map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: SettingsTile(
                label: item.$1,
                value: item.$2,
                icon: item.$3,
                onTap: () => onTileTap(item.$1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
