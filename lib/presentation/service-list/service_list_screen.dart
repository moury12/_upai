import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/controllers/filter_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/helper_function/helper_function.dart';

import 'package:upai/presentation/Service-details/service_details.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
import 'package:upai/presentation/home/home_screen.dart';
import 'package:upai/presentation/home/widgets/filter_banner_widget.dart';
import 'package:upai/presentation/home/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/seller-service/seller_running_order_list_screen.dart';
import 'package:upai/widgets/custom_appbar.dart';
import 'package:upai/widgets/custom_text_field.dart';
import 'package:upai/widgets/service_offer_widget.dart';

import '../../core/utils/custom_text_style.dart';

class ServiceListScreen extends StatefulWidget {
  final bool? isTopService;
  final bool? isNewService;
  static const String routeName = '/explore-top';
  final String? selectedCat;

  const ServiceListScreen(
      {super.key,
      this.selectedCat,
      this.isTopService = false,
      this.isNewService = false});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  HomeController controller = HomeController.to;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.put(NetworkController());


    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          HomeController.to.getOfferDataList(loadMoreData: true);
        }
      },
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 600) {}
    if (screenWidth > 900) {}
    if (screenWidth > 1232) {}

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title:  widget.isTopService == true
            ? "explore_top_services".tr
            : widget.isNewService == true
            ? "explore_new_services".tr
            : "services".tr,),
        body: RefreshIndicator(
          color: AppColors.kPrimaryColor,

          backgroundColor: Colors.white,
          onRefresh: () async {
            resetData();
          },
          child: Obx(
           () {
              return Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.isTopService == true
                      ? const SizedBox.shrink()
                      : FilterBanner(
                          isService: true,
                          isNewestArrival: widget.isNewService,
                        ),
                  widget.isTopService == true
                      ? const SizedBox.shrink()
                      : Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.sp).copyWith(top: 8.sp),
                          child:  CustomTextField(
                              controller: controller.searchOfferController.value,
                              onChanged: (value) {
                               controller.getOfferDataList();
                                // controller.getOfferList.refresh();
                              },
                              hintText: "${'search_service'.tr}..",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.cancel,
size: defaultAppBarIconSize,
                                  color: AppColors.kPrimaryColor,
                                ),
                                onPressed: () {
                                  controller.searchOfferController.value.clear();
                                  controller.getOfferDataList();
                                  // controller.filterOffer('',
                                  //     HomeController.to.selectedDistrictForAll.value);
                                },
                              ),
                            ),
                        ),
                  FilterController
                      .to.isFilterValueEmpty.value
                      ? SizedBox.shrink(): defaultSizeBoxHeight,
                  FilterController
                      .to.isFilterValueEmpty.value
                      ? SizedBox.shrink(): Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                        '${FilterController.to.selectedServiceType.value != null ? '${FilterController.to.selectedServiceType.value} > ' : ''}${FilterController.to.selectedCategory.value != null ? '${FilterController.to.selectedCategory.value} > ' : ''}${FilterController.to.selectedSortBy.value != null ? '${FilterController.to.selectedSortBy.value} > ' : ''}',
                        style: AppTextStyle.titleText(context)),
                      ),
                  Obx(
                    () {
                      if (!NetworkController.to.connectedInternet.value||controller.isServiceListLoading.value) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0).copyWith(top: 0),
                            child: const ShimmerRunnigOrder(
                              // fromServiceList: true,
                            ),
                          ),
                        );
                      } else if ((widget.isTopService == true &&
                              controller.topServiceList.isEmpty) ||
                          (widget.isNewService == true &&
                              controller.newServiceList.isEmpty) ||
                          controller.getOfferList.isEmpty) {
                        return const Expanded(
                          child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: NoServiceWidget()),
                        );
                      } else {
                        return Expanded(
                            child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding:  EdgeInsets.all(defaultPadding ),
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: widget.isTopService == true
                              ? controller.topServiceList.length
                              : widget.isNewService == true
                                  ? controller.newServiceList.length
                                  : controller.getOfferList.length,
                          itemBuilder: (context, index) {
                            OfferList service = widget.isTopService == true
                                ? controller.topServiceList[index]
                                : widget.isNewService == true
                                    ? controller.newServiceList[index]
                                    : controller.getOfferList[index];
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  ServiceDetails(
                                    offerDetails: service,
                                  ),
                                );
                              },
                              child: ServiceOfferWidget(
                                index: index,
                                offerItem: service,
                              ),
                            );
                          },
                        ));
                      }
                    },
                  ),
                 Obx(
                    () {if(HomeController.to.isLoadingMore.value){
                      return   DefaultCircularProgressIndicator();}else{return SizedBox.shrink();}
                    }
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              );
            }
          ),
        ));
  }
}
