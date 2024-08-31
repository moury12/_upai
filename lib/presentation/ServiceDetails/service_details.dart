import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/controllers/order_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/core/utils/my_date_util.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/review/review_screen.dart';
import 'package:upai/widgets/item_service.dart';
import '../../Model/offer_list_model.dart';
import 'service_details_controller.dart';
import 'widgets/client_review.dart';
import 'widgets/rate_by_category_widget.dart';
import 'widgets/request_confirm_offer.dart';

class ServiceDetails extends StatefulWidget {
   ServiceDetails({super.key, this.offerDetails});
  final OfferList? offerDetails;
  Map<String,dynamic> sellerDetails = {};
  static const String routeName = '/offer-details';
  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  String image="";
  @override
  void initState() {
    getSellerDetails();
    ProfileScreenController.to.profileImageUrl.value='';


ProfileScreenController.to.id.value =widget.offerDetails!.userId??'';
// ProfileScreenController.to.fetchProfileImage();
    super.initState();
  }
@override
  void dispose() {
  ProfileScreenController.to.profileImageUrl.value='';

  ProfileScreenController.to.id.value =ProfileScreenController.to.userInfo.value.userId??'';
  ProfileScreenController.to.fetchProfileImage();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //  ItemServiceModel singleItem = ItemServiceModel();
    final ctrl = Get.put(ServiceDetailsController());
    var size = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        HomeController.to.selectedRateType.value = null;
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          color: AppColors.backgroundLight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      UserInfoModel senderData = UserInfoModel();
                      Map<String, dynamic>? userDetails;
                      userDetails = await FirebaseAPIs().getSenderInfo("01777");
                      if (userDetails!.isNotEmpty) {
                        senderData.userId = userDetails["user_id"] ?? "";
                        senderData.name = userDetails["name"] ?? "user";
                        senderData.email = userDetails["email"];
                        senderData.lastActive = userDetails["last_active"];
                        senderData.image = userDetails["image"] ??
                            "https://img.freepik.com/free-photo/young-man-with-glasses-bow-tie-3d-rendering_1142-43322.jpg?t=st=1720243349~exp=1720246949~hmac=313470ceb91cfcf0621b84a20f2738fbbd35f6c71907fcaefb6b0fd0b321c374&w=740";
                        senderData.isOnline = userDetails["is_online"];
                        senderData.userType = userDetails["user_type"];
                        senderData.token = userDetails["token"];
                        senderData.mobile = userDetails["mobile"];
                        senderData.cid = userDetails["cid"];
                        senderData.pushToken = userDetails["push_token"];
                      }
                      Get.toNamed("/chatscreen", arguments: senderData);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.colorBlack,
                    ),
                    child: Text(
                      "Chat Now",
                      style: AppTextStyle.bodySmallwhite,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.put(OrderController());
                      showDialog(
                        context: context,
                        builder: (context) => ConfrimOfferWidget(
                          service: widget,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.colorBlack,
                    ),
                    child: Text(
                      "Confirm Offer",
                      style: AppTextStyle.bodySmallwhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: widget.offerDetails == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width,
                        height: 200,
                        child: Stack(
                          children: [
                            Image.asset(
                              ImageConstant.productImage,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.contain,
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
                                    print(  widget.offerDetails!.description.toString());
                                      if (ctrl.isFav.value) {
                                        ctrl.isFav.value = false;
                                      } else {
                                        ctrl.isFav.value = true;
                                      }
                                    },
                                    icon: ctrl.isFav.value
                                        ? const Icon(CupertinoIcons.heart_fill,color: Colors.red,)
                                        : /*const FaIcon(
                                            FontAwesomeIcons.heart,
                                          ),*/
                                    const Icon(CupertinoIcons.heart),
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
                          widget.offerDetails!.jobTitle.toString(),
                          style: AppTextStyle.bodyMediumBlackBold,
                        ),
                      ),
                      const Divider(),
                      ListTile(

                        leading: FutureBuilder(future: ProfileScreenController.to.getProfileImageURL(widget.offerDetails!.userId.toString()),builder: (context, snapshot) {
                         if(snapshot.hasData)
                           {
                             if(snapshot.data!="") {
                              return CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(snapshot.data.toString())
                              );
                            }
                             else
                               {
                                 return CircleAvatar(
                                     radius: 24,
                                     backgroundImage: AssetImage(ImageConstant.senderImg,)
                                 );
                                 // return Image.asset(
                                 //   ImageConstant.senderImg,
                                 //   height: 150,
                                 //   width: 150,
                                 //   fit: BoxFit.cover,
                                 // );
                               }
                          }
                         else
                           {
                             return CircleAvatar(
                                 radius: 24,
                                 // radius: 30,
                                 backgroundImage: AssetImage(ImageConstant.senderImg,)
                             );
                           }

                        },),
                        horizontalTitleGap: 8.0,
                        title: Text(
                          widget.offerDetails!.userName.toString(),
                          style: AppTextStyle.bodyMediumblack,
                        ),
                        trailing: const SizedBox.shrink(),
                        subtitle: OverflowBar(
                          children: [
                            Text(
                              "${widget.offerDetails!.quantity.toString()} Job completed",
                              style: AppTextStyle.bodySmallGrey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${widget.offerDetails!.avgRating.toString()} Rating ",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(

                                    "Posted on ${MyDateUtil.formatDate(widget.offerDetails!.dateTime.toString())}"),
                                Text(

                                   "🌏 ${ widget.offerDetails!.district.toString()}"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   "Price",
                                      //   style: AppTextStyle.bodyMediumBlack400,
                                      // ),
                                      Text(
                                        "৳ ${widget.offerDetails!.rate.toString()}/${widget.offerDetails!.rateType}",
                                        style: AppTextStyle.bodyLarge900,
                                      ),
                                    ],
                                  ),
                                ),
                                // Expanded(
                                //   flex: 2,
                                //   child: Column(
                                //     children: [
                                //       SizedBox(
                                //         width: double.infinity,
                                //         child: ElevatedButton(
                                //           onPressed: () async {
                                //             UserInfoModel senderData =
                                //                 UserInfoModel();
                                //             Map<String, dynamic>? userDetails;
                                //             userDetails = await FirebaseAPIs()
                                //                 .getSenderInfo("016");
                                //             if (userDetails!.isNotEmpty) {
                                //               senderData.userId =
                                //                   userDetails["user_id"] ?? "";
                                //               senderData.name =
                                //                   userDetails["name"] ?? "user";
                                //               senderData.email =
                                //                   userDetails["email"];
                                //               senderData.lastActive =
                                //                   userDetails["last_active"];
                                //               senderData.image = userDetails[
                                //                       "image"] ??
                                //                   "https://img.freepik.com/free-photo/young-man-with-glasses-bow-tie-3d-rendering_1142-43322.jpg?t=st=1720243349~exp=1720246949~hmac=313470ceb91cfcf0621b84a20f2738fbbd35f6c71907fcaefb6b0fd0b321c374&w=740";
                                //               senderData.isOnline =
                                //                   userDetails["is_online"];
                                //               senderData.userType =
                                //                   userDetails["user_type"];
                                //               senderData.token =
                                //                   userDetails["token"];
                                //               senderData.mobile =
                                //                   userDetails["mobile"];
                                //               senderData.cid =
                                //                   userDetails["cid"];
                                //               senderData.pushToken =
                                //                   userDetails["push_token"];
                                //             }
                                //
                                //             Get.toNamed("/chatscreen",
                                //                 arguments: senderData);
                                //           },
                                //           style: ElevatedButton.styleFrom(
                                //               alignment: Alignment.center,
                                //               padding: EdgeInsets.symmetric(
                                //                   vertical: 12, horizontal: 12),
                                //               shape: RoundedRectangleBorder(
                                //                   borderRadius:
                                //                       BorderRadius.circular(8)),
                                //               backgroundColor:
                                //                   AppColors.BTNbackgroudgrey,
                                //               foregroundColor:
                                //                   AppColors.colorWhite),
                                //           child: Text(
                                //             "Chat Now",
                                //             textAlign: TextAlign.center,
                                //             style: AppTextStyle.bodySmallwhite,
                                //           ),
                                //         ),
                                //       ),
                                //       SizedBox(
                                //         height: 8,
                                //       ),
                                //       SizedBox(
                                //         width: double.infinity,
                                //         child: ElevatedButton(
                                //           onPressed: () {
                                //             Get.put(OrderController());
                                //             showDialog(
                                //               context: context,
                                //               builder: (context) =>
                                //                   ConfrimOfferWidget(
                                //                 service: widget,
                                //               ),
                                //             );
                                //           },
                                //           style: ElevatedButton.styleFrom(
                                //               alignment: Alignment.center,
                                //               padding: EdgeInsets.symmetric(
                                //                   vertical: 12, horizontal: 12),
                                //               shape: RoundedRectangleBorder(
                                //                   borderRadius:
                                //                       BorderRadius.circular(8)),
                                //               backgroundColor:
                                //                   AppColors.BTNbackgroudgrey,
                                //               foregroundColor:
                                //                   AppColors.colorWhite),
                                //           child: Text(
                                //             textAlign: TextAlign.center,
                                //             "Confirm Offer",
                                //             style: AppTextStyle.bodySmallwhite,
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                             DetailItem(
                              title: "User ID:",
                              body:widget.offerDetails!.userId.toString()
                            ),
                            //  DetailItem(
                            //   title: "Offer ID:",
                            //   body: widget.offerDetails!.offerId.toString(),
                            // ),

                            DetailItem(
                              title: "Category:",
                              body: widget.offerDetails!.serviceCategoryType
                                  .toString(),
                            ),

                            DetailItem(
                              title: "Rate Type:",
                              body: widget.offerDetails!.rateType.toString(),
                            ),
                            DetailItem(
                              title: "Rate:",
                              body:"${widget.offerDetails!.rate.toString()} ৳ ",
                            ),
                            DetailItem(
                              title: "Quantity:",
                              body:"${widget.offerDetails!.quantity.toString()} 🛒",
                            ),
                            DetailItem(
                              title: "Address:",
                              body:"${widget.offerDetails!.address.toString()}",
                            ),

                            Text(
                              "Description",
                              style: AppTextStyle.bodyMediumBlackBold,
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
                              widget.offerDetails!.description.toString(),
                              style: AppTextStyle.bodySmallGrey400,
                              textAlign: TextAlign.start,
                              trimMode: TrimMode.Line,
                              trimLines: 5,
                              //colorClickableText: Colors.pink,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: ' Show less',
                              moreStyle: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold,color: Colors.green),
                              lessStyle: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold,color: Colors.blueAccent),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Text(
                            //   "Includes",
                            //   style: AppTextStyle.titleTextSmall,
                            // ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(4),
                            //     color: AppColors.background1,
                            //   ),
                            //   width: size.width,
                            //   height: 100,
                            //   child: ListView.builder(
                            //     itemBuilder: (context, index) {
                            //       return Padding(
                            //         padding: const EdgeInsets.only(
                            //             left: 12.0, right: 12.0, top: 2),
                            //         child: Text(
                            //           "✔️ Feature",
                            //           style: AppTextStyle.bodySmallGrey,
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            const SizedBox(
                              height: 5,
                            ),


                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(8),
                            //     color: AppColors.background1,
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Text(
                            //           "Frequently Asked ",
                            //           style: AppTextStyle.bodyMediumBlack400,
                            //         ),
                            //         const Icon(Icons.arrow_forward_ios)
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.offerDetails!.avgRating.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontSize: getResponsiveFontSize(
                                                context, 16)),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      RatingBarIndicator(
                                        rating: widget.offerDetails!.avgRating,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: AppColors.colorLightBlack,
                                        ),
                                        itemCount: 5,
                                        itemSize: 22.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                                ),
                                // Expanded(
                                //   child: ElevatedButton(
                                //       style: ElevatedButton.styleFrom(
                                //           alignment: Alignment.center,
                                //           backgroundColor: Colors.black,
                                //           foregroundColor: Colors.white),
                                //       onPressed: () => showDialog(
                                //             context: context,
                                //             builder: (context) =>
                                //                 ReviewScreen(),
                                //           ),
                                //       child: Text(
                                //         'review',
                                //         textAlign: TextAlign.center,
                                //       )),
                                // )
                              ],
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // const RateByCat(
                            //   rateCat: "Seller Communication Level",
                            //   rating: "4.6",
                            // ),
                            // const RateByCat(
                            //   rateCat: "Service Quality",
                            //   rating: "4.6",
                            // ),
                            // const RateByCat(
                            //   rateCat: "Service as described",
                            //   rating: "4.6",
                            // ),
                            // const RateByCat(
                            //   rateCat: "Seller Behavior",
                            //   rating: "4.6",
                            // ),
                            // const RateByCat(
                            //   rateCat: "Recommend Service",
                            //   rating: "4.6",
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text("Client Review",
                                style: AppTextStyle.titleText),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: size.width,
                              height: 200,
                              child: ListView.builder(
                                itemCount: widget.offerDetails!.buyerReviewList!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ClientReviewCard(buyerReview:widget.offerDetails!.buyerReviewList![index],size: size);
                                },
                              ),
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
                            Text("Explore Top Services",
                                style: AppTextStyle.titleText),

                            Obx(
                              () {
                                if (HomeController.to.getOfferList.isNotEmpty) {
                                  List<OfferList> offerList =
                                      HomeController.to.getOfferList;
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        offerList.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.all(12.0)
                                              .copyWith(left: 8),
                                          child: SizedBox(
                                            width: 180,
                                            height: 220,
                                            child: MyServiceWidget(
                                              offerList: HomeController
                                                  .to.getOfferList[index],
                                              button: SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.black,
                                                      foregroundColor:
                                                          Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ServiceDetails(
                                                              offerDetails:
                                                                  HomeController
                                                                          .to
                                                                          .getOfferList[
                                                                      index],
                                                            ),
                                                          ));
                                                    },
                                                    child: const Text('Book Now'),
                                                  ),
                                                ),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ));
                                }
                              },
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void getSellerDetails()async {
  image= await ProfileScreenController.to.getProfileImageURL(widget.offerDetails!.userId.toString());
   // widget.sellerDetails =  (await FirebaseAPIs().getSenderInfo(widget.offerDetails!.userId.toString()))!;
  }
}

class DetailItem extends StatelessWidget {
  final String title, body;
  const DetailItem({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              title,
              style: AppTextStyle.bodyMediumBlackBold,
            )),
            Expanded(
                child: Text(
              body,
              style: AppTextStyle.bodyMediumSemiBlackBold,
            )),
          ],
        ),
        const SizedBox(
          height: 3,
        ),
      ],
    );
  }
}

class OfferDialogWidget extends StatelessWidget {
  const OfferDialogWidget({
    super.key,
    required this.label,
    required this.text,
  });

  final String label;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(text: '', children: [
          TextSpan(
            text: '$label   ',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
              text: text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(.6),
                fontWeight: FontWeight.w500,
              )),
        ]),
      ),
    );
  }
}
