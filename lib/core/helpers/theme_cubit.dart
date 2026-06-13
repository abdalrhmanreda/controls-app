import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:control_app/core/cache/cache_helper.dart';

/// Manages the app's theme mode (light/dark).
/// Persists the user's choice to SharedPreferences.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  /// Load the saved theme preference on startup.
  Future<void> loadTheme() async {
    final isDark = await CacheHelper.isDarkMode();
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  /// Toggle between light and dark mode.
  Future<void> toggleTheme() async {
    final newMode =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await CacheHelper.setDarkMode(newMode == ThemeMode.dark);
    emit(newMode);
  }

  /// Check if dark mode is currently active.
  bool get isDarkMode => state == ThemeMode.dark;
}
