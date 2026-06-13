import 'package:control_app/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothProgress extends StatelessWidget {
  const CustomSmoothProgress({
    super.key,
    required this.count,
    required this.controller,
  });
  final int count;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      count: count,

      effect: ExpandingDotsEffect(
        activeDotColor: AppColors.kPrimaryColor,
        dotHeight: 8.h,
        dotWidth: 8.w,
      ), // your preferred effect
      onDotClicked: (index) {},
      controller: controller,
    );
  }
}
