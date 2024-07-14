// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    // this.isLoading = false,
  });
  RxBool isLoading = false.obs;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ) ,
        colorBrightness: Brightness.dark,
        height: 56,
        color: AppColors.BTNbackgroudgrey,
        onPressed: !isLoading.value
            ? () async {
                isLoading.value = true;
                try {
                  await onTap();
                } finally {
                  isLoading.value = false;
                }
              }
            : () {},
        child: Obx(() => Center(
            child: !isLoading.value
                ? Text(text)
                : const CircularProgressIndicator(
                    color: Colors.white,
                  ))),
      ),
    );
  }
}