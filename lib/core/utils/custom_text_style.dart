import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upai/core/utils/default_widget.dart';

import 'app_colors.dart';

class AppTextStyle {
  // Text Styles

  //styles for upai
  static get appBarTitle => TextStyle(
        fontSize: defaultTitleFontSize,
        fontWeight: FontWeight.bold,
        color: AppColors.colorWhite,
      );  static get tapTitle => TextStyle(
        fontSize: default14FontSize,


      );
  static get titleText => TextStyle(fontSize: default12FontSize, fontWeight: FontWeight.w500, color: AppColors.kprimaryColor);
  static get titleTextSmallUnderline => TextStyle(
        decoration: TextDecoration.underline,
        fontSize: default12FontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.appTextColorGrey,
      );
  static get titleTextSmallest => TextStyle(
        fontSize: default10FontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.appTextColorGrey,
      );
  static get titleTextSmall => TextStyle(
        fontSize: default12FontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.appTextColorGrey,
      );
  static get bodyMediumBlackBold => TextStyle(
        fontSize: defaultTitleFontSize,
        fontWeight: FontWeight.bold,
        color: AppColors.colorBlack,
      );
  static get bodyMediumSemiBlackBold => TextStyle(
        fontSize: defaultTitleFontSize,
        // fontWeight: FontWeight.bold,
        color: AppColors.titleName,
      );
  static get bodyMediumBlackSemiBold => TextStyle(
        fontSize: defaultTitleFontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.colorBlack,
      );static get bodyMediumWhiteSemiBold => TextStyle(
        fontSize: default14FontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.colorWhite,
      );
  static get body12BlackSemiBold => TextStyle(
        fontSize: default12FontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.colorWhite,
      );
  static get bodyMedium => TextStyle(
        fontSize: default12FontSize,
        fontWeight: FontWeight.w700,
        color: AppColors.titleName,
      );
  static get bodySmallGrey => TextStyle(
        fontSize: 13.sp,
        // fontWeight: FontWeight.w400,
        color: AppColors.deepGreyColor,
      );
  static get bodySmallblack => TextStyle(
        fontSize: default14FontSize,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  //

  static get bodyLarge => TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.colorBlack,
      );
  static get bodyLargeSemiBlack => TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.titleName,
      );

  static get bodyLarge900 => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.kprimaryColor,
      );  static get textFont14bold => TextStyle(
        fontSize: default14FontSize,
        fontWeight: FontWeight.w700,
        color: AppColors.colorBlack,
      );

  static get bodyLarge700 => TextStyle(
        fontSize: 23.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.colorBlack,
      );

  static get bodyMedium400 => TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.colorGrey,
      );

  static get bodyMediumWhite500 => TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.colorWhite,
      );

  static get bodyMediumblack => TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.colorBlack,
      );
  static get bodyMediumWhite400small => TextStyle(
        fontSize: default14FontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.colorWhite,
      );

  static get bodyMediumBlack400 => TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.colorBlack,
      );

  static get bodyMediumBlue700 => TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.colorWhite,
      );

  static get bodyMediumButton700 => TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.buttonColor2,
      );

  static get bodyMediumTextButton700 => TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.colorBlue,
      );

  static get bodyMediumLightBlack300 => TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w300,
        color: AppColors.colorLightBlack,
      );

  static get bodySmall => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.hintColor,
      );
  static get bodySmallwhite =>  TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      );

  static get bodySmallGrey400 => TextStyle(
        fontSize: default14FontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.titleName,
        // decoration: TextDecoration.lineThrough,
      );

  static get bodySmallBlack400 => TextStyle(
        fontSize: default14FontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.colorBlack,
      ); static get bodySmallBlack600 => TextStyle(
        fontSize: default10FontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.colorBlack,
      );

  static get bodySmallBlack400f15 => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.colorBlack,
      );

  static get bodySmallGrey400S15 => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.deepGreyColor,
      );

  static get bodySmallTextGrey400 => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.colorTextGrey,
      );
  static get bodySmallestTextGrey400 => TextStyle(
        fontSize: default10FontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.colorTextGrey,
      );

  static get bodySmallText2Grey400 => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.colorTextGrey2,
      );

  static get bodySmallText2Grey400s16 => TextStyle(
        fontSize: defaultTitleFontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.colorTextGrey2,
      );

  static get bodyTitle700 => TextStyle(
        fontSize: defaultTitleFontSize,
        fontWeight: FontWeight.w700,
        color: AppColors.colorWhite,
      );
  static get unReadMsgStyle => TextStyle(
    fontSize: default12FontSize,
    fontWeight: FontWeight.w700,
    color: AppColors.colorBlack,
  );

  // Button Styles

  // static get buttonStyle => ButtonStyle(
  //       backgroundColor: WidgetStateProperty.all<Color>(AppColors.primaryColor),
  //       foregroundColor: WidgetStateProperty.all<Color>(AppColors.colorWhite),
  //       minimumSize: WidgetStateProperty.all<Size>(const Size(double.infinity, 60)),
  //       shape: WidgetStateProperty.all<RoundedRectangleBorder>(
  //         RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8.0), // Rounded corners
  //         ),
  //       ),
  //     );
  //
  // static get buttonStyle2 => ButtonStyle(
  //       backgroundColor: WidgetStateProperty.all<Color>(AppColors.buttonColor),
  //       foregroundColor: WidgetStateProperty.all<Color>(AppColors.colorWhite),
  //       minimumSize: WidgetStateProperty.all<Size>(const Size(double.infinity, 60)),
  //       shape: WidgetStateProperty.all<RoundedRectangleBorder>(
  //         RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8.0), // Rounded corners
  //         ),
  //       ),
  //     );
}
