import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EntranceCameraPage extends StatefulWidget {
  const EntranceCameraPage({super.key});

  @override
  State<EntranceCameraPage> createState() => _EntranceCameraPageState();
}

class _EntranceCameraPageState extends State<EntranceCameraPage> {
  bool _isRecording = true;
  bool _isMuted = true;
  double _panX = 0.0;
  double _panY = 0.0;

  bool _blinkState = true;
  Timer? _blinkTimer;

  String _timestamp = '';
  Timer? _timeTimer;

  @override
  void initState() {
    super.initState();
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (mounted) setState(() => _blinkState = !_blinkState);
    });
    _updateTimestamp();
    _timeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) _updateTimestamp();
    });
  }

  void _updateTimestamp() {
    final now = DateTime.now();
    String pad(int n) => n.toString().padLeft(2, '0');
    setState(() {
      _timestamp =
          '${now.year}-${pad(now.month)}-${pad(now.day)}  ${pad(now.hour)}:${pad(now.minute)}:${pad(now.second)}';
    });
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    _timeTimer?.cancel();
    super.dispose();
  }

  void _panCamera(double dx, double dy) {
    setState(() {
      _panX = (_panX + dx).clamp(-40.0, 40.0);
      _panY = (_panY + dy).clamp(-40.0, 40.0);
    });
    _toast(dx != 0
        ? 'Panning ${dx > 0 ? "Right" : "Left"}'
        : 'Panning ${dy > 0 ? "Down" : "Up"}');
  }

  void _resetCamera() {
    setState(() {
      _panX = 0.0;
      _panY = 0.0;
    });
    _toast('Camera Centered');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera feed with pan/tilt
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(_panX, _panY, 0.0),
              child: Image.asset(
                'assets/images/entrance_camera_feed.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark gradient overlays
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.55),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.2, 0.75, 1.0],
                ),
              ),
            ),
          ),

          // Camera grid overlay
          Positioned.fill(
            child: CustomPaint(painter: CameraGridPainter()),
          ),

          // REC indicator + timestamp
          Positioned(
            top: 100.h,
            left: 24.w,
            right: 24.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: _isRecording && _blinkState
                            ? const Color(0xFFE05252)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      _isRecording ? 'REC' : 'STANDBY',
                      style: GoogleFonts.urbanist(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  _timestamp,
                  style: GoogleFonts.shareTechMono(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),

          // Top bar: Back, Title, Bell
          Positioned(
            top: 50.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.arrow_left_2_copy,
                      color: const Color(0xFF1A1E17),
                      size: 20.sp,
                    ),
                  ),
                ),

                Text(
                  'Entrance camera',
                  style: GoogleFonts.urbanist(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                // Bell Button
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Iconsax.notification_copy,
                        color: const Color(0xFF1A1E17),
                        size: 20.sp,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE05252),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Right sidebar: Record toggle, Mute toggle
          Positioned(
            top: 160.h,
            right: 20.w,
            child: Column(
              children: [
                // Record toggle
                GestureDetector(
                  onTap: () {
                    setState(() => _isRecording = !_isRecording);
                    _toast(_isRecording
                        ? 'Recording Started'
                        : 'Recording Paused');
                  },
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A1E17),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: _isRecording ? 14.w : 18.w,
                        height: _isRecording ? 14.w : 18.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE05252),
                          borderRadius:
                              BorderRadius.circular(_isRecording ? 4.r : 9.r),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Mute toggle
                GestureDetector(
                  onTap: () {
                    setState(() => _isMuted = !_isMuted);
                    _toast(
                        _isMuted ? 'Audio Muted' : 'Audio Stream Active');
                  },
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: _isMuted
                          ? Colors.white
                          : const Color(0xFF1A1E17),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isMuted
                          ? Iconsax.volume_mute_copy
                          : Iconsax.volume_high_copy,
                      color: _isMuted
                          ? const Color(0xFF1A1E17)
                          : Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Navigation Controller
          Positioned(
            bottom: 44.h,
            left: 24.w,
            right: 24.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _circlePanBtn(
                  icon: Iconsax.arrow_left_2_copy,
                  onTap: () => _panCamera(-15.0, 0),
                ),
                _centerJoystick(),
                _circlePanBtn(
                  icon: Iconsax.arrow_right_3_copy,
                  onTap: () => _panCamera(15.0, 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circlePanBtn(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1E17).withValues(alpha: 0.85),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }

  Widget _centerJoystick() {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTapDown: (details) {
            final double localX = details.localPosition.dx - 40.w;
            final double localY = details.localPosition.dy - 40.w;
            if (localY.abs() > localX.abs()) {
              _panCamera(0, localY < 0 ? -15.0 : 15.0);
            } else {
              _panCamera(localX < 0 ? -15.0 : 15.0, 0);
            }
          },
          child: Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4), width: 1.5.w),
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ),
        ),
        // Direction dots
        for (final pos in _dotPositions())
          Positioned(
            top: pos[0],
            bottom: pos[1],
            left: pos[2],
            right: pos[3],
            child: Container(
              width: 4.w,
              height: 4.w,
              decoration: const BoxDecoration(
                  color: Colors.white70, shape: BoxShape.circle),
            ),
          ),
        // Center knob
        GestureDetector(
          onTap: _resetCamera,
          child: Container(
            width: 30.w,
            height: 30.w,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }

  List<List<double?>> _dotPositions() => [
        [6.h, null, null, null],
        [null, 6.h, null, null],
        [null, null, 6.w, null],
        [null, null, null, 6.w],
      ];

  void _toast(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.urbanist(
              color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 700),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 80.w, vertical: 120.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r)),
        backgroundColor:
            const Color(0xFF1A1E17).withValues(alpha: 0.9),
      ),
    );
  }
}

class CameraGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final w = size.width;
    final h = size.height;

    canvas.drawLine(Offset(w / 3, 0), Offset(w / 3, h), gridPaint);
    canvas.drawLine(Offset(2 * w / 3, 0), Offset(2 * w / 3, h), gridPaint);
    canvas.drawLine(Offset(0, h / 3), Offset(w, h / 3), gridPaint);
    canvas.drawLine(Offset(0, 2 * h / 3), Offset(w, 2 * h / 3), gridPaint);

    final cornerPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const double bs = 15.0;
    final bL = w * 0.15;
    final bR = w - bL;
    final bT = h * 0.25;
    final bB = h - bT;

    canvas.drawPath(
        Path()
          ..moveTo(bL + bs, bT)
          ..lineTo(bL, bT)
          ..lineTo(bL, bT + bs),
        cornerPaint);
    canvas.drawPath(
        Path()
          ..moveTo(bR - bs, bT)
          ..lineTo(bR, bT)
          ..lineTo(bR, bT + bs),
        cornerPaint);
    canvas.drawPath(
        Path()
          ..moveTo(bL + bs, bB)
          ..lineTo(bL, bB)
          ..lineTo(bL, bB - bs),
        cornerPaint);
    canvas.drawPath(
        Path()
          ..moveTo(bR - bs, bB)
          ..lineTo(bR, bB)
          ..lineTo(bR, bB - bs),
        cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
