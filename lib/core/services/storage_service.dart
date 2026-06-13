import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Service for local storage using SharedPreferences
class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _preferences;

  // Private constructor
  StorageService._();

  // Singleton instance
  static Future<StorageService> getInstance() async {
    _instance ??= StorageService._();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // Keys
  static const String _keyUserLevel = 'user_level';
  static const String _keyUserXP = 'user_xp';
  static const String _keyUserName = 'user_name';
  static const String _keyActivityDates = 'activity_dates';
  static const String _keyCompletedMilestones = 'completed_milestones';
  static const String _keyCompletedCheckpoints = 'completed_checkpoints';
  static const String _keyAchievements = 'achievements';
  static const String _keyLanguage = 'language';
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyOnboardingComplete = 'onboarding_complete';
  static const String _keyNotificationsEnabled = 'notifications_enabled';

  // User Data
  Future<void> saveUserLevel(int level) async {
    await _preferences?.setInt(_keyUserLevel, level);
  }

  int getUserLevel() {
    return _preferences?.getInt(_keyUserLevel) ?? 1;
  }

  Future<void> saveUserXP(int xp) async {
    await _preferences?.setInt(_keyUserXP, xp);
  }

  int getUserXP() {
    return _preferences?.getInt(_keyUserXP) ?? 0;
  }

  Future<void> saveUserName(String name) async {
    await _preferences?.setString(_keyUserName, name);
  }

  String getUserName() {
    return _preferences?.getString(_keyUserName) ?? 'Learner';
  }

  // Activity Tracking
  Future<void> saveActivityDates(List<DateTime> dates) async {
    final dateStrings = dates.map((d) => d.toIso8601String()).toList();
    await _preferences?.setString(_keyActivityDates, jsonEncode(dateStrings));
  }

  List<DateTime> getActivityDates() {
    final jsonString = _preferences?.getString(_keyActivityDates);
    if (jsonString == null) return [];

    try {
      final List<dynamic> dateStrings = jsonDecode(jsonString);
      return dateStrings
          .map((s) => DateTime.parse(s as String))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addActivityDate(DateTime date) async {
    final dates = getActivityDates();
    dates.add(date);
    await saveActivityDates(dates);
  }

  // Milestones
  Future<void> saveCompletedMilestones(List<String> milestoneIds) async {
    await _preferences?.setString(
      _keyCompletedMilestones,
      jsonEncode(milestoneIds),
    );
  }

  List<String> getCompletedMilestones() {
    final jsonString = _preferences?.getString(_keyCompletedMilestones);
    if (jsonString == null) return [];

    try {
      final List<dynamic> ids = jsonDecode(jsonString);
      return ids.cast<String>();
    } catch (e) {
      return [];
    }
  }

  Future<void> addCompletedMilestone(String milestoneId) async {
    final milestones = getCompletedMilestones();
    if (!milestones.contains(milestoneId)) {
      milestones.add(milestoneId);
      await saveCompletedMilestones(milestones);
    }
  }

  // Checkpoints
  Future<void> saveCompletedCheckpoints(List<String> checkpointIds) async {
    await _preferences?.setString(
      _keyCompletedCheckpoints,
      jsonEncode(checkpointIds),
    );
  }

  List<String> getCompletedCheckpoints() {
    final jsonString = _preferences?.getString(_keyCompletedCheckpoints);
    if (jsonString == null) return [];

    try {
      final List<dynamic> ids = jsonDecode(jsonString);
      return ids.cast<String>();
    } catch (e) {
      return [];
    }
  }

  Future<void> addCompletedCheckpoint(String checkpointId) async {
    final checkpoints = getCompletedCheckpoints();
    if (!checkpoints.contains(checkpointId)) {
      checkpoints.add(checkpointId);
      await saveCompletedCheckpoints(checkpoints);
    }
  }

  // Achievements
  Future<void> saveAchievements(List<String> achievementIds) async {
    await _preferences?.setString(_keyAchievements, jsonEncode(achievementIds));
  }

  List<String> getAchievements() {
    final jsonString = _preferences?.getString(_keyAchievements);
    if (jsonString == null) return [];

    try {
      final List<dynamic> ids = jsonDecode(jsonString);
      return ids.cast<String>();
    } catch (e) {
      return [];
    }
  }

  Future<void> addAchievement(String achievementId) async {
    final achievements = getAchievements();
    if (!achievements.contains(achievementId)) {
      achievements.add(achievementId);
      await saveAchievements(achievements);
    }
  }

  // Settings
  Future<void> saveLanguage(String languageCode) async {
    await _preferences?.setString(_keyLanguage, languageCode);
  }

  String getLanguage() {
    return _preferences?.getString(_keyLanguage) ?? 'en';
  }

  Future<void> saveThemeMode(String mode) async {
    await _preferences?.setString(_keyThemeMode, mode);
  }

  String getThemeMode() {
    return _preferences?.getString(_keyThemeMode) ?? 'light';
  }

  Future<void> setOnboardingComplete(bool complete) async {
    await _preferences?.setBool(_keyOnboardingComplete, complete);
  }

  bool isOnboardingComplete() {
    return _preferences?.getBool(_keyOnboardingComplete) ?? false;
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    await _preferences?.setBool(_keyNotificationsEnabled, enabled);
  }

  bool areNotificationsEnabled() {
    return _preferences?.getBool(_keyNotificationsEnabled) ?? true;
  }

  // Clear all data
  Future<void> clearAll() async {
    await _preferences?.clear();
  }
}
