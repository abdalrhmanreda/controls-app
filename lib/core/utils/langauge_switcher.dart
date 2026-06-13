import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:control_app/config/colors/app_colors.dart';
import 'package:control_app/core/extensions/locale_extensions.dart';
import 'package:control_app/core/helpers/font_weight_helper.dart';
import 'package:control_app/core/helpers/spacing.dart';
import 'package:control_app/core/utils/app_text.dart';
import 'package:control_app/gen/locale_keys.g.dart';

class LangaugeSwitcher extends StatelessWidget {
  const LangaugeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.textDirection,
      child: GestureDetector(
        onTap: () {
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) {
          //     return const LanguageBottomSheet();
          //   },
          // );
        },
        child: Container(
          width: 93.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.kWhiteColor.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextApp(
                title: context.isArabic
                    ? LocaleKeys.english.tr()
                    : LocaleKeys.arabic.tr(),
                color: AppColors.kPrimaryColor,
                size: 14,
                fontFamily: FontFamilyHelper.fontFamilyAr,
                fontWeight: context.isArabic
                    ? FontWeightHelper.medium
                    : FontWeightHelper.semiBold,
              ),
              Spacing.horizontalSpace(3.5),
            ],
          ),
        ),
      ),
    );
  }
}
