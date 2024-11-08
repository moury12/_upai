// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.height,
    this.isLoading = false, this.disableColor,
  });

  final String text;
  final bool isLoading;
  final Color? color;
  final Color? disableColor;
  final double? height;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45.w,

      child: MaterialButton(
        disabledColor:disableColor?? Colors.grey,
        disabledElevation: 0,
        disabledTextColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        colorBrightness: Brightness.dark,
        height: 45.w,


        color: color ?? AppColors.kPrimaryColor,
        onPressed: (onTap == null || isLoading) ? null : () => onTap!(),
        child: Center(
          child: isLoading == false
              ? FittedBox(
            child: Text(
              text,
              style:  TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: defaultTitleFontSize,
              ),
            ),
          )
              : const Padding(
            padding: EdgeInsets.all(5.0),
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
