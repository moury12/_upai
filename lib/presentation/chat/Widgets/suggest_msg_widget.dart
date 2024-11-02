import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';

class SuggestMsgWidget extends StatelessWidget {
  final String suggestMsg;
  const SuggestMsgWidget({
    super.key, required this.suggestMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:  EdgeInsets.symmetric(
          horizontal: 12.sp, ),
      decoration: ShapeDecoration(
        color: const Color(0xFFF7F9FC),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.72),
            side: BorderSide(color: AppColors.strokeColor)),
      ),
      child:  Text(
        suggestMsg,
        style:  TextStyle(
          color: Color(0xFF3F3F3F),
          fontSize: default12FontSize,
          fontFamily: 'Epilogue',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}