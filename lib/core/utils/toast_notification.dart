import 'dart:ui';
import 'package:control_app/config/colors/app_colors.dart';
import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info, custom }

enum SnackBarPosition { top, bottom }

class ModernSnackBar {
  static OverlayEntry? _currentSnackBar;

  static void show(
    BuildContext context, {
    required String message,
    String? title,
    SnackBarType type = SnackBarType.info,
    SnackBarPosition position = SnackBarPosition.top,
    Duration duration = const Duration(seconds: 4),
    Color? customColor,
    IconData? customIcon,
    VoidCallback? onTap,
    bool showProgressIndicator = true,
    bool dismissible = true,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    // Remove current snackbar if exists with a quick reverse animation check ideally,
    // but for simplicity we remove it immediately or could queue it.
    // Here we remove strictly to avoid overlap.
    _currentSnackBar?.remove();
    _currentSnackBar = null;

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => ModernSnackBarWidget(
        message: message,
        title: title,
        type: type,
        position: position,
        duration: duration,
        customColor: customColor,
        customIcon: customIcon,
        onTap: onTap,
        showProgressIndicator: showProgressIndicator,
        dismissible: dismissible,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        onDismiss: () {
          if (overlayEntry.mounted) {
            overlayEntry.remove();
          }
          _currentSnackBar = null;
        },
      ),
    );

    overlay.insert(overlayEntry);
    _currentSnackBar = overlayEntry;
  }

  static void dismiss() {
    _currentSnackBar?.remove();
    _currentSnackBar = null;
  }
}

class ModernSnackBarWidget extends StatefulWidget {
  final String message;
  final String? title;
  final SnackBarType type;
  final SnackBarPosition position;
  final Duration duration;
  final Color? customColor;
  final IconData? customIcon;
  final VoidCallback? onTap;
  final bool showProgressIndicator;
  final bool dismissible;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final VoidCallback onDismiss;

  const ModernSnackBarWidget({
    super.key,
    required this.message,
    this.title,
    required this.type,
    required this.position,
    required this.duration,
    this.customColor,
    this.customIcon,
    this.onTap,
    required this.showProgressIndicator,
    required this.dismissible,
    this.actionLabel,
    this.onActionPressed,
    required this.onDismiss,
  });

  @override
  State<ModernSnackBarWidget> createState() => _ModernSnackBarWidgetState();
}

class _ModernSnackBarWidgetState extends State<ModernSnackBarWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _progressController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Slide animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _offsetAnimation =
        Tween<Offset>(
          begin: widget.position == SnackBarPosition.top
              ? const Offset(0, -1)
              : const Offset(0, 1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    // Progress animation
    _progressController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _slideController.forward();
    if (widget.showProgressIndicator) {
      _progressController.forward();
    }

    // Auto dismiss
    Future.delayed(widget.duration, () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    await _slideController.reverse().orCancel;
    widget.onDismiss();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  SnackBarConfig get _config {
    switch (widget.type) {
      case SnackBarType.success:
        return SnackBarConfig(
          color: AppColors.kGreenColor,
          icon: Icons.check_circle_outline_rounded,
          title: widget.title ?? 'Success',
          gradientColors: [AppColors.kGreenColor, AppColors.kGreenColor.withValues(alpha: 0.7)],
        );
      case SnackBarType.error:
        return SnackBarConfig(
          color: AppColors.kRedColor,
          icon: Icons.error_outline_rounded,
          title: widget.title ?? 'Error',
          gradientColors: [AppColors.kRedColor, AppColors.kRedColor.withValues(alpha: 0.7)],
        );
      case SnackBarType.warning:
        return SnackBarConfig(
          color: AppColors.kAmberColor,
          icon: Icons.warning_amber_rounded,
          title: widget.title ?? 'Warning',
          gradientColors: [AppColors.kAmberColor, AppColors.kAmberColor.withValues(alpha: 0.7)],
        );
      case SnackBarType.info:
        return SnackBarConfig(
          color: AppColors.kBlueColor,
          icon: Icons.info_outline_rounded,
          title: widget.title ?? 'Info',
          gradientColors: [AppColors.kBlueColor, AppColors.kBlueColor.withValues(alpha: 0.7)],
        );
      case SnackBarType.custom:
        final color = widget.customColor ?? AppColors.kPrimaryColor;
        return SnackBarConfig(
          color: color,
          icon: widget.customIcon ?? Icons.notifications_none_rounded,
          title: widget.title ?? 'Notification',
          gradientColors: [color, color.withValues(alpha: 0.7)],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = _config;
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Positioned(
      top: widget.position == SnackBarPosition.top ? topPadding + 16 : null,
      bottom: widget.position == SnackBarPosition.bottom
          ? bottomPadding + 16
          : null,
      left: 20,
      right: 20,
      child: SlideTransition(
        position: _offsetAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: GestureDetector(
              onTap: widget.onTap,
              onHorizontalDragEnd: widget.dismissible
                  ? (details) {
                      if (details.primaryVelocity!.abs() > 300) {
                        _dismiss();
                      }
                    }
                  : null,
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: config.color.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: config.color.withValues(alpha: 0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                // Icon Container
                                Container(
                                  width: 48,
                                  height: 48,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: config.gradientColors
                                          .map((c) => c.withValues(alpha: 0.15))
                                          .toList(),
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    config.icon,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),

                                // Content
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 8,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          config.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            height: 1.2,
                                            fontWeight: FontWeight.w700,
                                            fontFamily:
                                                'Inter', // Fallback defaults if not available
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          widget.message,
                                          style: TextStyle(
                                            color: Colors.white.withValues(alpha: 0.9),
                                            fontSize: 13,
                                            height: 1.4,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Action or Close
                                if (widget.onActionPressed != null)
                                  TextButton(
                                    onPressed: () {
                                      widget.onActionPressed!();
                                      _dismiss();
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      widget.actionLabel ?? 'Action',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  )
                                else if (widget.dismissible)
                                  Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: Colors.white.withValues(alpha: 0.7),
                                        size: 18,
                                      ),
                                      onPressed: _dismiss,
                                      splashRadius: 20,
                                      constraints: BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SnackBarConfig {
  final Color color;
  final IconData icon;
  final String title;
  final List<Color> gradientColors;

  SnackBarConfig({
    required this.color,
    required this.icon,
    required this.title,
    required this.gradientColors,
  });
}
