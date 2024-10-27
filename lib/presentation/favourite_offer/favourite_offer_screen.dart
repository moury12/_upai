import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/Service-details/service_details.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
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
            padding: const EdgeInsets.all(12),
            itemCount: HomeController.to.favOfferList.length,
            itemBuilder: (context, index) {
            var favItem = HomeController.to.favOfferList[index];
            return GestureDetector(
              onTap: () async{
                OfferList? offer= await HomeController.to.findServiceByOfferID( offerId: favItem.offerId!);
                if(offer!=null) {
                  Get.to(ServiceDetails(offerDetails: offer,));
                }else{
                  showCustomSnackbar(
                      title: 'Failed',
                      message:"Sorry! You can't view the service details right now. Please try again later",
                      type: SnackBarType.failed)
                  ;
                }
              } ,
                child: ServiceOfferWidget(offerItem: favItem,index: index, ));
          },);
        }
      ),
    );
  }
}
