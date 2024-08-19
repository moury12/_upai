import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/ServiceDetails/service_details.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/widgets/custom_text_field.dart';
import 'package:upai/widgets/item_service.dart';

import '../../core/utils/custom_text_style.dart';

class ServiceListScreen extends StatefulWidget {
  static const String routeName = '/explore-top';
  final String? selectedCat;

  ServiceListScreen({super.key, this.selectedCat});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  HomeController controller = HomeController.to;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine the number of columns and aspect ratio dynamically
    int crossAxisCount = 2;

    double childRatio = 0.8;

    if (screenWidth > 600) {
      crossAxisCount = 3;
      childRatio =screenWidth> screenHeight?0.9:1;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4; childRatio =screenWidth> screenHeight?0.9:1;
    }
    if (screenWidth > 1232) {
      crossAxisCount = 5; childRatio =1;
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        controller.searchController.value.clear();

        controller.filterOffer('');
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
                controller.searchController.value.clear();

                controller.filterOffer('');
              },
            ),
            title: widget.selectedCat != null
                ? Text(
                    widget.selectedCat ?? '',
                    style: AppTextStyle.appBarTitle,
                  )
                : Text(
                    "Explore Services",
                    style: AppTextStyle.appBarTitle,
                  ),
          ),
          body: RefreshIndicator(
            color: Colors.black,
            backgroundColor: Colors.white,
            onRefresh: () async{
              controller.filterOffer( controller.searchController.value.text);
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0)
                      .copyWith(bottom: 12),
                  child: Obx(() {
                    return CustomTextField(
                      controller: controller.searchController.value,
                      onChanged: (value) {
                        controller.filterOffer(value!);
                      },
                      onPressed: () {
                        controller.searchController.value.clear();

                        controller.filterOffer('');
                      },
                      hintText: "Search service..",
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          controller.searchController.value.clear();
                          controller.filterOffer('');
                        },
                      ),
                    );
                  }),
                ),
                Obx(
                  () {
                    if (controller.filteredOfferList.isEmpty) {
                      return Align(
                        alignment: Alignment.center,
                        child: Text(
                          "No Service Available",
                          style: AppTextStyle.bodySmallText2Grey400s16,
                        ),
                      );
                    } else {
                      var offerList = [];
                      if (widget.selectedCat != null) {
                        offerList = controller.filteredOfferList
                            .where((item) => item.serviceCategoryType!
                                .toLowerCase()
                                .contains(widget.selectedCat
                                    .toString()
                                    .toLowerCase()))
                            .toList();
                      } else {
                        offerList = controller.filteredOfferList;
                      }

                      if (offerList.isNotEmpty) {
                        return Expanded(
                            child: GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: childRatio,
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16),
                          itemCount: offerList.length,
                          itemBuilder: (context, index) {
                            final service = offerList[index];
                            return MyServiceWidget(
                              offerList: service,
                              button: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      Get.to(
                                        ServiceDetails(
                                          offerDetails: service,
                                        ),
                                      );
                                    },
                                    child: Text('Book Now'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ));
                      } else {
                        return Expanded(
                            child: Center(
                          child: Text(
                            "No Service Available",
                            style: AppTextStyle.bodySmallText2Grey400s16,
                          ),
                        ));
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          )),
    );
  }
}
