import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

const _kDark = Color(0xFF1A1E17);
const _kSurface = Color(0xFFF2F3ED);
const _kMuted = Color(0xFF9E9E8E);

/// An animated channel selector with digit-rolling transition.
/// Digits slide UP when incrementing, DOWN when decrementing.
class ChannelSelector extends StatefulWidget {
  const ChannelSelector({
    super.key,
    required this.channel,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int channel;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  State<ChannelSelector> createState() => _ChannelSelectorState();
}

class _ChannelSelectorState extends State<ChannelSelector>
    with SingleTickerProviderStateMixin {
  late int _displayChannel;
  bool _isIncrementing = true;

  @override
  void initState() {
    super.initState();
    _displayChannel = widget.channel;
  }

  @override
  void didUpdateWidget(ChannelSelector old) {
    super.didUpdateWidget(old);
    if (widget.channel != old.channel) {
      setState(() {
        _isIncrementing = widget.channel > old.channel;
        _displayChannel = widget.channel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Channel',
                style: GoogleFonts.urbanist(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: _kMuted,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Live TV',
                style: GoogleFonts.urbanist(
                  fontSize: 10.sp,
                  color: _kMuted.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),

          // Digit roller + buttons
          Row(
            children: [
              _ChannelButton(
                icon: Iconsax.arrow_down_2_copy,
                onTap: widget.onDecrement,
              ),
              SizedBox(width: 16.w),

              // Rolling digit display
              SizedBox(
                width: 72.w,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) {
                    final slide = _isIncrementing
                        ? Tween<Offset>(
                            begin: const Offset(0, -1),
                            end: Offset.zero,
                          )
                        : Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset.zero,
                          );
                    return SlideTransition(
                      position: slide.animate(
                          CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                      child: FadeTransition(opacity: anim, child: child),
                    );
                  },
                  child: Text(
                    'CH\n$_displayChannel',
                    key: ValueKey(_displayChannel),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      color: _kDark,
                      height: 1.2,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 16.w),
              _ChannelButton(
                icon: Iconsax.arrow_up_2_copy,
                onTap: widget.onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChannelButton extends StatefulWidget {
  const _ChannelButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_ChannelButton> createState() => _ChannelButtonState();
}

class _ChannelButtonState extends State<_ChannelButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.85)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) async {
        await _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Icon(widget.icon, color: _kDark, size: 18.sp),
        ),
      ),
    );
  }
}
