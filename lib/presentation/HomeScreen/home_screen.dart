import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/category_item_model.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/item_service_model.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/TestData/category_data.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/Explore/service_list_screen.dart';
import 'package:upai/presentation/HomeScreen/category_list_screen.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/widgets/cat_two.dart';
import 'package:upai/widgets/custom_drawer.dart';
import 'package:upai/widgets/category_item.dart';
import 'package:upai/widgets/item_service.dart';

import '../../TestData/servicedItemData.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // CategoryListModel categoryItemModel = CategoryListModel();
    // ItemServiceModel singleItem = ItemServiceModel();
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.textFieldBackGround,
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
                          }
                          else {
                            controller.isSearching.value = false;
                          }
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Search service you're looking for...",
                            hintStyle: TextStyle(
                                fontSize: 11,
                                color: AppColors.appTextColorGrey),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width,
                        height: 40,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: AppColors.BTNbackgroudgrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
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
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),

              Obx(() {
                if(controller.isSearching.value){
                  var offerList =[];
                  offerList = controller.filteredOfferList;
                  if(offerList.isNotEmpty)
                  {
                    return SizedBox(
                      height: 500,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        /* shrinkWrap: true,*/
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12)
                            .copyWith(top: 0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: .8,
                          crossAxisCount: 2,
                          // maxCrossAxisExtent: 250
                        ),
                        itemCount: offerList.length,
                        itemBuilder: (context, index) {

                          return OfferService(
                            margin: EdgeInsets.zero,
                            offer: offerList[index],
                          );
                        },
                      ),
                    );
                  }
                  else
                  {
                    return Center(child: Text("No Service Available",style: AppTextStyle.bodySmallText2Grey400s16,),);
                  }
                }
                else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Browse Category",
                                style: AppTextStyle.titleText),
                            GestureDetector(onTap: () {
                              Get.toNamed(CategoryListScreen.routeName);
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
                          return SizedBox(
                              width: size.width,
                              height: 60,
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
                                  return CategotyItemtwo(
                                    singleCat:
                                    HomeController.to.getCatList[index],
                                  );
                                },
                              ));
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
                                Get.toNamed(
                                    ServiceListScreen.routeName, arguments: "");
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

                        SizedBox(
                            width: size.width,
                            height: 300,
                            child: Obx(
                                  () {
                                if (controller.getOfferList.isNotEmpty) {
                                  List<OfferList> offerList =
                                      controller.getOfferList;
                                  return ListView.builder(
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      // singleItem =
                                      //     ItemServiceModel.fromJson(serviceList[index]);
                                      return OfferService(
                                        offer: offerList[index],
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                      child: const CircularProgressIndicator(
                                        color: Colors.black,
                                      ));
                                }
                              },
                            )),
                      ],
                    ),
                  );
                }
              }),

            ],
          ),
        ),
      ),
    );
  }
}
