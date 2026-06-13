import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:control_app/config/routes/route_names.dart';
import 'package:control_app/core/di/dependancy_injection.dart';
import 'package:control_app/core/utils/app_button.dart';
import 'package:control_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:control_app/features/auth/presentation/cubit/auth_state.dart';

import 'package:control_app/core/api/api_constant.dart';

class ContinueAsPage extends StatefulWidget {
  final String name;
  final String token;
  final String? profilePictureUrl;
  final String email;

  const ContinueAsPage({
    super.key,
    required this.name,
    required this.token,
    this.profilePictureUrl,
    required this.email,
  });

  @override
  State<ContinueAsPage> createState() => _ContinueAsPageState();
}

class _ContinueAsPageState extends State<ContinueAsPage> {
  late AuthCubit _authCubit;
  bool _isClearing = false;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) {
    const kBg = Color(0xFFE8EAD8);
    const kDark = Color(0xFF1A1E17);
    const kGreen = Color(0xFFA8C37A);
    const kSurface = Color(0xFFF2F3ED);
    const kMuted = Color(0xFF9E9E8E);

    return BlocProvider<AuthCubit>.value(
      value: _authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ProfileCheckFailure) {
            Navigator.pushReplacementNamed(context, RouteNames.login);
          }
        },
        child: Scaffold(
          backgroundColor: kBg,
          body: Stack(
            children: [
              // Ambient background blobs
              Positioned(
                top: -80.h,
                right: -80.w,
                child: Container(
                  width: 240.w,
                  height: 240.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kGreen.withValues(alpha: 0.25),
                  ),
                ),
              ),
              Positioned(
                bottom: -60.h,
                left: -60.w,
                child: Container(
                  width: 200.w,
                  height: 200.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFD47B72).withValues(alpha: 0.12),
                  ),
                ),
              ),

              // Main Content
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // App Icon Header in rounded container
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: kDark,
                              borderRadius: BorderRadius.circular(18.r),
                              boxShadow: [
                                BoxShadow(
                                  color: kDark.withValues(alpha: 0.1),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Icon(
                              Iconsax.element_3_copy,
                              color: kGreen,
                              size: 32.sp,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            'Control App',
                            style: GoogleFonts.urbanist(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w900,
                              color: kDark,
                              letterSpacing: 0.8,
                            ),
                          ),
                          SizedBox(height: 38.h),

                          // Profile Card
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(36.r),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.6),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: kDark.withValues(alpha: 0.04),
                                  blurRadius: 32,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Double Ring Profile Avatar
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Outer ring
                                    Container(
                                      width: 98.w,
                                      height: 98.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: kGreen.withValues(alpha: 0.4),
                                          width: 2.w,
                                        ),
                                      ),
                                    ),
                                    // Inner avatar container
                                    Container(
                                      width: 86.w,
                                      height: 86.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kSurface,
                                        border: Border.all(color: Colors.white, width: 3.w),
                                        boxShadow: [
                                          BoxShadow(
                                            color: kDark.withValues(alpha: 0.1),
                                            blurRadius: 16,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: _buildAvatarImage(widget.profilePictureUrl, kDark),
                                      ),
                                    ),
                                    // Verification Check badge
                                    Positioned(
                                      bottom: 2.h,
                                      right: 2.w,
                                      child: Container(
                                        padding: EdgeInsets.all(4.w),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF8FBF5A),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),

                                // Secure session pill badge
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: kGreen.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6.w,
                                        height: 6.w,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF8FBF5A),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        'SECURE SESSION',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w800,
                                          color: kDark.withValues(alpha: 0.8),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 14.h),
                                Text(
                                  'Welcome Back',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 13.sp,
                                    color: kMuted,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  widget.name,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w900,
                                    color: kDark,
                                  ),
                                ),
                                if (widget.email.isNotEmpty) ...[
                                  SizedBox(height: 4.h),
                                  Text(
                                    widget.email,
                                    style: GoogleFonts.urbanist(
                                      fontSize: 13.sp,
                                      color: kMuted,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                                SizedBox(height: 24.h),

                                // Security credential banner
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: kSurface.withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Iconsax.security_safe_copy,
                                        color: kDark.withValues(alpha: 0.7),
                                        size: 18.sp,
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Authenticated via Easy Parking',
                                              style: GoogleFonts.urbanist(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: kDark,
                                              ),
                                            ),
                                            SizedBox(height: 1.h),
                                            Text(
                                              'Keychain login is active and encrypted.',
                                              style: GoogleFonts.urbanist(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                                color: kMuted,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 28.h),

                                // Continue Button
                                AppButton(
                                  text: 'Continue as ${widget.name.split(" ").first}',
                                  backgroundColor: kDark,
                                  foregroundColor: kGreen,
                                  width: double.infinity,
                                  height: 52.h,
                                  borderRadius: 16.r,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      RouteNames.smartTvControl,
                                      arguments: {
                                        'name': widget.name,
                                        'profilePictureUrl': widget.profilePictureUrl,
                                        'email': widget.email,
                                      },
                                    );
                                  },
                                ),
                                SizedBox(height: 12.h),

                                // Switch Account Button
                                AppButton(
                                  text: 'Switch Account',
                                  type: AppButtonType.text,
                                  foregroundColor: kDark.withValues(alpha: 0.8),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  isLoading: _isClearing,
                                  onPressed: () async {
                                    setState(() => _isClearing = true);
                                    await _authCubit.logout();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarImage(String? url, Color kDark) {
    if (url == null || url.isEmpty) {
      return Icon(
        Iconsax.user_copy,
        color: kDark.withValues(alpha: 0.6),
        size: 48.sp,
      );
    }

    // Resolve relative URL
    String fullUrl = url;
    if (url.startsWith('/')) {
      fullUrl = '${ApiConstant.baseUrl}${url.substring(1)}';
    } else if (!url.startsWith('http')) {
      fullUrl = '${ApiConstant.baseUrl}$url';
    }

    return Image.network(
      fullUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(kDark),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Iconsax.user_copy,
          color: kDark.withValues(alpha: 0.6),
          size: 48.sp,
        );
      },
    );
  }
}
