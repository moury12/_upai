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
  late HomeController controller;

  @override
  void initState() {
    controller = Get.put(HomeController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
          body: Column(
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
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  } else {
                    var offerList = [];
                    if (widget.selectedCat != null) {
                      offerList = controller.filteredOfferList
                          .where((item) => item.serviceCategoryType!
                              .toLowerCase()
                              .contains(
                                  widget.selectedCat.toString().toLowerCase()))
                          .toList();
                    } else {
                      offerList = controller.filteredOfferList;
                    }

                    if (offerList.isNotEmpty) {
                      return Expanded(
                          child: GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width >
                                        MediaQuery.of(context).size.height
                                    ? MediaQuery.of(context).size.width / 4
                                    : MediaQuery.of(context).size.width / 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16),
                        itemCount: offerList.length,
                        itemBuilder: (context, index) {
                          final service = offerList[index];
                          return GestureDetector(
                              onTap: () {
                                Get.to(
                                  ServiceDetails(
                                    offerDetails: service,
                                  ),
                                );
                              },
                              child: MyServiceWidget(
                                offerList: service,
                              ));
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
              )
            ],
          )),
    );
  }
}
