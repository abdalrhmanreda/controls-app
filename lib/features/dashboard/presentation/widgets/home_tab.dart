import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:control_app/config/routes/route_names.dart';
import 'room_selector.dart';
import 'welcome_card.dart';
import 'device_toggle_card.dart';
import 'climate_card.dart';
import 'camera_card.dart';
import 'animated_entrance.dart';

const _kDark = Color(0xFF1A1E17);
const _kGreen = Color(0xFFA8C37A);

class HomeTab extends StatelessWidget {
  final List<String> rooms;
  final String selectedRoom;
  final ValueChanged<String> onRoomSelected;
  final String userName;
  final String userEmail;
  final String greeting;
  final bool isTvOn;
  final VoidCallback onToggleTv;
  final bool isAcOn;
  final VoidCallback onToggleAc;
  final bool isLightsOn;
  final VoidCallback onToggleLights;
  final bool isSecurityOn;
  final VoidCallback onToggleSecurity;

  const HomeTab({
    super.key,
    required this.rooms,
    required this.selectedRoom,
    required this.onRoomSelected,
    required this.userName,
    required this.userEmail,
    required this.greeting,
    required this.isTvOn,
    required this.onToggleTv,
    required this.isAcOn,
    required this.onToggleAc,
    required this.isLightsOn,
    required this.onToggleLights,
    required this.isSecurityOn,
    required this.onToggleSecurity,
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
          AnimatedEntrance(
            delay: const Duration(milliseconds: 40),
            child: RoomSelector(
              rooms: rooms,
              selectedRoom: selectedRoom,
              onRoomSelected: onRoomSelected,
            ),
          ),
          SizedBox(height: 22.h),

          // Welcome card
          AnimatedEntrance(
            delay: const Duration(milliseconds: 120),
            child: WelcomeCard(
              name: userName,
              email: userEmail,
              greeting: greeting,
              activeDevicesCount: [
                isTvOn,
                isAcOn,
                isLightsOn,
                isSecurityOn,
              ].where((on) => on).length,
            ),
          ),
          SizedBox(height: 20.h),

          AnimatedEntrance(
            delay: const Duration(milliseconds: 200),
            child: Text(
              'Quick Controls',
              style: GoogleFonts.urbanist(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: _kDark,
              ),
            ),
          ),
          SizedBox(height: 14.h),

          // ── DeviceToggleCard grid ─────────────────────────────────
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.55,
            children: [
              AnimatedEntrance(
                delay: const Duration(milliseconds: 260),
                child: DeviceToggleCard(
                  icon: Iconsax.monitor_copy,
                  label: 'Smart TV',
                  isOn: isTvOn,
                  color: _kGreen,
                  onTap: onToggleTv,
                ),
              ),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 320),
                child: DeviceToggleCard(
                  icon: Iconsax.wind_2_copy,
                  label: 'AC',
                  isOn: isAcOn,
                  color: const Color(0xFF6FB4D6),
                  onTap: onToggleAc,
                ),
              ),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 380),
                child: DeviceToggleCard(
                  icon: Iconsax.flash_circle_copy,
                  label: 'Lights',
                  isOn: isLightsOn,
                  color: const Color(0xFFE5C17C),
                  onTap: onToggleLights,
                ),
              ),
              AnimatedEntrance(
                delay: const Duration(milliseconds: 440),
                child: DeviceToggleCard(
                  icon: Iconsax.security_safe_copy,
                  label: 'Security',
                  isOn: isSecurityOn,
                  color: const Color(0xFFD47B72),
                  onTap: onToggleSecurity,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),

          AnimatedEntrance(
            delay: const Duration(milliseconds: 520),
            child: Row(
              children: [
                const Expanded(child: ClimateCard()),
                SizedBox(width: 14.w),
                Expanded(
                  child: CameraCard(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.entranceCamera),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
