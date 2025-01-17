import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/presentation/home/home_screen.dart';
import 'package:upai/presentation/home/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/seller-service/my_service_details.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';
import 'package:upai/presentation/seller-service/seller_running_order_list_screen.dart';
import 'package:upai/widgets/custom_appbar.dart';
import 'package:upai/widgets/custom_text_field.dart';

import 'widgets/my_service_widget.dart';

class MyServiceListScreen extends StatelessWidget {
  final List<MyService> service;
  const MyServiceListScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns and aspect ratio dynamically
    int crossAxisCount = 2;

    if (screenWidth > 600) {
      crossAxisCount = 2;
    }
    if (screenWidth > 900) {
      crossAxisCount = 3;
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        SellerProfileController.to.searchMyServiceController.value.clear();
        SellerProfileController.to.filterMyService('');
        // controller.searchController.value.clear();
        //
        // controller.filterOffer('');
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(title: "my_offers".tr,),
          body: RefreshIndicator(
            color: AppColors.kPrimaryColor,
            backgroundColor: Colors.white,
            onRefresh: () => SellerProfileController.to.refreshAllData(),
            child: Column(
              children: [
                Padding(
                    padding:  EdgeInsets.symmetric(
                            horizontal: 8.sp, vertical: 12.sp)
                        .copyWith(bottom: 0),
                    child: Obx(() {
                      return CustomTextField(
                        controller: SellerProfileController
                            .to.searchMyServiceController.value,
                        hintText: "${'search_service'.tr}..",
                        onChanged: (value) {},
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: AppColors.kPrimaryColor,
                          ),
                          onPressed: () {
                            SellerProfileController
                                .to.searchMyServiceController.value
                                .clear();
                            SellerProfileController.to.filterMyService('');
                            // controller.searchController.value.clear();
                            // controller.filterOffer('');
                          },
                        ),
                      );
                    })),
                Expanded(child: Obx(() {
                  return !NetworkController.to.connectedInternet.value
                      ? Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.sp,vertical: 8.sp),
                          child: ShimmerOfferList(
                            fromServiceList: true,
                          ),
                        )
                      : SellerProfileController.to.filterList.isEmpty
                          ? NoServiceWidget()
                          : GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.sp, vertical: 8.sp),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount, // Adjust crossAxisCount based on screen width
                                    childAspectRatio: ScreenUtil().screenWidth > ScreenUtil().screenHeight ? 0.5 : 0.9, // Change ratio based on screen width
                                    crossAxisSpacing: 8.w, // Makes spacing responsive
                                    mainAxisSpacing: 8.w,),
                              itemCount:
                                  SellerProfileController.to.filterList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      SellerProfileController.to.service.value =
                                          SellerProfileController
                                              .to.filterList[index];

                                      Get.to(MyServiceDetails());
                                    },
                                    child: MyServiceWidget(
                                      service: SellerProfileController
                                          .to.filterList[index],
                                    ));
                              },
                            );
                })),
                SizedBox(
                  height: 8,
                )
              ],
            ),
          )),
    );
  }
}
