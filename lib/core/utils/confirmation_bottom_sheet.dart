import 'package:control_app/core/utils/bottom_sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:control_app/config/colors/app_colors.dart';
import 'package:control_app/core/helpers/font_weight_helper.dart';
import 'package:control_app/core/helpers/responsive_text.dart';
import 'package:control_app/core/helpers/spacing.dart';
import 'package:control_app/core/utils/app_button.dart';
import 'package:control_app/core/utils/app_text.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  const ConfirmationBottomSheet({
    super.key,
    required this.headerTitle,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryTap,
    required this.onSecondaryTap,
    this.primaryButtonColor = AppColors.kRedColor,
    this.primaryTextColor = AppColors.kWhiteColor,
    this.secondaryButtonColor = AppColors.kWhiteColor,
    this.secondaryTextColor = AppColors.kBlackColor,
  });

  final String headerTitle;
  final String title;
  final String description;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryTap;
  final VoidCallback onSecondaryTap;
  final Color primaryButtonColor;
  final Color primaryTextColor;
  final Color secondaryButtonColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetHeader(title: headerTitle),
          Spacing.verticalSpace(24),
          MyTextApp(
            title: title,
            size: 20,
            fontWeight: FontWeightHelper.medium,
            align: TextAlign.start,
            maxLines: 3,
          ),
          Spacing.verticalSpace(8),
          MyTextApp(
            title: description,
            size: 14,
            fontWeight: FontWeightHelper.regular,
            color: AppColors.kGreyColor,
            align: TextAlign.start,
            maxLines: 3,
          ),
          Spacing.verticalSpace(32),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  height: 52.h,
                  borderRadius: 56,
                  onPressed: onPrimaryTap,
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: primaryTextColor,
                    fontWeight: FontWeightHelper.medium,
                    fontSize: getResponsiveFontSize(context, fontSize: 14),
                  ),
                  text: primaryButtonText,
                  backgroundColor: primaryButtonColor,
                ),
              ),
              Spacing.horizontalSpace(16),
              Expanded(
                child: AppButton(
                  height: 52.h,
                  borderRadius: 56,
                  onPressed: onSecondaryTap,
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: secondaryTextColor,
                    fontWeight: FontWeightHelper.medium,
                    fontSize: getResponsiveFontSize(context, fontSize: 14),
                  ),
                  text: secondaryButtonText,
                  backgroundColor: secondaryButtonColor,
                  borderColor: AppColors.kUnFocusBorderColor,
                ),
              ),
            ],
          ),
          Spacing.verticalSpace(16),
        ],
      ),
    );
  }
}
