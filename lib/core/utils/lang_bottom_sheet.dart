// import 'package:easy_localization/easy_localization.dart';
// import 'package:control_app/core/utils/bottom_sheet_header.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:control_app/config/colors/app_colors.dart';
// import 'package:control_app/core/extensions/locale_extensions.dart';
// import 'package:control_app/core/helpers/font_weight_helper.dart';
// import 'package:control_app/core/helpers/language_provider.dart';
// import 'package:control_app/core/helpers/responsive_text.dart';
// import 'package:control_app/core/utils/app_button.dart';
// import 'package:control_app/core/utils/app_text.dart';
// import 'package:control_app/gen/locale_keys.g.dart';
// import 'package:control_app/generated/assets.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// /// Language Bottom Sheet with LanguageProvider Integration
// class LanguageBottomSheet extends StatefulWidget {
//   const LanguageBottomSheet({super.key});

//   @override
//   State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
// }

// class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
//   late String selectedLanguage;

//   @override
//   void initState() {
//     super.initState();
//     // Get current language from provider
//     selectedLanguage = context.read<LanguageProvider>().currentLanguageCode;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: context.textDirection,
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             BottomSheetHeader(title: LocaleKeys.select_language_title.tr()),
//             // Language Options
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   // English Option
//                   _buildLanguageOption(
//                     flag: Assets.iconsEn,
//                     title: LocaleKeys.english.tr(),
//                     subtitle: LocaleKeys.english.tr(),
//                     languageCode: 'en',
//                     isSelected: selectedLanguage == 'en',
//                   ),
//                   const SizedBox(height: 12),

//                   // Arabic Option
//                   _buildLanguageOption(
//                     flag: Assets.iconsAr,
//                     title: LocaleKeys.arabic.tr(),
//                     subtitle: LocaleKeys.arabic_subtitle.tr(),
//                     languageCode: 'ar',
//                     isSelected: selectedLanguage == 'ar',
//                   ),
//                 ],
//               ),
//             ),

//             // Confirm Button
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: AppButton(
//                   height: 52.h,
//                   onPressed: () async {
//                     // Only proceed if language has changed
//                     final languageProvider = context.read<LanguageProvider>();
//                     if (selectedLanguage !=
//                         languageProvider.currentLanguageCode) {
//                       // Get the layout cubit to update nav indices
//                       // final layoutCubit = context.read<LayoutCubit>();

//                       // Change language using provider
//                       await languageProvider.changeLanguage(
//                         context,
//                         selectedLanguage,
//                       );

//                       // Wait a bit for the locale change to propagate
//                       await Future.delayed(const Duration(milliseconds: 100));

//                       // Update navigation bar indices for new language
//                       if (context.mounted) {
//                         // layoutCubit.updateLanguage(context, selectedLanguage);
//                       }
//                     }
//                     // Close bottom sheet
//                     if (context.mounted) {
//                       Navigator.of(context).pop(selectedLanguage);
//                     }
//                   },
//                   backgroundColor: AppColors.kPrimaryColor,
//                   borderRadius: 56,
//                   text: context.isArabic
//                       ? LocaleKeys.save.tr()
//                       : LocaleKeys.confirm_password.tr(),
//                   textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     color: AppColors.kWhiteColor,
//                     fontSize: getResponsiveFontSize(context, fontSize: 14),
//                     fontWeight: FontWeightHelper.medium,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLanguageOption({
//     required String flag,
//     required String title,
//     required String subtitle,
//     required String languageCode,
//     required bool isSelected,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedLanguage = languageCode;
//         });
//       },
//       child: AnimatedContainer(
//         height: 64.h,
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? AppColors.kBDotColor.withValues(alpha: 0.09)
//               : Colors.white,

//           border: Border.all(
//             color: isSelected ? AppColors.kBDotColor : Colors.grey[300]!,
//             width: 1,
//           ),
//           borderRadius: BorderRadius.circular(64),
//         ),
//         child: Row(
//           children: [
//             SvgPicture.asset(flag, width: 24, height: 24),
//             const SizedBox(width: 16),
//             Expanded(
//               child: MyTextApp(
//                 title: title,
//                 size: 16,
//                 fontWeight: FontWeightHelper.medium,
//                 color: AppColors.kBlackColor,
//               ),
//             ),
//             AnimatedOpacity(
//               duration: const Duration(milliseconds: 200),
//               opacity: isSelected ? 1.0 : 0.0,
//               child: Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   color: isSelected ? AppColors.kBDotColor : Colors.grey[300],
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.check, color: Colors.white, size: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
