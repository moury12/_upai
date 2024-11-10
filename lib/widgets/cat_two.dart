import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/presentation/service-list/service_list_screen.dart';

import '../Model/category_list_model.dart';
import 'dart:math';

class CategotyItemtwo extends StatelessWidget {
  final CategoryList singleCat;
  final int? maxline;
  const CategotyItemtwo({super.key, required this.singleCat, this.maxline});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 5),
      child: InkWell(
        onTap: () {
          Get.to(ServiceListScreen(
            selectedCat: singleCat.categoryName.toString(),
          ));
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.kPrimaryColor
              /*Color.fromARGB(235, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256),
            ).withOpacity(.2)*/
              ,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              maxLines: maxline ?? 1,
              '${singleCat.categoryName}',
              style: AppTextStyle.body12BlackSemiBold(context),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
