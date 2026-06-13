import 'package:easy_localization/easy_localization.dart';
import 'package:control_app/config/themes/app_theme.dart';
import 'package:control_app/config/colors/app_colors.dart';
import 'package:control_app/core/helpers/theme_cubit.dart';
import 'package:control_app/core/utils/app_button.dart';
import 'package:control_app/core/utils/toast_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:control_app/config/routes/app_router.dart';
import 'package:control_app/features/auth/presentation/pages/auth_check_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ControlApp extends StatelessWidget {
  const ControlApp({super.key});

  static final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit()..loadTheme(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                title: 'Control App',
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                home: const AuthCheckPage(),
                onGenerateRoute: _appRouter.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}

class ControlAppDashboard extends StatelessWidget {
  const ControlAppDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [const Color(0xFF0F172A), const Color(0xFF1E293B)]
                : [const Color(0xFFF8FAFC), const Color(0xFFE2E8F0)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: isDark ? Colors.white70 : Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Control App',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                color: isDark
                                    ? Colors.white
                                    : AppColors.kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    // Theme Toggle Button
                    Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black.withValues(alpha: 0.1),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isDark ? Icons.light_mode : Icons.dark_mode,
                          color: isDark
                              ? Colors.amber
                              : AppColors.kPrimaryColor,
                        ),
                        onPressed: () {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Architecture Status Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.04)
                        : Colors.white.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.black.withValues(alpha: 0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.2 : 0.05,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.dashboard_customize_outlined,
                            color: isDark
                                ? Colors.blueAccent
                                : AppColors.kBlueColor,
                            size: 28.sp,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Architecture Booted',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.white
                                      : AppColors.kPrimaryColor,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Core architecture components are set up and imported successfully. '
                        'The dependency injection, theme configuration, networking interfaces, '
                        'and local caching services are fully functional and ready.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? Colors.white70
                              : Colors.black.withValues(alpha: 0.85),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                // Section Title
                Text(
                  'Ready Foundations',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? Colors.white70
                        : Colors.black.withValues(alpha: 0.85),
                  ),
                ),
                SizedBox(height: 16.h),

                // Architecture Grid Items
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1.3,
                    children: [
                      _buildGridCard(
                        context,
                        icon: Icons.api,
                        title: 'API Client',
                        subtitle: 'Dio + Retrofit',
                        isDark: isDark,
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.layers,
                        title: 'Bloc/Cubit',
                        subtitle: 'State Mgmt',
                        isDark: isDark,
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.room_preferences,
                        title: 'GetIt DI',
                        subtitle: 'Service Locator',
                        isDark: isDark,
                      ),
                      _buildGridCard(
                        context,
                        icon: Icons.translate,
                        title: 'Localization',
                        subtitle: 'Easy Localization',
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),

                // Bottom CTA Button
                SafeArea(
                  top: false,
                  child: AppButton(
                    onPressed: () {
                      ModernSnackBar.show(
                        context,
                        message: 'Ready to build features in lib/features!',
                        type: SnackBarType.success,
                      );
                    },
                    text: 'Get Started Coding',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDark,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.02)
            : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isDark ? Colors.blueAccent : AppColors.kBlueColor,
            size: 24.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark
                  ? Colors.white
                  : Colors.black.withValues(alpha: 0.85),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white38 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
