import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/widgets/custom_text_field.dart';
import 'package:upai/widgets/item_service.dart';

class ExploreTopSevicesPage extends StatefulWidget {
  static const String routeName = '/explore-top';
  const ExploreTopSevicesPage({super.key});

  @override
  State<ExploreTopSevicesPage> createState() => _ExploreTopSevicesPageState();
}

class _ExploreTopSevicesPageState extends State<ExploreTopSevicesPage> {
  late HomeController controller;
  @override
  void initState() {
    controller = Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.strokeColor2,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.strokeColor2,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Explore Services",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 12),
              child: CustomTextField(
                controller:controller.searchController.value ,
                onChanged: (value) {
                  controller.filterOffer(value!);
                },
                onPressed: () {
                  controller.searchController.value.clear();
                  controller.filterOffer('');
                },
hintText: "Search service..",
                suffixIcon: IconButton(icon: Icon(Icons.cancel,color: Colors.black,),onPressed: () {

                },),
              ),
            ),
            Obx(() {if(controller.filteredOfferList.isEmpty){
              return Center(child: CircularProgressIndicator(color: Colors.black,));
            }else{
              final offerList =controller.filteredOfferList;
             return Expanded(
                child: GridView.builder(
                  /* shrinkWrap: true,*/
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12).copyWith(top: 0),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio:MediaQuery.of(context).size.height<MediaQuery.of(context).size.width? .8:.95,
                      maxCrossAxisExtent: 250),
                  itemCount: offerList.length,
                  itemBuilder: (context, index) {
                    return OfferService(
                      margin: EdgeInsets.zero,
                      offer: offerList[index],
                    );
                  },
                ),
              );}
            },)
          ],
        ));
  }
}
