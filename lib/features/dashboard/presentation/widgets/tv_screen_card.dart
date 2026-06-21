import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'bounce_tap.dart';

const _kGreen = Color(0xFFA8C37A);


/// Simulated TV display card that reacts to TV state.
class TvScreenCard extends StatefulWidget {
  const TvScreenCard({
    super.key,
    required this.isOn,
    required this.isPlaying,
    required this.channel,
    required this.selectedInput,
    required this.volume,
    required this.onTogglePower,
    required this.onTogglePlay,
    this.inputs = const ['HDMI 1', 'HDMI 2', 'AV', 'TV'],
  });

  final bool isOn;
  final bool isPlaying;
  final int channel;
  final int selectedInput;
  final double volume;
  final VoidCallback onTogglePower;
  final VoidCallback onTogglePlay;
  final List<String> inputs;

  @override
  State<TvScreenCard> createState() => _TvScreenCardState();
}

class _TvScreenCardState extends State<TvScreenCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _powerCtrl;
  late Animation<double> _scanline;
  late Animation<double> _glowPulse;

  @override
  void initState() {
    super.initState();
    _powerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scanline = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _powerCtrl, curve: Curves.easeOut),
    );
    _glowPulse = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _powerCtrl, curve: Curves.easeInOut),
    );

    if (widget.isOn) _powerCtrl.value = 1.0;

    // Looping glow pulse
    _powerCtrl.addStatusListener((status) {
      if (widget.isOn && status == AnimationStatus.completed) {
        _powerCtrl.reverse();
      } else if (widget.isOn && status == AnimationStatus.dismissed) {
        _powerCtrl.forward();
      }
    });
  }

  @override
  void didUpdateWidget(TvScreenCard old) {
    super.didUpdateWidget(old);
    if (widget.isOn != old.isOn) {
      if (widget.isOn) {
        _powerCtrl.forward(from: 0);
      } else {
        _powerCtrl.stop();
        _powerCtrl.reverse(from: 1);
      }
    }
  }

  @override
  void dispose() {
    _powerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _powerCtrl,
      builder: (context, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
            color: widget.isOn ? const Color(0xFF0D1117) : const Color(0xFF1A1E17),
            borderRadius: BorderRadius.circular(26.r),
            boxShadow: [
              BoxShadow(
                color: widget.isOn
                    ? _kGreen.withValues(alpha: 0.18 * _glowPulse.value)
                    : Colors.black.withValues(alpha: 0.2),
                blurRadius: widget.isOn ? 28 * _glowPulse.value : 12,
                spreadRadius: widget.isOn ? 4 : 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Background gradient (only when on)
              if (widget.isOn)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _TvGradientPainter(alpha: _scanline.value),
                  ),
                ),

              // Scanline effect (only when on & playing)
              if (widget.isOn && widget.isPlaying)
                Positioned.fill(
                  child: CustomPaint(painter: _ScanlinePainter()),
                ),

              // OFF state
              if (!widget.isOn)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.monitor_copy,
                          color: Colors.white.withValues(alpha: 0.15), size: 40.sp),
                      SizedBox(height: 8.h),
                      Text(
                        'TV is Off',
                        style: GoogleFonts.urbanist(
                          fontSize: 14.sp,
                          color: Colors.white.withValues(alpha: 0.25),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      BounceTap(
                        onTap: widget.onTogglePower,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 9.h),
                          decoration: BoxDecoration(
                            color: _kGreen.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                                color: _kGreen.withValues(alpha: 0.4)),
                          ),
                          child: Text(
                            'Turn On',
                            style: GoogleFonts.urbanist(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: _kGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // ON state overlays
              if (widget.isOn) ...[
                // CH badge (top-left)
                Positioned(
                  top: 14.h,
                  left: 16.w,
                  child: _Badge(
                    child: Row(
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: const BoxDecoration(
                              color: Color(0xFFE05252), shape: BoxShape.circle),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'LIVE  CH ${widget.channel}',
                          style: GoogleFonts.shareTechMono(
                            fontSize: 9.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Input badge (top-right)
                Positioned(
                  top: 14.h,
                  right: 16.w,
                  child: _Badge(
                    color: _kGreen.withValues(alpha: 0.2),
                    child: Text(
                      widget.inputs[widget.selectedInput],
                      style: GoogleFonts.urbanist(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        color: _kGreen,
                      ),
                    ),
                  ),
                ),

                // Center play/pause
                Center(
                  child: BounceTap(
                    onTap: widget.onTogglePlay,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 52.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                            alpha: widget.isPlaying ? 0.08 : 0.18),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1.5.w,
                        ),
                      ),
                      child: Icon(
                        widget.isPlaying
                            ? Iconsax.pause_circle_copy
                            : Iconsax.play_circle_copy,
                        color: Colors.white.withValues(alpha: 0.7),
                        size: 26.sp,
                      ),
                    ),
                  ),
                ),

                // Bottom volume bar
                Positioned(
                  bottom: 12.h,
                  left: 16.w,
                  right: 16.w,
                  child: Row(
                    children: [
                      Icon(Iconsax.volume_high_copy,
                          color: Colors.white38, size: 13.sp),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: Stack(
                            children: [
                              Container(height: 3.h, color: Colors.white12),
                              FractionallySizedBox(
                                widthFactor: widget.volume / 100,
                                child: Container(height: 3.h, color: _kGreen),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${widget.volume.toInt()}',
                        style: GoogleFonts.shareTechMono(
                            fontSize: 9.sp, color: Colors.white38),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

// ─── TV Background Gradient Painter ───────────────────────────────
class _TvGradientPainter extends CustomPainter {
  final double alpha;
  const _TvGradientPainter({required this.alpha});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF1A2740), Color(0xFF0D1117), Color(0xFF1A1005)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height * alpha), paint);
  }

  @override
  bool shouldRepaint(_TvGradientPainter old) => old.alpha != alpha;
}

// ─── Scanline Painter ─────────────────────────────────────────────
class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..style = PaintingStyle.fill;
    const spacing = 4.0;
    for (double y = 0; y < size.height; y += spacing * 2) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, spacing), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

// ─── Badge helper ─────────────────────────────────────────────────
class _Badge extends StatelessWidget {
  const _Badge({required this.child, this.color});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color ?? Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: child,
    );
  }
}
