import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final Function() onChange;
  final Color? primary;
  const CustomTextButton({
    super.key, required this.label, required this.onChange, this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            overlayColor:primary?? AppColors.kPrimaryColor,
            foregroundColor:primary?? AppColors.kPrimaryColor
        ),
        onPressed: onChange, child: Text(label,style: TextStyle(fontSize: default14FontSize,fontWeight: FontWeight.w600,),));
  }
}