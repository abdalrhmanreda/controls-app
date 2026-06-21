import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'room_selector.dart';
import 'tv_control_card.dart';
import 'climate_card.dart';
import 'camera_card.dart';

class RemoteTab extends StatelessWidget {
  final List<String> rooms;
  final String selectedRoom;
  final ValueChanged<String> onRoomSelected;
  final bool isTvOn;
  final bool isPlaying;
  final double volume;
  final VoidCallback onTogglePower;
  final VoidCallback onTogglePlay;
  final ValueChanged<double> onVolumeChanged;
  final ValueChanged<String> onDirectionPressed;
  final VoidCallback onBackPressed;
  final VoidCallback onHomePressed;
  final VoidCallback onRewindPressed;
  final VoidCallback onFastForwardPressed;
  final VoidCallback onCameraTap;

  const RemoteTab({
    super.key,
    required this.rooms,
    required this.selectedRoom,
    required this.onRoomSelected,
    required this.isTvOn,
    required this.isPlaying,
    required this.volume,
    required this.onTogglePower,
    required this.onTogglePlay,
    required this.onVolumeChanged,
    required this.onDirectionPressed,
    required this.onBackPressed,
    required this.onHomePressed,
    required this.onRewindPressed,
    required this.onFastForwardPressed,
    required this.onCameraTap,
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
          RoomSelector(
            rooms: rooms,
            selectedRoom: selectedRoom,
            onRoomSelected: onRoomSelected,
          ),
          SizedBox(height: 22.h),
          TvControlCard(
            isTvOn: isTvOn,
            isPlaying: isPlaying,
            volume: volume,
            onTogglePower: onTogglePower,
            onTogglePlay: onTogglePlay,
            onVolumeChanged: onVolumeChanged,
            onDirectionPressed: onDirectionPressed,
            onBackPressed: onBackPressed,
            onHomePressed: onHomePressed,
            onRewindPressed: onRewindPressed,
            onFastForwardPressed: onFastForwardPressed,
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              const Expanded(child: ClimateCard()),
              SizedBox(width: 14.w),
              Expanded(
                child: CameraCard(
                  onTap: onCameraTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
