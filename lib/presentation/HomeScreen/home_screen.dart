import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/helper_function/helper_function.dart';

import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';
import 'package:upai/presentation/HomeScreen/widgets/filter_banner_widget.dart';
import 'package:upai/presentation/HomeScreen/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/Service-details/service_details.dart';
import 'package:upai/presentation/default_controller.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/presentation/service-list/service_list_screen.dart';
import 'package:upai/widgets/service_offer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = HomeController.to;
  final ctrl = Get.put(DefaultController());
  final List<String> localCategories = [
    'Local Category 1',
    'Local Category 2',
    'Local Category 3'
  ];
  final List<String> onlineCategories = [
    'Online Category 1',
    'Online Category 2',
    'Online Category 3'
  ];
  late AnimationController animationController;
  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    super.initState();
    resetData();
    controller.refreshAllData();
    // controller.isSearching.value = false;
    Get.put(NetworkController());
    retrieveFavOffers();
  }

  void resetData() {
    controller.searchOfferController.value.clear();
    controller.selectedDistrictForAll.value = null;
    controller.isSearching.value = false;
    searchFocus.unfocus();
  }

  FocusNode searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.black,
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
                FilterBanner(),
                Expanded(
                  child: Obx(() {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                                        resetData();
                                        HomeController.to.filteredOfferList
                                            .refresh();
                                        HomeController.to
                                            .filterOffer('', null);
                                        Get.toNamed(
                                            ServiceListScreen.routeName,
                                            arguments: "");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Text("Browse All > ",
                                            style: AppTextStyle
                                                .titleTextSmallUnderline),
                                      ),
                                    ),
                                  ],
                                ),
                                HomeController.to.getOfferList.isEmpty ||
                                        !NetworkController
                                            .to.connectedInternet.value
                                    ? ShimmerExploreTopService()
                                    : /*HomeController
                                                  .to.getOfferList.isEmpty ?NoServiceWidget():*/
                                    SizedBox(
                                        height: 200,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller.getOfferList
                                                        .length <=
                                                    5
                                                ? controller
                                                    .getOfferList.length
                                                : 5,
                                            itemBuilder: (context, index) {
                                              final service = controller
                                                  .getOfferList[index];
                                              return GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                      ServiceDetails(
                                                        offerDetails: service,
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12.0,
                                                            top: 4,
                                                            bottom: 4,
                                                            left: 4),
                                                    child: MyServiceWidget(
                                                      offerItem: service,
                                                    ),
                                                  ));
                                            }),
                                      )
                              ],
                            ),
                          ),
                          Obx(() {
                            if (controller.isSearching.value ||
                                HomeController
                                        .to.selectedDistrictForAll.value !=
                                    null) {
                              var offerList = [];
                              offerList = controller.filteredOfferList;
                              if (offerList.isNotEmpty) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                "Explore New Services",
                                                style:
                                                    AppTextStyle.titleText),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  ServiceListScreen.routeName,
                                                  arguments: "");
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
                                    ),
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 8)
                                          .copyWith(top: 8),
                                      itemCount: offerList.length <= 5
                                          ? offerList.length
                                          : 5,
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
                                          child: ServiceOfferWidget(
                                            index: index,
                                            offerItem: service,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return NoServiceWidget();
                              }
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text("Explore New Services",
                                              style: AppTextStyle.titleText),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                ServiceListScreen.routeName,
                                                arguments: "");
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
                                    Obx(() {
                                      return !NetworkController.to
                                                  .connectedInternet.value ||
                                              HomeController
                                                  .to.getOfferList.isEmpty
                                          ? const ShimmerRunnigOrder()
                                          /*:HomeController
                                                        .to.getOfferList.isEmpty ?NoServiceWidget()*/
                                          : ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: controller
                                                          .getOfferList
                                                          .length <=
                                                      5
                                                  ? controller
                                                      .getOfferList.length
                                                  : 5,
                                              itemBuilder: (context, index) {
                                                final service = controller
                                                    .getOfferList[index];
                                                return InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                        ServiceDetails(
                                                          offerDetails:
                                                              service,
                                                        ),
                                                      );
                                                    },
                                                    child: ServiceOfferWidget(
                                                      index: index,
                                                      offerItem: service,
                                                    ));
                                              });
                                    }),
                                  ],
                                ),
                              );
                            }
                          }),
                          SizedBox(
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
