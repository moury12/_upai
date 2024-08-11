import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/widgets/custom_text_field.dart';
import 'package:upai/widgets/item_service.dart';

import '../../core/utils/custom_text_style.dart';

class ServiceListScreen extends StatefulWidget {
  static const String routeName = '/explore-top';
 // final String? selectedCat;
  final String selectedCat = Get.arguments;
    ServiceListScreen({super.key});

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
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    print(height.toString());
    print(width.toString());
    int crossAxisCount = MediaQuery
        .of(context)
        .size
        .width > 600 ? 4 : 2;
    return Scaffold(
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
            },
          ),
          title: widget.selectedCat!=""? Text(
            widget.selectedCat,
            style: AppTextStyle.appBarTitle,
          ):Text(
            "Explore Services",
            style: AppTextStyle.appBarTitle,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
                  bottom: 12),
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
                    icon: const Icon(Icons.cancel, color: Colors.black,),
                    onPressed: () {
                      controller.searchController.value.clear();
                      controller.filterOffer('');
                    },),
                );
              }),
            ),
            Obx(() {
              if (controller.filteredOfferList.isEmpty) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.black,));
              } else {
                var offerList =[];
                if(widget.selectedCat!="")
                  {
                   offerList = controller.filteredOfferList
                        .where((item) => item.serviceCategoryType!
                        .toLowerCase()
                        .contains(
                        widget.selectedCat.toString().toLowerCase()))
                        .toList();
                  }
                else
                  {
                   offerList = controller.filteredOfferList;
                  }

                if(offerList.isNotEmpty)
                  {
                    return Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        /* shrinkWrap: true,*/
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12)
                            .copyWith(top: 0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: .8,
                          crossAxisCount: crossAxisCount,
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
                    return Expanded(child:  Center(child: Text("No Service Available",style: AppTextStyle.bodySmallText2Grey400s16,),));
                  }


              }
            },)
          ],
        ));
  }
}
