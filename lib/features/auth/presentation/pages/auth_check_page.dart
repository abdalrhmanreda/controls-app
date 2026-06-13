import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:control_app/config/routes/route_names.dart';
import 'package:control_app/core/di/dependancy_injection.dart';
import 'package:control_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:control_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> with SingleTickerProviderStateMixin {
  late AuthCubit _authCubit;
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _authCubit.checkAuthStatus();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const kBg = Color(0xFFE8EAD8);
    const kDark = Color(0xFF1A1E17);
    const kGreen = Color(0xFFA8C37A);

    return BlocProvider<AuthCubit>.value(
      value: _authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ProfileCheckSuccess) {
            Navigator.pushReplacementNamed(
              context,
              RouteNames.continueAs,
              arguments: {
                'name': state.user.fullName,
                'token': state.token,
                'profilePictureUrl': state.user.profilePicture,
                'email': state.user.email,
              },
            );
          } else if (state is ProfileCheckFailure) {
            Navigator.pushReplacementNamed(context, RouteNames.login);
          } else if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(
              context,
              RouteNames.smartTvControl,
              arguments: {
                'name': state.user.fullName,
                'profilePictureUrl': state.user.profilePicture,
                'email': state.user.email,
              },
            );
          }
        },
        child: Scaffold(
          backgroundColor: kBg,
          body: Stack(
            children: [
              // Ambient background blobs
              Positioned(
                top: -100.h,
                right: -100.w,
                child: Container(
                  width: 280.w,
                  height: 280.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kGreen.withValues(alpha: 0.25),
                  ),
                ),
              ),
              Positioned(
                bottom: -80.h,
                left: -80.w,
                child: Container(
                  width: 240.w,
                  height: 240.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFD47B72).withValues(alpha: 0.12),
                  ),
                ),
              ),

              // Main Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Pulsing Glowing App Icon
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: Container(
                        width: 96.w,
                        height: 96.w,
                        decoration: BoxDecoration(
                          color: kDark,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: kGreen.withValues(alpha: 0.3),
                              blurRadius: 28,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.dashboard_customize_outlined,
                          color: kGreen,
                          size: 40.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 54.h),
                    
                    // Loading Spinner
                    SizedBox(
                      width: 28.w,
                      height: 28.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(kDark),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    
                    // App title & loading status text
                    Text(
                      'CONTROL APP',
                      style: GoogleFonts.urbanist(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w900,
                        color: kDark,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Establishing secure connection...',
                      style: GoogleFonts.urbanist(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: kDark.withValues(alpha: 0.5),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
