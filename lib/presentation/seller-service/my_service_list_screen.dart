import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/seller-service/my_service_details.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';
import 'package:upai/widgets/custom_text_field.dart';

import 'widgets/my_service_widget.dart';

class MyServiceListScreen extends StatelessWidget {
  final List<MyService> service;
  const MyServiceListScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {double screenWidth = MediaQuery.of(context).size.width;

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
        SellerProfileController
            .to.searchMyServiceController.value
            .clear();
        SellerProfileController.to.filterMyService('');
        // controller.searchController.value.clear();
        //
        // controller.filterOffer('');
      },
      child: Scaffold(
          backgroundColor: AppColors.strokeColor2,
          appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.strokeColor2,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () {
                Get.back();
                // controller.searchController.value.clear();
                //
                // controller.filterOffer('');
              },
            ),
            title: Text(
              "My Services",
              style: AppTextStyle.appBarTitle,
            ),
          ),
          body: RefreshIndicator(
            color: Colors.black,
            backgroundColor: Colors.white,
            onRefresh: () => SellerProfileController.to.refreshAllData(),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0)
                        .copyWith(bottom: 12),
                    child: Obx(
                       () {
                        return CustomTextField(
                          controller: SellerProfileController
                              .to.searchMyServiceController.value,
                          hintText: "Search service..",
                          onChanged: (value) {},
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.black,
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
                      }
                    )),
                Expanded(child: Obx(() {
                  return SellerProfileController.to.filterList.isEmpty?Center(child:Text('My Service list is empty')): GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemCount: SellerProfileController.to.filterList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {Get.to(MyServiceDetails(service: SellerProfileController.to.filterList[index]));},
                          child: MyServiceWidget(
                            service: SellerProfileController.to.filterList[index],
                          ));
                    },
                  );
                })), SizedBox(
                  height: 12,
                )
              ],
            ),
          )),
    );
  }
}
