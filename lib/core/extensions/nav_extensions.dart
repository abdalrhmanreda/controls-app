import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../animation/animation_transaction.dart';

extension NavigatorExtensions on BuildContext {
  void pushWithScale(Widget page) {
    if (Platform.isIOS) {
      Navigator.push(this, CupertinoPageRoute(builder: (_) => page));
    } else {
      Navigator.push(this, ScaleTransitionPage(page: page));
    }
  }

  void pushReplacementWithScale(Widget page) {
    if (Platform.isIOS) {
      Navigator.pushReplacement(this, CupertinoPageRoute(builder: (_) => page));
    } else {
      Navigator.pushReplacement(this, ScaleTransitionPage(page: page));
    }
  }

  void pushAndRemoveUntilWithScale(Widget page) {
    if (Platform.isIOS) {
      Navigator.pushAndRemoveUntil(
        this,
        CupertinoPageRoute(builder: (_) => page),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        this,
        CupertinoPageRoute(builder: (BuildContext context) => page),
        (route) => false,
      );
    }
  }

  // Navigate with persistent bottom nav bar visible
  void pushWithNavBar(Widget screen) {
    PersistentNavBarNavigator.pushNewScreen(
      this,
      screen: screen,
      withNavBar: true,
    );
  }

  // Navigate without persistent bottom nav bar (for detail screens)
  void pushWithoutNavBar(Widget screen) {
    PersistentNavBarNavigator.pushNewScreen(
      this,
      screen: screen,
      withNavBar: false,
    );
  }
}

// extension ExtensionWidget on Widget {
//   Widget get center => Align(alignment: Alignment.center, child: this);
// }

// // Add this extension to your shared_preferences file
// extension LanguagePrefs on SharedPrefService {
//   static const String _languageKey = 'app_language';
//   static const String _isFirstLaunchKey = 'is_first_launch';

//   // Save selected language
//   Future<void> setLanguage(String languageCode) async {
//     await setString(_languageKey, languageCode);
//   }

//   // Get saved language
//   String? getSavedLanguage() {
//     return getString(_languageKey);
//   }

//   // Check if it's first launch
//   bool isFirstLaunch() {
//     return getBool(_isFirstLaunchKey) ?? true;
//   }

//   // Set first launch flag
//   Future<void> setFirstLaunchDone() async {
//     await setBool(_isFirstLaunchKey, false);
//   }

//   // Remove saved language
//   Future<void> clearLanguage() async {
//     await remove(_languageKey);
//   }
// }
