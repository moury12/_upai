import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';

class SuggestMsgWidget extends StatelessWidget {
  final String suggestMsg;
  const SuggestMsgWidget({
    super.key, required this.suggestMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
          horizontal: 11.52, vertical: 3.84),
      decoration: ShapeDecoration(
        color: const Color(0xFFF7F9FC),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.72),
            side: BorderSide(color: AppColors.strokeColor)),
      ),
      child:  Text(
        suggestMsg,
        style: const TextStyle(
          color: Color(0xFF3F3F3F),
          fontSize: 13,
          fontFamily: 'Epilogue',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}