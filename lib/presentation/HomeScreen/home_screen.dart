import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/category_item_model.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/item_service_model.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/TestData/category_data.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
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
                      const SizedBox(height: 20,),
                      TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Search service you're looking for...",
                            hintStyle: TextStyle(fontSize: 11, color: AppColors.appTextColorGrey),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(6)

                            )
                        ),
                      ),
                      const SizedBox(height: 20,),
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
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Browse Category", style: AppTextStyle.titleText),
                        Text("Browse All>",

                            style: AppTextStyle.titleTextSmallUnderline),

                      ],
                    ),
                    const SizedBox(height: 10,),

                    Obx(
                      () {
                        return SizedBox(
                          width: size.width,
                          height: 100,
                          child:HomeController.to.getCatList.isEmpty?Center(child: CircularProgressIndicator()): ListView.builder(
                              itemCount: HomeController.to.getCatList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // categoryItemModel =
                                //     CategoryListModel.fromJson(catList[index]);
                                return
                                  CategotyItem(singleCat: HomeController.to.getCatList[index],);

                              },)
                        );
                      }
                    ),

                    const SizedBox(height: 10,),
                    Text("Explore Top Services",
                        style: AppTextStyle.titleText),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: size.width,
                      height: 300,
                      child: FutureBuilder(
                        future: controller.getOfferList,
                        builder: (context, snapshot) {
                          if(snapshot.hasData)
                            {
                              List<OfferList> offerList=snapshot.data;
                              return ListView.builder(
                                itemCount: offerList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  // singleItem =
                                  //     ItemServiceModel.fromJson(serviceList[index]);
                                  return OfferService(offer: offerList[index],);
                                },);
                            }
                          else
                            {
                              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
                            }
                        },
                      )
                    ),


                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
