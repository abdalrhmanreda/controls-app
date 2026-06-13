// Example: How to use LocaleExtensions in your app
//
// Import the extension:
// import 'package:control_app/core/extensions/locale_extensions.dart';
//
// Then use it in any widget's build method:

import 'package:control_app/core/extensions/locale_extensions.dart';
import 'package:flutter/material.dart';

class ExampleUsageScreen extends StatelessWidget {
  const ExampleUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Check if current language is Arabic
    if (context.isArabic) {
      // Do something for Arabic users
    }

    // ✅ Check if current language is English
    if (context.isEnglish) {
      // Do something for English users
    }

    // ✅ Get text direction automatically
    return Directionality(
      textDirection: context.textDirection,
      child: const Scaffold(),
    );

    // ✅ Check RTL/LTR
    // final isRightToLeft = context.isRTL;
    // final isLeftToRight = context.isLTR;

    // ✅ Get language code
    // final code = context.languageCode; // returns 'ar' or 'en'

    // ✅ Use in conditions
    // final imageAsset = context.isArabic ? 'ar_image' : 'en_image';
    // final fontSize = context.isArabic ? 18.0 : 16.0;
  }
}
