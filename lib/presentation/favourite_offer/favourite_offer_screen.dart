import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/ServiceDetails/service_details.dart';
import 'package:upai/widgets/service_offer_widget.dart';

import '../../helper_function/helper_function.dart';

class FavouriteOfferScreen extends StatefulWidget {
  const FavouriteOfferScreen({super.key});

  @override
  State<FavouriteOfferScreen> createState() => _FavouriteOfferScreenState();
}

class _FavouriteOfferScreenState extends State<FavouriteOfferScreen> {
  @override
  void initState() {
    retrieveFavOffers();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:AppColors.kprimaryColor,foregroundColor: Colors.white,title: Text('Favourite Offer', style: AppTextStyle.appBarTitle),),
      body: Obx(
         () {
          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: HomeController.to.favOfferList.length,
            itemBuilder: (context, index) {
            var favItem = HomeController.to.favOfferList[index];
            return GestureDetector(
              onTap: () {
                OfferList? offer= getOfferByID(favItem.offerId!,HomeController.to.getOfferList);
                Get.to(ServiceDetails(offerDetails: offer,));
              } ,
                child: ServiceOfferWidget(offerItem: favItem,index: index, ));
          },);
        }
      ),
    );
  }
}
