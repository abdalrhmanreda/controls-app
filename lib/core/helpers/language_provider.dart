// language_provider.dart
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:control_app/core/cache/cache.dart';

class LanguageProvider extends ChangeNotifier {
  static final LanguageProvider _instance = LanguageProvider._internal();

  factory LanguageProvider() => _instance;

  LanguageProvider._internal();

  final SharedPrefService _sharedPref = SharedPrefService();

  // Supported locales
  static const List<Locale> supportedLocales = [Locale('ar'), Locale('en')];

  static const List<String> supportedLanguageCodes = ['ar', 'en'];

  Locale _currentLocale = const Locale('ar');
  bool _isInitialized = false;

  // Getters
  Locale get currentLocale => _currentLocale;

  String get currentLanguageCode => _currentLocale.languageCode;

  bool get isArabic => _currentLocale.languageCode == 'ar';

  bool get isEnglish => _currentLocale.languageCode == 'en';

  bool get isRTL => _currentLocale.languageCode == 'ar';

  bool get isInitialized => _isInitialized;

  // Get device language without context
  String get deviceLanguageCode => ui.window.locale.languageCode;

  // Check if device language is supported
  bool get isDeviceLanguageSupported =>
      supportedLanguageCodes.contains(deviceLanguageCode);

  // Initialize language on app start
  Future<void> initializeLanguage() async {
    try {
      String? savedLanguage = _sharedPref.getString('language');
      bool isFirstLaunch = _sharedPref.getBool('is_first_launch') ?? false;

      if (savedLanguage != null &&
          supportedLanguageCodes.contains(savedLanguage)) {
        // Use saved language
        _currentLocale = Locale(savedLanguage);
        print('✅ Using saved language: $savedLanguage');
      } else if (isFirstLaunch) {
        // First launch: use device language if supported, otherwise Arabic
        String preferredLang = isDeviceLanguageSupported
            ? deviceLanguageCode
            : 'ar';
        _currentLocale = Locale(preferredLang);

        // Save the selected language and mark first launch as done
        await _sharedPref.setString('language', preferredLang);
        await _sharedPref.setBool('is_first_launch', false);

        print(
          '✅ First launch - using: $preferredLang (device: $deviceLanguageCode)',
        );
      } else {
        // Default fallback
        _currentLocale = const Locale('ar');
        await _sharedPref.setString('language', 'ar');
        print('✅ Using default language: ar');
      }

      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      print('❌ Error initializing language: $e');
      _currentLocale = const Locale('ar');
      _isInitialized = true;
      notifyListeners();
    }
  }

  // Change language
  Future<void> changeLanguage(BuildContext context, String languageCode) async {
    if (!supportedLanguageCodes.contains(languageCode)) {
      print('❌ Unsupported language: $languageCode');
      return;
    }

    try {
      Locale newLocale = Locale(languageCode);

      // Change app locale using EasyLocalization
      await context.setLocale(newLocale);

      // Update internal state
      _currentLocale = newLocale;

      // Save to SharedPreferences
      await _sharedPref.setString('language', languageCode);

      print('✅ Language changed to: $languageCode');
      notifyListeners();
    } catch (e) {
      print('❌ Error changing language: $e');
    }
  }

  // Change language without context (for use in main.dart)
  Future<void> setLanguageWithoutContext(String languageCode) async {
    if (!supportedLanguageCodes.contains(languageCode)) return;

    _currentLocale = Locale(languageCode);
    await _sharedPref.setString('language', languageCode);
    print('✅ Language set to: $languageCode');
    notifyListeners();
  }

  // Get startup locale for EasyLocalization
  Locale getStartupLocale() {
    String? savedLanguage = _sharedPref.getString('language');
    bool isFirstLaunch = _sharedPref.getBool('is_first_launch') ?? false;

    if (savedLanguage != null &&
        supportedLanguageCodes.contains(savedLanguage)) {
      return Locale(savedLanguage);
    } else if (isFirstLaunch && isDeviceLanguageSupported) {
      return Locale(deviceLanguageCode);
    } else {
      return const Locale('ar');
    }
  }

  // Reset to device language
  Future<void> resetToDeviceLanguage(BuildContext context) async {
    String deviceLang = isDeviceLanguageSupported ? deviceLanguageCode : 'ar';
    await changeLanguage(context, deviceLang);
  }

  // Clear saved language (for logout/reset)
  Future<void> clearSavedLanguage() async {
    await _sharedPref.remove('language');
    await _sharedPref.remove('is_first_launch');
    print('✅ Language preferences cleared');
  }

  // Get language display name
  String getLanguageDisplayName(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return 'العربية';
      case 'en':
        return 'English';
      default:
        return languageCode.toUpperCase();
    }
  }

  // Get all supported languages with display names
  Map<String, String> get supportedLanguagesWithNames => {
    'ar': 'العربية',
    'en': 'English',
  };
}
