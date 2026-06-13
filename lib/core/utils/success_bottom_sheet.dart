import 'package:control_app/core/utils/bottom_sheet_header.dart';
import 'package:control_app/core/helpers/app_theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:control_app/config/colors/app_colors.dart';
import 'package:control_app/core/helpers/font_weight_helper.dart';
import 'package:control_app/core/helpers/responsive_text.dart';
import 'package:control_app/core/helpers/spacing.dart';
import 'package:control_app/core/utils/app_button.dart';
import 'package:control_app/core/utils/app_text.dart';
import 'package:control_app/core/extensions/locale_extensions.dart';

class SuccessBottomSheet extends StatelessWidget {
  final String headerTitle;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const SuccessBottomSheet({
    super.key,
    required this.headerTitle,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.textDirection,
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: 16.h,
          top: 8.h,
        ),
        decoration: BoxDecoration(
          color: context.sheetColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomSheetHeader(title: headerTitle),
            Spacing.verticalSpace(32),
            MyTextApp(
              title: title,
              size: 24,
              fontWeight: context.isArabic
                  ? FontWeightHelper.semiBold
                  : FontWeightHelper.medium,
              color: context.textPrimary,
            ),
            Spacing.verticalSpace(8),
            MyTextApp(
              title: description,
              size: 16,
              fontWeight: FontWeightHelper.regular,
              color: AppColors.kGreyColor, // Using Gray for description
              maxLines: 3,
              height: 1.5,
            ),
            Spacing.verticalSpace(32),
            AppButton(
              width: double.infinity,
              height: 52.h,
              borderRadius: 56,
              onPressed: onPressed,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: context.isDarkMode ? Colors.black : AppColors.kWhiteColor,
                fontWeight: FontWeightHelper.medium,
                fontSize: getResponsiveFontSize(context, fontSize: 16),
              ),
              text: buttonText,
              backgroundColor: context.primaryColor,
            ),
            Spacing.verticalSpace(16),
          ],
        ),
      ),
    );
  }
}
