import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/custom_text_style.dart';


  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('select_language'.tr,style: AppTextStyle.bodyMediumBlackSemiBold(context),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English',style:AppTextStyle.bodySmallblack(context) ,),
                onTap: () {
                  Get.updateLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('বাংলা',style:AppTextStyle.bodySmallblack(context) ),
                onTap: () {
                  Get.updateLocale(const Locale('bn'));
                  Navigator.pop(context);
                },
              ),
              // Additional languages can be added here
            ],
          ),
        );
      },
    );
  }