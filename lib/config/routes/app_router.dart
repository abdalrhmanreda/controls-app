import 'package:flutter/material.dart';
import '../../features/dashboard/presentation/pages/smart_tv_control_page.dart';
import '../../features/camera/presentation/pages/entrance_camera_page.dart';
import '../../features/auth/presentation/pages/auth_check_page.dart';
import '../../features/auth/presentation/pages/continue_as_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import 'route_names.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (_) => const AuthCheckPage(),
          settings: settings,
        );
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case RouteNames.continueAs:
        final args = settings.arguments as Map<String, dynamic>?;
        final name = args?['name'] as String? ?? '';
        final token = args?['token'] as String? ?? '';
        final profilePictureUrl = args?['profilePictureUrl'] as String?;
        final email = args?['email'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => ContinueAsPage(
            name: name,
            token: token,
            profilePictureUrl: profilePictureUrl,
            email: email,
          ),
          settings: settings,
        );
      case RouteNames.smartTvControl:
        final args = settings.arguments as Map<String, dynamic>?;
        final name = args?['name'] as String? ?? 'User';
        final profilePictureUrl = args?['profilePictureUrl'] as String?;
        final email = args?['email'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => SmartTvControlPage(
            name: name,
            profilePictureUrl: profilePictureUrl,
            email: email,
          ),
          settings: settings,
        );
      case RouteNames.entranceCamera:
        return MaterialPageRoute(
          builder: (_) => const EntranceCameraPage(),
          settings: settings,
        );
      default:
        return null;
    }
  }
}
