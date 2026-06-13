import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:control_app/config/colors/app_colors.dart';
import 'package:control_app/core/utils/app_text_form_field.dart';

/// A reusable multiline text input with a bordered container.
/// Used in report sheets, block instructor, and other feedback forms.
class MultilineTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final double? height;

  const MultilineTextInput({
    super.key,
    required this.controller,
    this.hintText,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: height ?? 150.h,
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.kUnFocusBorderColor),
        ),
        child: AppTextFormField(
          controller: controller,
          maxLines: null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          fillColor: AppColors.kWhiteColor,
          filled: true,
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.kGreyColor, fontSize: 14.sp),
        ),
      ),
    );
  }
}
