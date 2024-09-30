import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/Explore/service_list_screen.dart';
import 'package:upai/presentation/HomeScreen/category_list_screen.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/HomeScreen/widgets/search_able_dropdown.dart';
import 'package:upai/presentation/HomeScreen/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/ServiceDetails/service_details.dart';
import 'package:upai/presentation/default_controller.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/widgets/cat_two.dart';
import 'package:upai/widgets/custom_text_field.dart';
import 'package:upai/widgets/service_offer_widget.dart';

import '../../core/utils/image_path.dart';
import '../../sampleresponse/category_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1),);
    if (controller.searchICon.value) {
      animationController.value = 0.4; // Set to cross icon
    } else {
      animationController.value = 1.0; // Set to search icon
    }
 debugPrint(controller.searchICon.value.toString());
    // Add a listener to react to changes in searchICon
    // controller.searchICon.listen((value) {
    //   if (value) {
    //     animationController.animateBack(0.3);
    //   } else {
    //     animationController.animateTo(1.0);  // Use forward to go to 1.0
    //
    //   }
    // });
    // if (controller.searchICon.value) {
    //
    //     animationController.animateTo(1.0);
    //
    // } else {
    //
    //     animationController.animateBack(0.3);
    //
    // }
    // controller.searchICon.addListener((){
    //   toggleAnimation();
    // } as GetStream<bool>);
    // controller.searchICon.addListener(() {
    //   toggleAnimation();
    // });


  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
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
      onPopInvoked: (didPop) {
        if (ctrl.selectedIndex.value == 0 &&
            HomeController.to.searchICon.value) {
          controller.searchICon.value = false;
          animationController.animateTo(1.0);
          setState(() {});
        }
      },
      child: Scaffold(
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
                  Row(
                    children: [
                      const Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SearchableDropDown(fromHome: true,),
                          )),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.kprimaryColor,
                                shape: BoxShape.circle),
                            child: IconButton(
                                style: IconButton.styleFrom(
                                  shape: const CircleBorder(),
                                ),
                                onPressed: () async {
                                  toggleAnimation();
                                  // resetData();
                                  // await controller.refreshAllData();
                                },
                                icon: Lottie.asset(
                                  'assets/search_json/search_cross_icon.json',
                                   height: 35,

                                  controller: animationController,
                                  onLoaded: (composition) {
                                    animationController
                                      ..duration = composition.duration
                                      ..stop();
                                  },
                                )
                                // controller.searchICon.value ?
                                // Icon(
                                //   Icons.cancel_outlined,
                                //   size: 25,
                                //   color: AppColors.colorWhite,
                                // ) : Icon(
                                //   CupertinoIcons.search,
                                //   size: 25,
                                //   color: AppColors.colorWhite,
                                // )
                                )),
                      )
                    ],
                  ),
                  Expanded(
                    child: Obx(() {
                      return controller.searchICon.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  // SizedBox(
                                  //   height: 50,
                                  //   child: TextField(
                                  //     focusNode: searchFocus,
                                  //     controller: HomeController
                                  //         .to.searchOfferController.value,
                                  //     onChanged: (value) {
                                  //       if (value.isNotEmpty) {
                                  //         controller.searchingValue.value = value;
                                  //         controller.filterOffer(
                                  //             value,
                                  //             HomeController.to
                                  //                 .selectedDistrictForAll.value);
                                  //         controller.isSearching.value = true;
                                  //       } else {
                                  //         controller.filterOffer(
                                  //             value,
                                  //             HomeController.to
                                  //                 .selectedDistrictForAll.value);
                                  //
                                  //         controller.isSearching.value = false;
                                  //       }
                                  //     },
                                  //     cursorColor: Colors.black,
                                  //     decoration: InputDecoration(
                                  //       fillColor: AppColors.colorWhite,
                                  //       filled: true,
                                  //       hintText:
                                  //           "Search service you're looking for...",
                                  //       hintStyle: TextStyle(
                                  //           fontSize: 14,
                                  //           color: AppColors.appTextColorGrey),
                                  //       border: OutlineInputBorder(
                                  //         borderSide: BorderSide(
                                  //           color: AppColors.kprimaryColor,
                                  //         ),
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //       enabledBorder: OutlineInputBorder(
                                  //         borderSide: BorderSide(
                                  //           color: AppColors.kprimaryColor,
                                  //         ),
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //       focusedBorder: OutlineInputBorder(
                                  //         borderSide: BorderSide(
                                  //             color: AppColors.kprimaryColor),
                                  //         // Yellow border when focused
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Expanded(
                                  //       child: Text("Browse Category",
                                  //           style: AppTextStyle.titleText),
                                  //     ),
                                  //     GestureDetector(
                                  //       onTap: () {
                                  //         Get.toNamed(
                                  //             CategoryListScreen.routeName);
                                  //       },
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.symmetric(
                                  //             vertical: 12.0),
                                  //         child: Text("Browse All > ",
                                  //             style: AppTextStyle
                                  //                 .titleTextSmallUnderline),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  DefaultTabController(
                                    length: 2,
                                    child: Expanded(
                                      child: Column(
                                        children: [
                                          TabBar(
                                            labelColor: AppColors.kprimaryColor,
                                            indicatorColor:
                                                AppColors.kprimaryColor,
                                            tabs: [
                                              Tab(text: 'Local'),
                                              Tab(text: 'Online'),
                                            ],
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                              children: [
                                                // Local Categories List
                                                ListView.builder(
                                                  itemCount: controller
                                                      .getCatList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                            ServiceListScreen(
                                                          selectedCat:
                                                              controller
                                                                  .getCatList[
                                                                      index]
                                                                  .categoryName
                                                                  .toString(),
                                                        ));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 2,
                                                                right: 2),
                                                        child:
                                                            // Row(
                                                            //   children: [
                                                            //     SizedBox(
                                                            //         height:40,width: 40,
                                                            //         child: Image.asset(ImageConstant.laundryIcon, fit: BoxFit.fill,)),
                                                            //     Expanded(
                                                            //       child: Text(
                                                            //               controller.getCatList[index]
                                                            //                   .categoryName
                                                            //                   .toString()),
                                                            //     )
                                                            //   ],
                                                            // ),
                                                            Column(
                                                          children: [
                                                            ListTile(
                                                              leading: SizedBox(
                                                                  height: 40,
                                                                  width: 40,
                                                                  child: Image
                                                                      .asset(
                                                                    categoryIconList[controller
                                                                            .getCatList[index]
                                                                            .categoryName
                                                                            .toString()]
                                                                        .toString(),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )),
                                                              title: Text(controller
                                                                  .getCatList[
                                                                      index]
                                                                  .categoryName
                                                                  .toString()),
                                                            ),
                                                            Divider(),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                // Online Categories List
                                                ListView.builder(
                                                  itemCount: controller
                                                      .getCatList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                            ServiceListScreen(
                                                          selectedCat:
                                                              controller
                                                                  .getCatList[
                                                                      index]
                                                                  .categoryName
                                                                  .toString(),
                                                        ));
                                                      },
                                                      child: Column(
                                                        children: [
                                                          ListTile(
                                                            leading: SizedBox(
                                                                height: 40,
                                                                width: 40,
                                                                child:
                                                                    Image.asset(
                                                                  categoryIconList[controller
                                                                          .getCatList[
                                                                              index]
                                                                          .categoryName
                                                                          .toString()]
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                )),
                                                            title: Text(controller
                                                                .getCatList[
                                                                    index]
                                                                .categoryName
                                                                .toString()),
                                                          ),
                                                          Divider(),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  "Explore Top Services",
                                                  style:
                                                      AppTextStyle.titleText),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                resetData();
                                                HomeController.to.filteredOfferList.refresh();
                                                HomeController.to.filterOffer('', null);
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
                                        HomeController
                                                    .to.getOfferList.isEmpty ||
                                                !NetworkController
                                                    .to.connectedInternet.value
                                            ? const ShimmerRunnigOrder()
                                            : SizedBox(
                                                height: 200,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: controller
                                                        .getOfferList.length,
                                                    itemBuilder:
                                                        (context, index) {
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
                                                              offerItem:
                                                                  service,
                                                            ),
                                                          ));
                                                    }),
                                              )
                                      ],
                                    ),
                                  ),
                                  Obx(() {
                                    if (controller.isSearching.value ||
                                        HomeController.to.selectedDistrictForAll
                                                .value !=
                                            null) {
                                      var offerList = [];
                                      offerList = controller.filteredOfferList;
                                      if (offerList.isNotEmpty) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        "Explore New Services",
                                                        style: AppTextStyle
                                                            .titleText),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          ServiceListScreen
                                                              .routeName,
                                                          arguments: "");
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 12.0),
                                                      child: Text(
                                                          "Browse All > ",
                                                          style: AppTextStyle
                                                              .titleTextSmallUnderline),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                          horizontal: 8)
                                                      .copyWith(top: 8),
                                              itemCount: offerList.length,
                                              itemBuilder: (context, index) {
                                                final service =
                                                    offerList[index];
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
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Center(
                                            child: Text(
                                              "No Service Available",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      "Explore New Services",
                                                      style: AppTextStyle
                                                          .titleText),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        ServiceListScreen
                                                            .routeName,
                                                        arguments: "");
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 12.0),
                                                    child: Text("Browse All > ",
                                                        style: AppTextStyle
                                                            .titleTextSmallUnderline),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Obx(() {
                                              return HomeController
                                                          .to
                                                          .getOfferList
                                                          .isEmpty ||
                                                      !NetworkController
                                                          .to
                                                          .connectedInternet
                                                          .value
                                                  ? const ShimmerRunnigOrder()
                                                  : ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: controller
                                                          .getOfferList.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final service = controller
                                                                .getOfferList[
                                                            index];
                                                        return InkWell(
                                                            onTap: () {
                                                              Get.to(
                                                                ServiceDetails(
                                                                  offerDetails:
                                                                      service,
                                                                ),
                                                              );
                                                            },
                                                            child:
                                                                ServiceOfferWidget(
                                                                  index: index,
                                                              offerItem:
                                                                  service,
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
      ),
    );
  }

  void toggleAnimation() {
    if (controller.searchICon.value) {
      animationController.animateTo(1.0);
    } else {
      animationController.animateBack(0.4);
    }
    controller.searchICon.value = !controller.searchICon.value;

    setState(() {});
    debugPrint(controller.searchICon.value.toString());
  }
}
