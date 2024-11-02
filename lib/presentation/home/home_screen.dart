import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/controllers/filter_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/Service-details/service_details.dart';
import 'package:upai/presentation/default_controller.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
import 'package:upai/presentation/home/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/presentation/service-list/service_list_screen.dart';
import 'package:upai/widgets/service_offer_widget.dart';

import 'widgets/filter_banner_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = HomeController.to;

  final ctrl = Get.put(DefaultController());
  late AnimationController animationController;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    Get.put(NetworkController());
    retrieveFavOffers();
    HomeController.to.refreshAllData();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent&& NetworkController.to.connectedInternet.value) {
          HomeController.to.getOfferDataList(loadMoreData: true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.kprimaryColor,
          backgroundColor: Colors.white,
          onRefresh: () {
        return resetData();
            // return controller.refreshAllData();
          },
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FilterBanner(
                  isNewestArrival: true,
                ),
                Expanded(
                  child: Obx(() {
                    return SingleChildScrollView(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          FilterController.to.isFilterValueEmpty.value &&
                                  HomeController
                                          .to.selectedDistrictForAll.value ==
                                      null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text("explore_top_services".tr,
                                                style: AppTextStyle.titleText),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(const ServiceListScreen(
                                                isTopService: true,
                                              ));
                                            },
                                            child: Padding(
                                              padding:
                                                   EdgeInsets.symmetric(
                                                      vertical: 12.sp),
                                              child: Text("browse_all".tr,
                                                  style: AppTextStyle
                                                      .titleTextSmallUnderline),
                                            ),
                                          ),
                                        ],
                                      ),
                             HomeController.to.isServiceListLoading.value ||
                                              !NetworkController
                                                  .to.connectedInternet.value
                                          ? ShimmerExploreTopService()
                                          : HomeController
                                                  .to.getOfferList.isEmpty ?NoServiceWidget():

                                          SizedBox(
                                              height:MediaQuery.of(context).size.height<MediaQuery.of(context).size.width? 0.4.sw:200.w,

                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: controller
                                                              .topServiceList
                                                              .length <=
                                                          5
                                                      ? controller
                                                          .topServiceList.length
                                                      : 5,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final service = controller
                                                        .topServiceList[index];
                                                    return GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                            ServiceDetails(
                                                              offerDetails:
                                                                  service,
                                                            ),
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                               EdgeInsets
                                                                  .only(
                                                                  right: 12.0.sp,
                                                                  top: 4.sp,
                                                                  bottom: 4.sp,
                                                                  left: 4.sp),
                                                          child:
                                                              MyServiceWidget(
                                                            offerItem: service,
                                                          ),
                                                        ));
                                                  }),
                                            )
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                          Padding(
                            padding:  EdgeInsets.symmetric(
                              horizontal: 8.sp,
                            ),
                            child: Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.symmetric(vertical: 8.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: FilterController
                                                  .to.isFilterValueEmpty.value
                                              ? Text("explore_new_services".tr,
                                                  style: AppTextStyle.titleText)
                                              : Text(
                                                  '${FilterController.to.selectedServiceType.value != null ? '${FilterController.to.selectedServiceType.value} > ' : ''}${FilterController.to.selectedCategory.value != null ? '${FilterController.to.selectedCategory.value} > ' : ''}${FilterController.to.selectedSortBy.value != null ? '${FilterController.to.selectedSortBy.value} > ' : ''}',
                                                  style: AppTextStyle.titleText),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(const ServiceListScreen(
                                              isNewService: true,
                                            ));
                                          },
                                          child: Text("browse_all".tr,
                                              style: AppTextStyle
                                                  .titleTextSmallUnderline),
                                        ),
                                      ],
                                    ),
                                  ),
                                  sizeBoxHeight6,
                                  !NetworkController.to.connectedInternet.value||HomeController.to.isServiceListLoading.value
                                      ? const ShimmerRunnigOrder()
                                      : HomeController.to.newServiceList.isEmpty
                                          ? const NoServiceWidget()
                                          : ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: controller
                                                          .newServiceList
                                                          .length,
                                              itemBuilder: (context, index) {
                                                final service = controller
                                                    .newServiceList[index];
                                                return ServiceOfferWidget(
                                                  index: index,
                                                  offerItem: service,
                                                );
                                              })
                                ],
                              );
                            }),
                          ),
                          Obx(() {
                            return HomeController.to.isLoadingMore.value
                                ? DefaultCircularProgressIndicator()
                                : SizedBox.shrink();
                          }),
                           SizedBox(
                            height: 8.w,
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoServiceWidget extends StatelessWidget {
  final String? title;
  const NoServiceWidget({
    super.key, this.title,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(12.sp),
      child: Center(
        child: Text(
        title??  "no_service_available".tr,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: default12FontSize),
        ),
      ),
    );
  }
}
