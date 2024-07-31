

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:upai/Model/item_service_model.dart';
import 'package:upai/TestData/servicedItemData.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/widgets/item_service.dart';

import '../../Model/offer_list_model.dart';
import 'service_details_controller.dart';
import 'widgets/client_review.dart';
import 'widgets/rate_by_category_widget.dart';
class ServiceDetails extends StatefulWidget {
   ServiceDetails({super.key});
  final OfferList offerDetails = Get.arguments;


  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
  //  ItemServiceModel singleItem = ItemServiceModel();
    var ctrl = Get.put(ServiceDetailsController());
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: Stack(
                  children: [
                    Image.asset(
                      ImageConstant.serviceImg,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                          ),
                        )),
                    Positioned(
                        right: 45,
                        child: Obx(() {
                          return IconButton(
                            onPressed: () {
                              if (ctrl.isFav.value) {
                                ctrl.isFav.value = false;
                              }
                              else {
                                ctrl.isFav.value = true;
                              }
                            },
                            icon: ctrl.isFav.value
                                ? const FaIcon(
                              FontAwesomeIcons.solidHeart, color: Colors.red,)
                                : const FaIcon(FontAwesomeIcons.heart,),
                          );
                        })),
                    Positioned(
                        right: 8,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  widget.offerDetails.jobTitle.toString(),
                  style: AppTextStyle.bodyMediumBlackBold,
                ),
              ),
              const Divider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(ImageConstant.man),
                ),
                title: Text(
                 widget.offerDetails.userName.toString(),
                  style: AppTextStyle.bodyMedium,
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "230 Job completed",
                      style: AppTextStyle.bodySmallGrey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "4.9 Rating ",
                      style: AppTextStyle.bodySmallGrey,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: AppTextStyle.titleTextSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Text(
                    //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
                    //       " It has survived not only five centuries, but also the"
                    //       " leap into electronic typesetting, remaining essentially unchanged...."
                    //       " See More",
                    //   style: AppTextStyle.bodySmallblack,
                    // ),
                 ReadMoreText(
                 widget.offerDetails.description.toString(),style: AppTextStyle.bodySmallblack,textAlign: TextAlign.justify,
                  trimMode: TrimMode.Line,
                  trimLines: 5,
                  //colorClickableText: Colors.pink,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: const TextStyle(fontSize:12, fontWeight: FontWeight.bold),
                   lessStyle: const TextStyle( fontSize:12,fontWeight: FontWeight.bold),
                ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Includes",
                      style: AppTextStyle.titleTextSmall,
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),

                        color: AppColors.background1,
                      ),

                      width: size.width,
                      height: 100,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return  Padding(
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 2),
                            child: Text("✔️ Feature",style: AppTextStyle.bodySmallGrey,),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: AppTextStyle.bodySmallGrey,
                              ),
                              Text(
                                "৳ ${widget.offerDetails.rate.toString()}/${widget.offerDetails.rateType}",
                                style: AppTextStyle.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              SizedBox(
                                 width:double.infinity,
                                child: ElevatedButton(

                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      backgroundColor: AppColors.BTNbackgroudgrey,
                                      foregroundColor: AppColors.colorWhite),
                                  child: Text(
                                    "Chat Now", style: AppTextStyle.bodySmallwhite,),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      backgroundColor: AppColors.BTNbackgroudgrey,
                                      foregroundColor: AppColors.colorWhite),
                                  child: Text(
                                    "Confirm Offer", style: AppTextStyle.bodySmallwhite,),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.background1,
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Frequently Asked ",
                              style: AppTextStyle.bodyMediumBlack400,
                            ),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "4.4",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RatingBarIndicator(
                          rating: 4.4,
                          itemBuilder: (context, index) =>
                              Icon(
                                Icons.star,
                                color: AppColors.colorLightBlack,
                              ),
                          itemCount: 5,
                          itemSize: 22.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const RateByCat(
                      rateCat: "Seller Communication Level",
                      rating: "4.6",
                    ),
                    const RateByCat(
                      rateCat: "Service Quality",
                      rating: "4.6",
                    ),
                    const RateByCat(
                      rateCat: "Service as described",
                      rating: "4.6",
                    ),
                    const RateByCat(
                      rateCat: "Seller Behavior",
                      rating: "4.6",
                    ),
                    const RateByCat(
                      rateCat: "Recommend Service",
                      rating: "4.6",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Client Review", style: AppTextStyle.titleText),
                    const SizedBox(height: 15,),
                    SizedBox(
                      width: size.width,
                      height: 200,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder:
                            (context, index) {
                          return ClientReviewCard(size: size);
                        },),

                    ),

                    // Container(
                    //   width: size.width,
                    //   height: 400,
                    //   child:  Column(
                    //     children: [
                    //       ListTile(
                    //         leading: CircleAvatar(
                    //           backgroundImage:  AssetImage(ImageConstant.man),
                    //         ),
                    //         title: Text("Client Name",style: AppTextStyle.bodyMedium,),
                    //         subtitle: Text("22 Jan, 2023",style: AppTextStyle.bodySmallBlack400S15CGrey,),
                    //         trailing:Row(
                    //           children: [
                    //             Expanded(
                    //               child: RatingBarIndicator(
                    //                 rating: 4.4,
                    //                 itemBuilder: (context, index) => Icon(
                    //                   Icons.star,
                    //                   color: AppColors.colorLightBlack,
                    //                 ),
                    //                 itemCount: 5,
                    //                 itemSize: 16.0,
                    //                 direction: Axis.horizontal,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(
                      height: 10,
                    ),
                    Text("Explore Top Services", style: AppTextStyle.titleText),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: size.width,
                        height: 300,
                        child: FutureBuilder(
                          future: homeController.getOfferList,
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
                              return const CircularProgressIndicator();
                            }
                          },
                        )
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




