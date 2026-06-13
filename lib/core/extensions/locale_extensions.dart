import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';

/// Extension on BuildContext to provide easy locale checks
extension LocaleExtensions on BuildContext {
  /// Check if current locale is Arabic
  bool get isArabic => locale.languageCode == 'ar';

  /// Check if current locale is English
  bool get isEnglish => locale.languageCode == 'en';

  /// Check if current text direction is RTL (Right-to-Left)
  bool get isRTL => locale.languageCode == 'ar';

  /// Check if current text direction is LTR (Left-to-Right)
  bool get isLTR => !isRTL;

  /// Get current language code
  String get languageCode => locale.languageCode;

  /// Get TextDirection based on current locale
  TextDirection get textDirection =>
      isRTL ? TextDirection.rtl : TextDirection.ltr;
}
