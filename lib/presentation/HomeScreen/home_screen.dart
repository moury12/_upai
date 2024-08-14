import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/Explore/service_list_screen.dart';
import 'package:upai/presentation/HomeScreen/category_list_screen.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/ServiceDetails/service_details.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/widgets/cat_two.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return controller.refreshAllData();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.textFieldBackGround,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          onChanged: (value) {
                            if (value != "") {
                              controller.filterOffer(value);
                              controller.isSearching.value = true;
                            } else {
                              controller.isSearching.value = false;
                            }
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Search service you're looking for...",
                              hintStyle: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.appTextColorGrey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: AppColors.BTNbackgroudgrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Search Service',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.isSearching.value) {
                    var offerList = [];
                    offerList = controller.filteredOfferList;
                    if (offerList.isNotEmpty) {
                      return GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.symmetric(horizontal: 12)
                            .copyWith(top: 12),
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
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Browse Category",
                                  style: AppTextStyle.titleText),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(CategoryListScreen.routeName);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text("Browse All > ",
                                      style:
                                          AppTextStyle.titleTextSmallUnderline),
                                ),
                              ),
                            ],
                          ),
                          Obx(() {
                            return HomeController.to.getCatList.isEmpty
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ))
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        HomeController.to.getCatList.length,
                                        (index) {
                                          return CategotyItemtwo(
                                            singleCat: HomeController
                                                .to.getCatList[index],
                                          );
                                        },
                                      ),
                                    ),
                                  );
                          }),

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
                              Text("Explore Top Services",
                                  style: AppTextStyle.titleText),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(ServiceListScreen.routeName,
                                      arguments: "");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text("Browse All > ",
                                      style:
                                          AppTextStyle.titleTextSmallUnderline),
                                ),
                              ),
                            ],
                          ),
                          Obx(() {
                            return GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: MediaQuery.of(context)
                                                  .size
                                                  .width >
                                              MediaQuery.of(context).size.height
                                          ? MediaQuery.of(context).size.width /
                                              4
                                          : MediaQuery.of(context).size.width /
                                              2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16),
                              itemCount: controller.getOfferList.length < 4
                                  ? controller.getOfferList.length
                                  : 4,
                              itemBuilder: (context, index) {
                                final service = controller.getOfferList[index];
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
                            );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
