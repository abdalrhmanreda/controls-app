import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

/// App theme configuration using Google Fonts Urbanist
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Get Urbanist text theme using Google Fonts
  static TextTheme _getTextTheme(Color textColor, Color secondaryTextColor) {
    return TextTheme(
      displayLarge: GoogleFonts.exo2(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displayMedium: GoogleFonts.exo2(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displaySmall: GoogleFonts.exo2(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headlineLarge: GoogleFonts.exo2(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.exo2(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.exo2(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleLarge: GoogleFonts.exo2(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: GoogleFonts.exo2(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleSmall: GoogleFonts.exo2(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.exo2(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.exo2(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodySmall: GoogleFonts.exo2(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: secondaryTextColor,
      ),
      labelLarge: GoogleFonts.exo2(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelMedium: GoogleFonts.exo2(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelSmall: GoogleFonts.exo2(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
      ),
    );
  }

  // Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      primaryColor: AppColors.kPrimaryColor,
      scaffoldBackgroundColor: AppColors.kWhiteColor,

      // Apply Google Fonts Urbanist
      textTheme: _getTextTheme(
        AppColors.kPrimaryColor,
        AppColors.kUnFocusBorderColor,
      ),

      colorScheme: const ColorScheme.light(
        primary: AppColors.kPrimaryColor,
        secondary: AppColors.kPrimaryDark,
        tertiary: AppColors.kPrimaryMedium,
        surface: AppColors.kWhiteColor,
        error: AppColors.kPrimaryLightest,
        onPrimary: AppColors.kWhiteColor,
        onSecondary: AppColors.kWhiteColor,
        onSurface: AppColors.kBlackColor,
        onError: AppColors.kWhiteColor,
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.kWhiteColor,
        foregroundColor: AppColors.kBlackColor,
        iconTheme: const IconThemeData(color: AppColors.kBlackColor),
        titleTextStyle: GoogleFonts.exo2(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.kBlackColor,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 2,
        color: AppColors.kPrimaryLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.urbanist(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: GoogleFonts.urbanist(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.urbanist(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.kWhiteColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.kUnFocusBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.kUnFocusBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.kPrimaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.kPrimaryLightest),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.kPrimaryLightest,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.kUnFocusBorderColor),
        ),
        labelStyle: GoogleFonts.urbanist(
          fontSize: 14,
          color: AppColors.kUnFocusBorderColor,
        ),
        hintStyle: GoogleFonts.urbanist(
          fontSize: 14,
          color: AppColors.kUnFocusBorderColor,
        ),
        errorStyle: GoogleFonts.urbanist(
          fontSize: 12,
          color: AppColors.kPrimaryLightest,
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.kUnFocusBorderColor,
        thickness: 1,
        space: 1,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.kPrimaryLight,
        selectedItemColor: AppColors.kPrimaryColor,
        unselectedItemColor: AppColors.kUnFocusBorderColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.urbanist(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.urbanist(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.kPrimaryLight,
        indicatorColor: AppColors.kPrimaryColor.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.urbanist(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.kPrimaryColor,
            );
          }
          return GoogleFonts.urbanist(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.kUnFocusBorderColor,
          );
        }),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.kPrimaryColor,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.kPrimaryLight,
        contentTextStyle: GoogleFonts.urbanist(
          fontSize: 14,
          color: AppColors.kPrimaryLightest,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.kPrimaryLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: GoogleFonts.urbanist(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.kPrimaryColor,
        ),
        contentTextStyle: GoogleFonts.urbanist(
          fontSize: 14,
          color: AppColors.kPrimaryColor,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.kPrimaryLight,
        selectedColor: AppColors.kPrimaryColor.withValues(alpha: 0.2),
        labelStyle: GoogleFonts.urbanist(
          fontSize: 14,
          color: AppColors.kPrimaryColor,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      datePickerTheme: DatePickerThemeData(
        headerBackgroundColor: AppColors.kPrimaryColor,
        headerForegroundColor: AppColors.kWhiteColor,
        backgroundColor: AppColors.kWhiteColor,
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.kPrimaryColor;
          }
          return null;
        }),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.kWhiteColor;
          }
          return AppColors.kBlackColor;
        }),
        todayBackgroundColor: WidgetStateProperty.all(
          AppColors.kPrimaryColor.withValues(alpha: 0.1),
        ),
        todayForegroundColor: WidgetStateProperty.all(AppColors.kPrimaryColor),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: AppColors.kWhiteColor,
        dialHandColor: AppColors.kPrimaryColor,
        dialBackgroundColor: AppColors.kSkyBlueColor,
        hourMinuteTextColor: AppColors.kPrimaryColor,
        hourMinuteColor: AppColors.kSkyBlueColor,
        dayPeriodTextColor: AppColors.kPrimaryColor,
        dayPeriodColor: AppColors.kSkyBlueColor,
        entryModeIconColor: AppColors.kPrimaryColor,
        helpTextStyle: const TextStyle(
          color: AppColors.kBlackColor,
          fontSize: 12,
        ),
      ),
    );
  }

  // Dark theme
  static ThemeData get darkTheme {
    const Color darkSurface = Color(0xFF121212);
    const Color darkCard = Color(0xFF1E1E1E);
    const Color darkElevated = Color(0xFF2A2A2A);
    const Color darkTextPrimary = Color(0xFFF5F5F5);
    const Color darkTextSecondary = Color(0xFFB0B0B0);
    const Color darkBorder = Color(0xFF333333);

    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      primaryColor: AppColors.kPrimaryColor,
      scaffoldBackgroundColor: darkSurface,

      // Apply Google Fonts Exo2
      textTheme: _getTextTheme(darkTextPrimary, darkTextSecondary),

      colorScheme: ColorScheme.dark(
        primary: AppColors.kPrimaryColor,
        secondary: AppColors.kPrimaryMedium,
        tertiary: AppColors.kPrimaryLight,
        surface: darkCard,
        error: AppColors.kRedColor,
        onPrimary: AppColors.kWhiteColor,
        onSecondary: darkTextPrimary,
        onSurface: darkTextPrimary,
        onError: AppColors.kWhiteColor,
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: darkSurface,
        foregroundColor: darkTextPrimary,
        iconTheme: const IconThemeData(color: darkTextPrimary),
        titleTextStyle: GoogleFonts.exo2(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 2,
        color: darkCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: AppColors.kWhiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.exo2(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkTextPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: GoogleFonts.exo2(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkTextPrimary,
          side: const BorderSide(color: darkBorder),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.exo2(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.kPrimaryColor.withValues(alpha: 0.8),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.kRedColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.kRedColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkBorder.withValues(alpha: 0.5)),
        ),
        labelStyle: GoogleFonts.exo2(fontSize: 14, color: darkTextSecondary),
        hintStyle: GoogleFonts.exo2(
          fontSize: 14,
          color: darkTextSecondary.withValues(alpha: 0.6),
        ),
        errorStyle: GoogleFonts.exo2(fontSize: 12, color: AppColors.kRedColor),
      ),

      dividerTheme: const DividerThemeData(
        color: darkBorder,
        thickness: 1,
        space: 1,
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkCard,
        selectedItemColor: AppColors.kWhiteColor,
        unselectedItemColor: darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.exo2(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.exo2(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkCard,
        indicatorColor: AppColors.kPrimaryColor.withValues(alpha: 0.3),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.exo2(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.kWhiteColor,
            );
          }
          return GoogleFonts.exo2(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: darkTextSecondary,
          );
        }),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.kWhiteColor,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: darkElevated,
        contentTextStyle: GoogleFonts.exo2(
          fontSize: 14,
          color: darkTextPrimary,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: darkCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: GoogleFonts.exo2(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
        contentTextStyle: GoogleFonts.exo2(
          fontSize: 14,
          color: darkTextSecondary,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: darkElevated,
        selectedColor: AppColors.kPrimaryColor.withValues(alpha: 0.3),
        labelStyle: GoogleFonts.exo2(fontSize: 14, color: darkTextPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      datePickerTheme: DatePickerThemeData(
        headerBackgroundColor: AppColors.kPrimaryColor,
        headerForegroundColor: AppColors.kWhiteColor,
        backgroundColor: darkCard,
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.kPrimaryColor;
          }
          return null;
        }),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.kWhiteColor;
          }
          return darkTextPrimary;
        }),
        todayBackgroundColor: WidgetStateProperty.all(
          AppColors.kPrimaryColor.withValues(alpha: 0.2),
        ),
        todayForegroundColor: WidgetStateProperty.all(AppColors.kWhiteColor),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: darkCard,
        dialHandColor: AppColors.kPrimaryColor,
        dialBackgroundColor: darkElevated,
        hourMinuteTextColor: darkTextPrimary,
        hourMinuteColor: darkElevated,
        dayPeriodTextColor: darkTextPrimary,
        dayPeriodColor: darkElevated,
        entryModeIconColor: darkTextPrimary,
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.kWhiteColor;
          }
          return darkTextSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.kPrimaryColor;
          }
          return darkBorder;
        }),
      ),
    );
  }
}
