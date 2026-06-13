import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const _kDark = Color(0xFF1A1E17);
const _kGreenDot = Color(0xFF8FBF5A);

class RoomSelector extends StatelessWidget {
  final List<String> rooms;
  final String selectedRoom;
  final ValueChanged<String> onRoomSelected;

  const RoomSelector({
    super.key,
    required this.rooms,
    required this.selectedRoom,
    required this.onRoomSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          final isSelected = room == selectedRoom;

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () => onRoomSelected(room),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(
                        horizontal: 22.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: isSelected ? _kDark : Colors.white,
                      borderRadius: BorderRadius.circular(22.r),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: _kDark.withValues(alpha: 0.18),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                    ),
                    child: Center(
                      child: Text(
                        room,
                        style: GoogleFonts.urbanist(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : _kDark,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ),
                  // Green dot indicator on selected tab
                  if (isSelected)
                    Positioned(
                      top: -3.h,
                      right: -3.w,
                      child: Container(
                        width: 9.w,
                        height: 9.w,
                        decoration: const BoxDecoration(
                          color: _kGreenDot,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
