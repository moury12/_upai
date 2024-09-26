import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/widgets/cat_two.dart';
import 'package:upai/widgets/custom_text_field.dart';
import 'package:upai/widgets/service_offer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  HomeController controller = HomeController.to;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    resetData();
    debugPrint('uiyiuvu');
    controller.refreshAllData();
    print("lsdkflds");
    controller.isSearching.value = false;
    Get.put(NetworkController());

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Reset data when the app is resumed or navigated back to this screen
      resetData();
      controller.refreshAllData();
    }
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
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

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

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.black,
          backgroundColor: Colors.white,
          onRefresh: () {
            resetData();
            return controller.refreshAllData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.textFieldBackGround,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        // const SizedBox(
                        //   height: 10,
                        // ),

                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Container(
                        //   width: double.infinity,
                        //   padding: EdgeInsets.symmetric(vertical: 12),
                        //   clipBehavior: Clip.antiAlias,
                        //   decoration: ShapeDecoration(
                        //     color: Colors.black,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(10)),
                        //   ),
                        //   child: Text(
                        //     'Search Service',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontFamily: 'Inter',
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Expanded(flex: 4, child: SearchableDropDown()),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.kprimaryColor,
                            shape: BoxShape.circle),
                        child: Obx(() {
                          return IconButton(
                              style: IconButton.styleFrom(
                                shape: const CircleBorder(),
                              ),
                              onPressed: () async {
                                controller.searchICon.value =
                                !controller.searchICon.value;
                                // resetData();
                                // await controller.refreshAllData();
                              },
                              icon: controller.searchICon.value ?
                              Icon(
                                Icons.cancel_outlined,
                                size: 25,
                                color: AppColors.colorWhite,
                              ) : Icon(
                                CupertinoIcons.search,
                                size: 25,
                                color: AppColors.colorWhite,
                              )
                          );
                        }),
                      ),
                    )
                    // Expanded(
                    //   child: Container(
                    //     decoration: BoxDecoration(color: AppColors.kprimaryColor, shape: BoxShape.circle),
                    //     child: IconButton(
                    //         style: IconButton.styleFrom(
                    //           shape: const CircleBorder(),
                    //         ),
                    //         onPressed: () async {
                    //           resetData();
                    //           await controller.refreshAllData();
                    //         },
                    //         icon: Icon(
                    //           CupertinoIcons.restart,
                    //           size: 25,
                    //           color: AppColors.colorWhite,
                    //         )),
                    //   ),
                    // )
                  ],
                ),
               Obx(() {
                  return  controller.searchICon.value?TextField(
                    focusNode: searchFocus,
                    controller: HomeController.to.searchOfferController.value,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.filterOffer(value,
                            HomeController.to.selectedDistrictForAll.value);
                        controller.isSearching.value = true;
                      } else {
                        controller.filterOffer(value,
                            HomeController.to.selectedDistrictForAll.value);

                        controller.isSearching.value = false;
                      }
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        fillColor: AppColors.colorWhite,
                        filled: true,
                        hintText: "Search service you're looking for...",
                        hintStyle: TextStyle(fontSize: 14, color: AppColors
                            .appTextColorGrey),
                        border: OutlineInputBorder(borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                  ):const SizedBox.shrink();
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text("Browse Category",
                                style: AppTextStyle.titleText),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(CategoryListScreen.routeName);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text("Browse All > ",
                                  style: AppTextStyle.titleTextSmallUnderline),
                            ),
                          ),
                        ],
                      ),
                      Obx(() {
                        return HomeController.to.getCatList.isEmpty ||
                            !NetworkController.to.connectedInternet.value
                            ? ShimmerCategoryList()
                            : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              HomeController.to.getCatList.length,
                                  (index) {
                                return CategotyItemtwo(
                                  singleCat: HomeController.to
                                      .getCatList[index],
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Obx(() {
                  if (controller.isSearching.value ||
                      HomeController.to.selectedDistrictForAll.value != null) {
                    var offerList = [];
                    offerList = controller.filteredOfferList;
                    if (offerList.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 8)
                            .copyWith(top: 8),
                        itemCount: offerList.length,
                        itemBuilder: (context, index) {
                          final service = offerList[index];
                          return MyServiceWidget(
                            offerItem: service,
                            button: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors
                                            .kprimaryColor,
                                        foregroundColor: Colors.white,
                                        alignment: Alignment.center),
                                    onPressed: () {
                                      Get.to(
                                        ServiceDetails(
                                          offerDetails: service,
                                        ),
                                      );
                                    },
                                    child: const Text('Book Now'),
                                  )),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            "No Service Available",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*      Obx(() {
                            return SizedBox(
                                width: size.width,
                                height: 150,
                                child: HomeController.to.getCatList.isEmpty
                                    ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ))
                                    : ListView.builder(
                                  itemCount:
                                  HomeController.to.getCatList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    // categoryItemModel =
                                    //     CategoryListModel.fromJson(catList[index]);
                                    return CategotyItem(
                                      singleCat:
                                      HomeController.to.getCatList[index],
                                    );
                                  },
                                ));
                          }),*/

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text("Explore Top Services",
                                    style: AppTextStyle.titleText),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(ServiceListScreen.routeName,
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
                          Obx(() {
                            return HomeController.to.getOfferList.isEmpty ||
                                !NetworkController.to.connectedInternet.value
                                ? const ShimmerRunnigOrder()
                                :ListView.builder(

                                shrinkWrap: true,
                                itemCount: controller.getOfferList.length,
                                itemBuilder: (context, index) {
                                  final service = controller.getOfferList[index];
                                  return InkWell(
                                    onTap: (){
                                      Get.to(
                                        ServiceDetails(
                                          offerDetails: service,
                                        ),
                                      );
                                    },


                                      child: ServiceOfferWidget(offerItem: service,));


                            });
                            // GridView.builder(
                            //   shrinkWrap: true,
                            //   primary: false,
                            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //       crossAxisCount: crossAxisCount,
                            //       childAspectRatio: childRatio,
                            //       crossAxisSpacing: 12,
                            //       mainAxisSpacing: 12),
                            //   itemCount: controller.getOfferList.length < 4
                            //       ? controller.getOfferList.length
                            //       : 4,
                            //   itemBuilder: (context, index) {
                            //     final service = controller.getOfferList[index];
                            //     return InkWell(
                            //       onTap: (){
                            //               Get.to(
                            //                 ServiceDetails(
                            //                   offerDetails: service,
                            //                 ),
                            //               );
                            //
                            //       },
                            //       child: MyServiceWidget(
                            //         offerItem: service,
                            //         // SizedBox(
                            //         //   width: double.infinity,
                            //         //   child: ElevatedButton(
                            //         //     style: ElevatedButton.styleFrom(
                            //         //         backgroundColor: AppColors
                            //         //             .kprimaryColor,
                            //         //         foregroundColor: Colors.white,
                            //         //         alignment: Alignment.center),
                            //         //     onPressed: () async {
                            //         //       Get.to(
                            //         //         ServiceDetails(
                            //         //           offerDetails: service,
                            //         //         ),
                            //         //       );
                            //         //       // Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetails(offerDetails: service,),));
                            //         //     },
                            //         //     child: Text('Book Now'),
                            //         //   ),
                            //         // ),
                            //       ),
                            //     );
                            //   },
                            // );
                          }),
                          // SizedBox(
                          //     width: size.width,
                          //     height: 300,
                          //     child: Obx(
                          //       () {
                          //         if (controller.getOfferList.isNotEmpty) {
                          //           List<OfferList> offerList =
                          //               controller.getOfferList;
                          //           return ListView.builder(
                          //             itemCount: 5,
                          //             scrollDirection: Axis.horizontal,
                          //             itemBuilder: (context, index) {
                          //               // singleItem =
                          //               //     ItemServiceModel.fromJson(serviceList[index]);
                          //               return OfferService(
                          //                 offer: offerList[index],
                          //               );
                          //             },
                          //           );
                          //         } else {
                          //           return Center(
                          //               child: const CircularProgressIndicator(
                          //             color: Colors.black,
                          //           ));
                          //         }
                          //       },
                          //     )),
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
          ),
        ),
      ),
    );
  }
}
