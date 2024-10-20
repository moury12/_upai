import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';

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
            overlayColor:primary?? AppColors.kprimaryColor,
            foregroundColor:primary?? AppColors.kprimaryColor
        ),
        onPressed: onChange, child: Text(label));
  }
}