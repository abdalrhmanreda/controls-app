import 'package:flutter/material.dart';

/// App color constants following the modern motivating color scheme
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  static const Color kPrimaryColor = Color(0xff000000);
  static const Color kPrimaryFontColor = Color(0xff08061d);
  static const Color kPrimaryDark = Color(0xff1B3C53);
  static const Color kPrimaryMedium = Color(0xff234C6A);
  static const Color kPrimaryLight = Color(0xff456882);
  static const Color kAccentWhite = Color(0xFFFFFFFF);
  static const Color kPrimaryDarkest = Color(0xff0F2436);
  static const Color kPrimaryLightest = Color(0xff5A7A94);
  static const Color kPrimarySoft = Color(0xFF6B8AA4);
  static const Color kDarkPrimaryColor = Color(0xff2c3e50);
  static const Color kGoldColor = Color(0xffffae00);
  static const Color kProfileCircleColor = Color(0xff86b494);
  static const Color kWhiteColor = Color(0xffffffff);
  static const Color kBlackColor = Color(0xff000000);
  static const Color kDarkThemColor = Color(0xff1f2630);
  static const Color kLoginWithGoogleColor = Color(0xffebe7e8);
  static const Color kAppBarColor = Color(0xff303030);
  static const Color kGreyColor = Color(0xff82898d);
  static const Color kGreyWriteColor = Color(0xff7A767F);
  static const Color kOrangeColor = Color(0xffff6900);
  static const Color kSkyBlueColor = Color(0xffe5eff5);
  static const Color kScaffoldBackGroundColor = Color(0xffecf3f9);
  static const Color kLabelOfSearchTextFromFeildColor = Color(0xffb2dbf5);
  static const Color kOnBoardingDesc = Color(0xffD8D8D8);
  static const Color kPriceColor = Color(0xff6A6A6A);
  static const Color kProfileCircleAvatarColor = Color(0xff425b77);
  static const Color kIconMap = Color(0xff0070fc);
  static const Color konBoardingAppBarColor = Color(0xfff6f6f6);
  static const Color klightGrey = Color(0xfff6f6f6);
  static const Color kUnFocusBorderColor = Color(0xffEDEDED);
  static const Color kHintTextColor = Color(0xffC2C2C2);
  static const Color kBlueColor = Color(0xff0088ff);
  static const Color kBackgroundHintTextColor = Color(0xfffdfdff);
  static const Color kGrayColor = Color(0xffbebebe);
  static const Color kAlreadyHaveAccountColor = Color(0xffA0A0A0);
  static const Color starColor = Color(0xffFF6042);
  static const Color kDarkSkyBlueColor = Color(0xff80acc1);
  static const Color kLightGreyColor = Color(0xfff1f1f1);
  static const Color kScaffoldColor = Color(0xfffaf7f7);
  static const Color kAmberColor = Color(0xffffc107);
  static const Color kRedColor = Color(0xfff55157);
  static const Color kDarkBlue = Color(0xFF334a5c);
  static const Color kBlueGrey = Color(0xFF3c5b62);
  static const Color kMapColor = Color(0xff2d313f);
  static const Color kPurpleColor = Color(0xff717fff);
  static const Color kGreenColor = Color(0xff4caf50);
  static const Color kUnSelectedCircleIndictiorColor = Color(0xff90a6a7);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color kUnActiveNavBarItemColor = Color(0xff212222);
  static const Color kBlueColorWithOpacity = Color(0xffb1daff);
  static const Color kSelectedCircleIndictiorColor = Color(0xff0088ff);
  static const Color kBDotColor = Color(0xff0F7EE5);
  static const Color kBinkBorderColor = Color(0xffFEBBAD);
  static const Color kPurpleBorderColor = Color(0xffB9BFFF);
  static const Color kWarmingAlertColor = Color(0xffFBC401);
  static const Color kSemiBlackColor = Color(0xff141517);
  static const Color kBlueProgressColor = Color(0xff0088FE);
  static const Color kLimeColor = Color(0xffC6FF00); // Bright lime for actions
  static const Color kLightLimeColor = Color(0xffF1FFC4); // Light background for selection

  static const Color kBodyAnswerColor = Color(0xFFECF3F8);

  static const Color kBodyAptitudeTestColor = Color(0xffE6F3FF);
  static const Color kSecondCounterColor = Color(0xff33A0FE);
  static const Color kIconPaymentColor = Color(0xff54AFFE);

  static List<Color> getGradientColors() {
    return [
      kPrimaryColor,
      kPrimaryColor.withValues(alpha: 0.8),
      kPrimaryColor.withValues(alpha: 0.6),
    ];
  }
}
