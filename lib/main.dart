import 'package:easy_localization/easy_localization.dart';
import 'package:control_app/control_app.dart';
import 'package:flutter/material.dart';

import 'package:control_app/services.dart';

void main() async {
  await Services.initialize();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const ControlApp(),
    ),
  );
}
