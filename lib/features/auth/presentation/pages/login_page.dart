import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:control_app/config/routes/route_names.dart';
import 'package:control_app/core/di/dependancy_injection.dart';
import 'package:control_app/core/utils/app_button.dart';
import 'package:control_app/core/utils/app_text_form_field.dart';
import 'package:control_app/core/utils/toast_notification.dart';
import 'package:control_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:control_app/features/auth/presentation/cubit/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AuthCubit _authCubit;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning 👋';
    if (hour < 17) return 'Good Afternoon 👋';
    return 'Good Evening 👋';
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      _authCubit.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
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
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ModernSnackBar.show(
              context,
              message: 'Logged in successfully',
              type: SnackBarType.success,
            );
            Navigator.pushReplacementNamed(
              context,
              RouteNames.smartTvControl,
              arguments: {
                'name': state.user.fullName,
                'profilePictureUrl': state.user.profilePicture,
                'email': state.user.email,
              },
            );
          } else if (state is AuthError) {
            String displayError = state.message;
            if (displayError.contains('DioException') || displayError.contains('500')) {
              displayError = 'Server error or incorrect email/password. Please try again.';
            }
            ModernSnackBar.show(
              context,
              message: displayError,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            backgroundColor: kBg,
            body: Stack(
              children: [
                // Soft background ambient blobs
                Positioned(
                  top: -60.h,
                  left: -60.w,
                  child: Container(
                    width: 220.w,
                    height: 220.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kGreen.withValues(alpha: 0.25),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50.h,
                  right: -50.w,
                  child: Container(
                    width: 180.w,
                    height: 180.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD47B72).withValues(alpha: 0.15),
                    ),
                  ),
                ),

                // Main Content
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),
                            // Premium Header Section
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 76.w,
                                    height: 76.w,
                                    decoration: BoxDecoration(
                                      color: kDark,
                                      borderRadius: BorderRadius.circular(22.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: kDark.withValues(alpha: 0.12),
                                          blurRadius: 20,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Iconsax.home_2_copy,
                                      color: kGreen,
                                      size: 34.sp,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'Control App',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w900,
                                      color: kDark,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    'SMART HOME DASHBOARD',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w800,
                                      color: kMuted,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 32.h),

                            // Login Card
                            Container(
                              padding: EdgeInsets.all(26.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32.r),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: kDark.withValues(alpha: 0.04),
                                    blurRadius: 24,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getGreeting(),
                                    style: GoogleFonts.urbanist(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: kDark,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Enter your credentials to manage your home',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 13.sp,
                                      color: kMuted,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),

                                  // Email Input Label
                                  Text(
                                    'Email Address',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800,
                                      color: kDark.withValues(alpha: 0.8),
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  // Email TextFormField
                                  AppTextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    hintText: 'name@company.com',
                                    borderRadius: 16.r,
                                    filled: true,
                                    fillColor: kSurface,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: const BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: const BorderSide(color: kDark, width: 1.5),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                                    ),
                                    enabled: !isLoading,
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      size: 20.sp,
                                      color: kDark.withValues(alpha: 0.4),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      final emailRegex = RegExp(
                                        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                                      );
                                      if (!emailRegex.hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 18.h),

                                  // Password Input Label
                                  Text(
                                    'Password',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800,
                                      color: kDark.withValues(alpha: 0.8),
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  // Password TextFormField
                                  AppTextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    textInputAction: TextInputAction.done,
                                    hintText: '••••••••',
                                    borderRadius: 16.r,
                                    filled: true,
                                    fillColor: kSurface,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: const BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: const BorderSide(color: kDark, width: 1.5),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                                    ),
                                    enabled: !isLoading,
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      size: 20.sp,
                                      color: kDark.withValues(alpha: 0.4),
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                      child: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        size: 20.sp,
                                        color: kDark.withValues(alpha: 0.4),
                                      ),
                                    ),
                                    onFieldSubmitted: (_) => _onLoginPressed(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16.h),

                                  // Remember Me & Forgot Password Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20.w,
                                            height: 20.w,
                                            child: Checkbox(
                                              value: _rememberMe,
                                              activeColor: kDark,
                                              checkColor: kGreen,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(6.r),
                                              ),
                                              side: const BorderSide(color: kMuted, width: 1.5),
                                              onChanged: (val) {
                                                setState(() {
                                                  _rememberMe = val ?? false;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            'Remember me',
                                            style: GoogleFonts.urbanist(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kDark.withValues(alpha: 0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          ModernSnackBar.show(
                                            context,
                                            message: 'Reset link sent to your email address',
                                            type: SnackBarType.info,
                                          );
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: GoogleFonts.urbanist(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: kDark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 28.h),

                                  // Sign In Button
                                  AppButton(
                                    text: 'Log In',
                                    backgroundColor: kDark,
                                    foregroundColor: kGreen,
                                    width: double.infinity,
                                    height: 52.h,
                                    borderRadius: 16.r,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    isLoading: isLoading,
                                    onPressed: _onLoginPressed,
                                  ),
                                  SizedBox(height: 24.h),

                                  // Divider
                                  Row(
                                    children: [
                                      Expanded(child: Divider(color: kSurface, thickness: 1.5)),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                                        child: Text(
                                          'or sign in with',
                                          style: GoogleFonts.urbanist(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                            color: kMuted,
                                          ),
                                        ),
                                      ),
                                      Expanded(child: Divider(color: kSurface, thickness: 1.5)),
                                    ],
                                  ),
                                  SizedBox(height: 18.h),

                                  // Social Logins
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton.icon(
                                          onPressed: () {
                                            ModernSnackBar.show(
                                              context,
                                              message: 'Google Sign In clicked',
                                              type: SnackBarType.info,
                                            );
                                          },
                                          icon: Icon(Icons.g_mobiledata_rounded, size: 24.sp, color: kDark),
                                          label: Text(
                                            'Google',
                                            style: GoogleFonts.urbanist(
                                              fontWeight: FontWeight.bold,
                                              color: kDark,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(color: kSurface, width: 1.5),
                                            padding: EdgeInsets.symmetric(vertical: 12.h),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16.r),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: OutlinedButton.icon(
                                          onPressed: () {
                                            ModernSnackBar.show(
                                              context,
                                              message: 'Apple Sign In clicked',
                                              type: SnackBarType.info,
                                            );
                                          },
                                          icon: Icon(Icons.apple_rounded, size: 20.sp, color: kDark),
                                          label: Text(
                                            'Apple',
                                            style: GoogleFonts.urbanist(
                                              fontWeight: FontWeight.bold,
                                              color: kDark,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(color: kSurface, width: 1.5),
                                            padding: EdgeInsets.symmetric(vertical: 12.h),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16.r),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
