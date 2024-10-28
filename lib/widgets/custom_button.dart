// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
     this.onTap, this.color, this.height,
    // this.isLoading = false,
  });
  RxBool isLoading = false.obs;
  final String text;
  final Color? color;
  final double? height;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height??50,
      child: MaterialButton(
        disabledColor: Colors.grey,
        // elevation: 0, // Disable default elevation
        // highlightElevation: 0, // Disable elevation when pressed
        disabledElevation: 0,
        disabledTextColor: Colors.white,
        // hoverColor: Colors.transparent,
        // // highlightElevation: 0,
        //  highlightColor: Colors.transparent,
        // splashColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        colorBrightness: Brightness.dark,
        height: 56,
        color: color?? AppColors.kprimaryColor,
        onPressed:onTap==null?null: !isLoading.value
            ? () async {
                isLoading.value = true;
                try {
                  await onTap!();
                } finally {
                  isLoading.value = false;
                }
              }
            : () {},
        child: Obx(() => Center(
            child: !isLoading.value
                ? FittedBox(child: Text(text,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),))
                : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                ))),
      ),
    );
  }
}
