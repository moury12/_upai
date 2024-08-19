import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/controllers/order_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
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
  static const String routeName = '/offer-details';
  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    //  ItemServiceModel singleItem = ItemServiceModel();
    var ctrl = Get.put(ServiceDetailsController());
    var size = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        HomeController.to.selectedRateType.value = null;
      },
      child: Scaffold(
        body: SafeArea(
          child: widget.offerDetails == null
              ? Center(
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
                                      if (ctrl.isFav.value) {
                                        ctrl.isFav.value = false;
                                      } else {
                                        ctrl.isFav.value = true;
                                      }
                                    },
                                    icon: ctrl.isFav.value
                                        ? const FaIcon(
                                            FontAwesomeIcons.solidHeart,
                                            color: Colors.red,
                                          )
                                        : const FaIcon(
                                            FontAwesomeIcons.heart,
                                          ),
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
                        leading: FittedBox(
                          child: CircleAvatar(
                            backgroundImage: AssetImage(ImageConstant.man),
                          ),
                        ),
                        title: Text(
                          widget.offerDetails!.userName.toString(),
                          style: AppTextStyle.bodyMedium,
                        ),
                        trailing: SizedBox.shrink(),
                        subtitle: OverflowBar(
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
                              widget.offerDetails!.description.toString(),
                              style: AppTextStyle.bodySmallblack,
                              textAlign: TextAlign.justify,
                              trimMode: TrimMode.Line,
                              trimLines: 5,
                              //colorClickableText: Colors.pink,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              moreStyle: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              lessStyle: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Price",
                                        style: AppTextStyle.bodySmallGrey,
                                      ),
                                      Text(
                                        "৳ ${widget.offerDetails!.rate.toString()}/${widget.offerDetails!.rateType}",
                                        style: AppTextStyle.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            UserInfoModel senderData =
                                                UserInfoModel();
                                            Map<String, dynamic>? userDetails;
                                            userDetails = await FirebaseAPIs()
                                                .getSenderInfo("016");
                                            if (userDetails!.isNotEmpty) {
                                              senderData.userId =
                                                  userDetails["user_id"] ?? "";
                                              senderData.name =
                                                  userDetails["name"] ?? "user";
                                              senderData.email =
                                                  userDetails["email"];
                                              senderData.lastActive =
                                                  userDetails["last_active"];
                                              senderData.image = userDetails[
                                                      "image"] ??
                                                  "https://img.freepik.com/free-photo/young-man-with-glasses-bow-tie-3d-rendering_1142-43322.jpg?t=st=1720243349~exp=1720246949~hmac=313470ceb91cfcf0621b84a20f2738fbbd35f6c71907fcaefb6b0fd0b321c374&w=740";
                                              senderData.isOnline =
                                                  userDetails["is_online"];
                                              senderData.userType =
                                                  userDetails["user_type"];
                                              senderData.token =
                                                  userDetails["token"];
                                              senderData.mobile =
                                                  userDetails["mobile"];
                                              senderData.cid =
                                                  userDetails["cid"];
                                              senderData.pushToken =
                                                  userDetails["push_token"];
                                            }

                                            Get.toNamed("/chatscreen",
                                                arguments: senderData);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 12),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              backgroundColor:
                                                  AppColors.BTNbackgroudgrey,
                                              foregroundColor:
                                                  AppColors.colorWhite),
                                          child: Text(
                                            "Chat Now",
                                            textAlign: TextAlign.center,
                                            style: AppTextStyle.bodySmallwhite,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.put(OrderController());
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ConfrimOfferWidget(
                                                service: widget,
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 12),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              backgroundColor:
                                                  AppColors.BTNbackgroudgrey,
                                              foregroundColor:
                                                  AppColors.colorWhite),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            "Confirm Offer",
                                            style: AppTextStyle.bodySmallwhite,
                                          ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Text(
                                        "4.4",
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
                                        rating: 4.4,
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
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          alignment: Alignment.center,
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white),
                                      onPressed: () => showDialog(
                                            context: context,
                                            builder: (context) =>
                                                ReviewScreen(),
                                          ),
                                      child: Text(
                                        'review',
                                        textAlign: TextAlign.center,
                                      )),
                                )
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
                            Text("Client Review",
                                style: AppTextStyle.titleText),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: size.width,
                              height: 200,
                              child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ClientReviewCard(size: size);
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
                                            height: 200,
                                            child: MyServiceWidget(
                                              offerList: HomeController
                                                  .to.getOfferList[index],
                                              button: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child:  ElevatedButton(
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
                                                      child: Text('Book Now'),
                                                    ),

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
      ),
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
