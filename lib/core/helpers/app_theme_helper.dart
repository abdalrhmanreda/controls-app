import 'package:flutter/material.dart';

/// Extension on BuildContext to provide easy access to theme-aware colors.
/// Use these throughout the app instead of hardcoded colors like `Colors.white`
/// or `AppColors.kBlackColor` to ensure dark mode compatibility.
extension AppThemeHelper on BuildContext {
  /// Whether the current theme is dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Main scaffold / page background color
  Color get scaffoldColor =>
      isDarkMode ? const Color(0xFF121212) : const Color(0xffF8F9FB);

  /// Card / Container background color
  Color get cardColor =>
      isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;

  /// Secondary card (slightly lighter/darker than cardColor)
  Color get cardColorSecondary =>
      isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xffF5F7FA);

  /// Primary text color (for titles, headings)
  Color get textPrimary =>
      isDarkMode ? const Color(0xFFF5F5F5) : const Color(0xFF000000);

  /// Secondary text color (for subtitles, captions)
  Color get textSecondary =>
      isDarkMode ? const Color(0xFFB0B0B0) : const Color(0xff82898d);

  /// Divider / border color
  Color get dividerColor =>
      isDarkMode
          ? Colors.white.withValues(alpha: 0.08)
          : const Color(0xffEDEDED);

  /// Border color
  Color get borderColor => dividerColor;

  /// Icon color (default)
  Color get iconColor =>
      isDarkMode ? const Color(0xFFE0E0E0) : const Color(0xFF000000);

  /// Muted icon color
  Color get iconColorMuted =>
      isDarkMode
          ? Colors.white.withValues(alpha: 0.4)
          : Colors.black.withValues(alpha: 0.4);

  /// Shadow color adapted for dark mode (invisible in dark)
  Color get shadowColor =>
      isDarkMode
          ? Colors.black.withValues(alpha: 0.3)
          : Colors.black.withValues(alpha: 0.04);

  /// Bottom sheet / dialog background
  Color get sheetColor =>
      isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;

  /// AppBar background
  Color get appBarColor => scaffoldColor;

  /// Navigation bar background
  Color get navBarColor =>
      isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFF000000);

  /// Unselected / inactive chip/tab background
  Color get chipColor =>
      isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

  /// Gradient-placeholder background
  List<Color> get gradientPlaceholder =>
      isDarkMode
          ? [const Color(0xFF2A2A2A), const Color(0xFF1E1E1E)]
          : [const Color(0xffF1F4F8), const Color(0xffE2E8F0)];

  /// Input field fill color
  Color get inputFillColor =>
      isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

  /// Dynamic primary theme color (black in light, white in dark)
  Color get primaryColor =>
      isDarkMode ? Colors.white : const Color(0xff000000);

  /// Dynamic primary gradient
  List<Color> get primaryGradient => isDarkMode
      ? [
          Colors.white,
          Colors.white.withValues(alpha: 0.9),
          Colors.white.withValues(alpha: 0.8),
        ]
      : [
          const Color(0xff000000),
          const Color(0xff000000).withValues(alpha: 0.8),
          const Color(0xff000000).withValues(alpha: 0.6),
        ];
}
