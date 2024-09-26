import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/HomeScreen/widgets/search_able_dropdown.dart';
import 'package:upai/presentation/HomeScreen/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/ServiceDetails/service_details.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/widgets/custom_text_field.dart';
import 'package:upai/widgets/service_offer_widget.dart';

import '../../core/utils/custom_text_style.dart';
import '../seller-service/my_service_details.dart';
import '../seller-service/seller_profile_controller.dart';

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
  void initState() {
    Get.put(NetworkController());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine the number of columns and aspect ratio dynamically
    int crossAxisCount = 2;

    double childRatio = 0.8;

    if (screenWidth > 600) {
      crossAxisCount = 3;
      childRatio = screenWidth > screenHeight ? 0.9 : 1;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4;
      childRatio = screenWidth > screenHeight ? 0.9 : 1;
    }
    if (screenWidth > 1232) {
      crossAxisCount = 5;
      childRatio = 1;
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        controller.searchController.value.clear();
        controller.selectedDistrictForAll.value=null;

        controller.filterOffer('', null);
      },
      child: Scaffold(
          backgroundColor: AppColors.strokeColor2,
          appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
                controller.searchController.value.clear();

                controller.filterOffer('', HomeController.to.selectedDistrictForAll.value);
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
            onRefresh: () async {
              controller.filterOffer(controller.searchController.value.text, HomeController.to.selectedDistrictForAll.value);
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(bottom: 8),
                  child: Obx(() {
                    return CustomTextField(
                      controller: controller.searchController.value,
                      onChanged: (value) {
                        controller.filterOffer(value!, HomeController.to.selectedDistrictForAll.value);
                      },
                      onPressed: () {
                        // controller.searchController.value.clear();

                        // controller.filterOffer(
                        //     '', HomeController.to.selectedDistrictForAll.value);
                      },
                      hintText: "Search service..",
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: AppColors.kprimaryColor,
                        ),
                        onPressed: () {
                          controller.searchController.value.clear();
                          controller.filterOffer('', HomeController.to.selectedDistrictForAll.value);
                        },
                      ),
                    );
                  }),
                ),
                SearchableDropDown(),
                Obx(
                  () {
                    if (!NetworkController.to.connectedInternet.value) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0).copyWith(top: 0),
                          child: ShimmerOfferList(
                            fromServiceList: true,
                          ),
                        ),
                      );
                    } else if (controller.filteredOfferList.isEmpty) {
                      return Expanded(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Center(
                            child: Text('service list is empty'),
                          ),
                        ),
                      );
                    } else {
                      var offerList = [];
                      if (widget.selectedCat != null) {
                        offerList = controller.filteredOfferList.where((item) => item.serviceCategoryType!.toLowerCase().contains(widget.selectedCat.toString().toLowerCase())).toList();
                      } else {
                        offerList = controller.filteredOfferList;
                      }

                      if (offerList.isNotEmpty) {
                        return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: offerList.length,
                              itemBuilder: (context, index) {
                                OfferList service = offerList[index];
                                return InkWell(
                                  onTap: (){    Get.to(
                                    ServiceDetails(
                                      offerDetails: service,
                                    ),
                                  );},
                                  child: ServiceOfferWidget(
                                    offerItem: service,
                                  ),
                                );
                              },
                            ));
                        //     GridView.builder(
                        //   shrinkWrap: true,
                        //   primary: false,
                        //   physics: AlwaysScrollableScrollPhysics(),
                        //   padding: EdgeInsets.symmetric(horizontal: 8),
                        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: childRatio, crossAxisCount: crossAxisCount, crossAxisSpacing: 8, mainAxisSpacing: 8),
                        //   itemCount: offerList.length,
                        //   itemBuilder: (context, index) {
                        //     OfferList service = offerList[index];
                        //     return MyServiceWidget(
                        //       offerItem: service,
                        //       button: Padding(
                        //         padding: const EdgeInsets.only(top: 8.0),
                        //         child: SizedBox(
                        //             width: double.infinity,
                        //             child: ElevatedButton(
                        //               style: ElevatedButton.styleFrom(backgroundColor: AppColors.kprimaryColor, foregroundColor: Colors.white, alignment: Alignment.center),
                        //               onPressed: () {
                        //                 // if(ProfileScreenController.to.userInfo.value.userId==service.userId)
                        //                 //   {
                        //                 //     SellerProfileController.to.service.value =
                        //                 //     SellerProfileController
                        //                 //         .to.filterList[index];
                        //                 //
                        //                 //     Get.to(const MyServiceDetails());
                        //                 //   }
                        //                 Get.to(
                        //                   ServiceDetails(
                        //                     offerDetails: service,
                        //                   ),
                        //                 );
                        //               },
                        //               child: Text('Book Now'),
                        //             )),
                        //       ),
                        //     );
                        //   },
                        // ));
                      } else {
                        return const Center(child: Text('There is no service available'),);
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 8,
                )
              ],
            ),
          )),
    );
  }
}
