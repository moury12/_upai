import 'package:flutter/material.dart';
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
            scrollController.position.maxScrollExtent) {
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
            resetData();
            return controller.refreshAllData();
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
                                            child: Text("Explore Top Services",
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
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12.0),
                                              child: Text("Browse All > ",
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
                                              height: 250,
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
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 12.0,
                                                                  top: 4,
                                                                  bottom: 4,
                                                                  left: 4),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: FilterController
                                                  .to.isFilterValueEmpty.value
                                              ? Text("Explore New Services",
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
                                          child: Text("Browse All > ",
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
                          const SizedBox(
                            height: 8,
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
  const NoServiceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          "No Service Available",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
    );
  }
}
