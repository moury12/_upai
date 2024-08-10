import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/TestData/category_data.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/presentation/Explore/service_list_screen.dart';

import '../Model/category_list_model.dart';

class CategotyItemtwo extends StatelessWidget {
  final CategoryList singleCat;
  const CategotyItemtwo({super.key, required this.singleCat});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8,top: 5),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   height: 70,
            //   width: 70,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(100),
            //       border: Border.all(color: AppColors.strokeColor,width: 2)
            //   ),
            //   child: ClipOval(
            //     child: CachedNetworkImage(
            //       imageUrl: catList[0]["image_url"].toString(),
            //       fit: BoxFit.cover,
            //       placeholder: (context, url) => Image.asset(ImageConstant.dummy, fit: BoxFit.cover),
            //       errorWidget: (context, url, error) => Image.asset(ImageConstant.dummy, fit: BoxFit.cover),
            //     ),
            //   ),
            // ),
            // Container(
            //   height: 60,
            //   width: 60,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: AppColors.strokeColor, width: 3),
            //     borderRadius: BorderRadius.circular(100),
            //   ),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(100),
            //     child: CachedNetworkImage(
            //       imageUrl: singleCat.imageUrl.toString(),
            //       fit: BoxFit.cover,
            //       placeholder: (context, url) => Image.asset(ImageConstant.dummy, fit: BoxFit.fill),
            //       errorWidget: (context, url, error) => Image.asset(ImageConstant.dummy, fit: BoxFit.cover),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 5,),
            InkWell(
              onTap: (){
                Get.toNamed(ServiceListScreen.routeName,arguments: singleCat.categoryName.toString());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryTextColor,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                     maxLines: 1,
                    '${singleCat.categoryName}',
                    style: AppTextStyle.bodySmallwhite,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}