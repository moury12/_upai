import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upai/core/utils/default_widget.dart';

import 'app_colors.dart';

class AppTextStyle {
  // Text Styles

  static TextStyle appBarTitle(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: ScreenUtil().screenWidth > ScreenUtil().screenHeight
          ? default14FontSize
          : defaultTitleFontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.colorWhite,
    );
  }

  static TextStyle tapTitle(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default14FontSize,
    );
  }

  static TextStyle titleText(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default12FontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.kPrimaryColor,
    );
  }

  static TextStyle titleTextSmallUnderline(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      decoration: TextDecoration.underline,
      fontSize: default12FontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.appTextColorGrey,
    );
  }

  static TextStyle titleTextSmallest(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default10FontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.appTextColorGrey,
    );
  }

  static TextStyle titleTextSmall(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default12FontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.appTextColorGrey,
    );
  }

  static TextStyle bodyMediumBlackBold(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.colorBlack,
    );
  }

  static TextStyle bodyMediumSemiBlackBold(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      color: AppColors.titleName,
    );
  }

  // Continue this pattern for each remaining TextStyle method

  static TextStyle unReadMsgStyle(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default12FontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.colorBlack,
    );
  }
  static TextStyle bodyMediumBlackSemiBold(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.colorBlack,
    );
  }

  static TextStyle bodyMediumWhiteSemiBold(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default14FontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.colorWhite,
    );
  }

  static TextStyle body12BlackSemiBold(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default12FontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.colorWhite,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default12FontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.titleName,
    );
  }

  static TextStyle bodySmallGrey(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 13.sp,
      color: AppColors.deepGreyColor,
    );
  }

  static TextStyle bodySmallblack(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default14FontSize,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 25.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.colorBlack,
    );
  }

  static TextStyle bodyLargeSemiBlack(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 25.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.titleName,
    );
  }

  static TextStyle bodyLarge900(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.kPrimaryColor,
    );
  }

  static TextStyle textFont14bold(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default14FontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.colorBlack,
    );
  }

  static TextStyle bodyLarge700(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 23.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.colorBlack,
    );
  }

  static TextStyle bodyMedium400(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.colorGrey,
    );
  }

  static TextStyle bodyMediumWhite500(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.w500,
      color: AppColors.colorWhite,
    );
  }

  static TextStyle bodyMediumblack(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.colorBlack,
    );
  }

  static TextStyle bodyMediumWhite400small(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default14FontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.colorWhite,
    );
  }

  static TextStyle bodyMediumBlack400(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.colorBlack,
    );
  }

  static TextStyle bodyMediumBlue700(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.colorWhite,
    );
  }

  static TextStyle bodyMediumButton700(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.buttonColor2,
    );
  }

  static TextStyle bodyMediumTextButton700(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.colorBlue,
    );
  }

  static TextStyle bodyMediumLightBlack300(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.w300,
      color: AppColors.colorLightBlack,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.hintColor,
    );
  }

  static TextStyle bodySmallwhite(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );
  }

  static TextStyle bodySmallGrey400(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default14FontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.titleName,
    );
  }

  static TextStyle font12grey400(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default12FontSize,
      fontWeight: FontWeight.w400,
      color: Colors.grey.shade700,
    );
  }

  static TextStyle bodySmallBlack400(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default14FontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.colorBlack,
    );
  }

  static TextStyle bodySmallBlack600(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default10FontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.colorBlack,
    );
  }

  static TextStyle bodySmallBlack400f15(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.colorBlack,
    );
  }

  static TextStyle bodySmallGrey400S15(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.deepGreyColor,
    );
  }

  static TextStyle bodySmallTextGrey400(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.colorTextGrey,
    );
  }

  static TextStyle bodySmallestTextGrey400(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: default10FontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.colorTextGrey,
    );
  }

  static TextStyle bodySmallText2Grey400(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.colorTextGrey2,
    );
  }

  static TextStyle bodySmallText2Grey400s16(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.w400,
      color: AppColors.colorTextGrey2,
    );
  }

  static TextStyle bodyTitle700(BuildContext context) {
    ScreenUtil.init(context);
    return TextStyle(
      fontSize: defaultTitleFontSize,
      fontWeight: FontWeight.w700,
      color: AppColors.colorWhite,
    );
  }
}

