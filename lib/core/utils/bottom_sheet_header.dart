import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:control_app/core/constants/app_icons.dart';
import 'package:control_app/core/extensions/context_extension.dart';
import 'package:control_app/core/extensions/locale_extensions.dart';
import 'package:control_app/core/helpers/font_weight_helper.dart';
import 'package:control_app/core/helpers/spacing.dart';
import 'package:control_app/core/utils/app_text.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    super.key,
    required this.title,
    this.onTap,
    this.action,
  });

  final String title;
  final VoidCallback? onTap;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 5.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: const Color(0xffE7E9EE),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Spacing.verticalSpace(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                } else {
                  context.pop(context);
                }
              },
              child: SizedBox(
                width: 40.w,
                child: Icon(
                  context.isArabic
                      ? AppIcons.iconArrowRight
                      : AppIcons.iconBack,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: MyTextApp(
                  title: title,
                  size: 18,
                  fontWeight: FontWeightHelper.medium,
                ),
              ),
            ),
            SizedBox(width: 40.w, child: action ?? const SizedBox()),
          ],
        ),
      ],
    );
  }
}
