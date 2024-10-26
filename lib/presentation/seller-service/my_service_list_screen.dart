import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/presentation/HomeScreen/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/seller-service/my_service_details.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';
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
      crossAxisCount = 3;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4;
    }
    if (screenWidth > 1232) {
      crossAxisCount = 5;
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
          appBar: AppBar(
            // elevation: 0,
            // shadowColor: Colors.transparent,
            // surfaceTintColor: Colors.transparent,
            // backgroundColor: AppColors.strokeColor2,
            // foregroundColor: Colors.black,
            // leading: IconButton(
            //   icon: const Icon(CupertinoIcons.back),
            //   onPressed: () {
            //     Get.back();
            //     // controller.searchController.value.clear();
            //     //
            //     // controller.filterOffer('');
            //   },
            // ),
            title: Text(
              "My Offers",
              style: AppTextStyle.appBarTitle,
            ),
          ),
          body: RefreshIndicator(
            color: AppColors.kprimaryColor,
            backgroundColor: Colors.white,
            onRefresh: () => SellerProfileController.to.refreshAllData(),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 12)
                        .copyWith(bottom: 0),
                    child: Obx(() {
                      return CustomTextField(
                        controller: SellerProfileController
                            .to.searchMyServiceController.value,
                        hintText: "Search service..",
                        onChanged: (value) {},
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: AppColors.kprimaryColor,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ShimmerOfferList(
                            fromServiceList: true,
                          ),
                        )
                      : SellerProfileController.to.filterList.isEmpty
                          ? Center(child: Text('Offer List empty'))
                          : GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      childAspectRatio: .8,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8),
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
