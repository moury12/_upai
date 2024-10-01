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
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/core/utils/my_date_util.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/ServiceDetails/rating_list_screen.dart';
import 'package:upai/presentation/create%20offer/widget/tab_content_view.dart';
import 'package:upai/presentation/full_screen_image.dart';
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
  Map<String, dynamic> sellerDetails = {};
  static const String routeName = '/offer-details';
  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  String image =
      "https://lh5.googleusercontent.com/proxy/t08n2HuxPfw8OpbutGWjekHAgxfPFv-pZZ5_-uTfhEGK8B5Lp-VN4VjrdxKtr8acgJA93S14m9NdELzjafFfy13b68pQ7zzDiAmn4Xg8LvsTw1jogn_7wStYeOx7ojx5h63Gliw";
  @override
  void initState() {
    // getSellerDetails();
    Get.put(ServiceDetailsController());
    ProfileScreenController.to.profileImageUrl.value = '';

    ProfileScreenController.to.id.value = widget.offerDetails!.userId ?? '';
// ProfileScreenController.to.fetchProfileImage();
//     debugPrint(widget.offerDetails!.buyerReviewList!.toList().toString());
    super.initState();
  }

  @override
  void dispose() {
    ProfileScreenController.to.profileImageUrl.value = '';

    ProfileScreenController.to.id.value =
        ProfileScreenController.to.userInfo.value.userId ?? '';
    ProfileScreenController.to.fetchProfileImage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        HomeController.to.selectedRateType.value = null;
      },
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () async {
            if (ProfileScreenController.to.userInfo.value.userId ==
                widget.offerDetails!.userId) {
              Get.snackbar("This is your Service", "");
            } else {
              UserInfoModel senderData = UserInfoModel();
              Map<String, dynamic>? userDetails;
              userDetails = await FirebaseAPIs()
                  .getSenderInfo(widget.offerDetails!.userId.toString());
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
            }
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              overlayColor: AppColors.kprimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: AppColors.colorWhite,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  child: FutureBuilder(
                    future: ProfileScreenController.to.getProfileImageURL(
                        widget.offerDetails!.userId.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.connectionState == ConnectionState.none) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: AppColors.kprimaryColor,
                        ));
                      } else if (snapshot.hasData) {
                        if (snapshot.data != "") {
                          return CachedNetworkImage(
                            imageUrl: snapshot.data.toString(),
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 20,
                              backgroundImage: imageProvider,
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                              color: AppColors.kprimaryColor,
                            ), // Loading indicator
                            errorWidget: (context, url, error) => CircleAvatar(
                                radius: 20,

                                // radius: 30,
                                backgroundImage: AssetImage(
                                  ImageConstant.senderImg,
                                )), // Error icon
                          );
                        } else {
                          return CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                ImageConstant.senderImg,
                              ));
                        }
                      } else {
                        return CircleAvatar(
                            radius: 20,
                            // radius: 30,
                            backgroundImage: AssetImage(
                              ImageConstant.senderImg,
                            ));
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Chat",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: AppColors.backgroundLight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: ElevatedButton(
              onPressed: () {
                if (ProfileScreenController.to.userInfo.value.userId ==
                    widget.offerDetails!.userId) {
                  Get.snackbar("This is your Service", "");
                } else {
                  Get.put(OrderController());
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmOfferRequestWidget(
                      service: widget,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: AppColors.kprimaryColor,
              ),
              child: Text(
                "Confirm Offer(Basic)",
                style: AppTextStyle.bodySmallwhite,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 25,
            ),
          ),
          actions: [
            Obx(() {
              return IconButton(
                onPressed: () {
                  print( ServiceDetailsController.to.isFav.value.toString());
                  ServiceDetailsController.to.isFav.value =! ServiceDetailsController.to.isFav.value;
                  // ServiceDetailsController.to.isFav.value = widget.offerDetails!.isFav;
                },
                icon: ServiceDetailsController.to.isFav.value
                    ? Icon(
                        CupertinoIcons.heart_fill,
                        size: 25,
                        color: AppColors.kprimaryColor,
                      )
                    : Icon(
                        CupertinoIcons.heart,
                        size: 25,
                      ),
              );
            }),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(
            //     CupertinoIcons.share,
            //   ),
            // ),
          ],
        ),
        body: SafeArea(
          child: widget.offerDetails == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kprimaryColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width,
                        height: 200,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(FullScreenImage(imageUrl: image));
                          },
                          child: FutureBuilder(
                            future: FirebaseAPIs.fetchOfferImageUrl(
                                widget.offerDetails!.offerId.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting &&
                                  snapshot.connectionState ==
                                      ConnectionState.none) {
                                return Image.asset(
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.none,
                                  ImageConstant.dummy,
                                  // height: 80,
                                );
                              } else if (snapshot.hasData) {
                                image = snapshot.data.toString();
                                return Image.network(
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    snapshot.data.toString());
                              } else {
                                return FutureBuilder(
                                  future:
                                      FirebaseAPIs.fetchDefaultOfferImageUrl(
                                          widget
                                              .offerDetails!.serviceCategoryType
                                              .toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.waiting &&
                                        snapshot.connectionState ==
                                            ConnectionState.none) {
                                      return Image.asset(
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.none,
                                        ImageConstant.dummy,
                                        // height: 80,
                                      );
                                    } else if (snapshot.hasData) {
                                      image = snapshot.data.toString();
                                      return Image.network(
                                          height: double.infinity,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          snapshot.data.toString());
                                    } else {
                                      return Image.asset(
                                        ImageConstant.dummy,
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.none,
                                      );
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.transparent,
                          child: FutureBuilder(
                            future: ProfileScreenController.to
                                .getProfileImageURL(
                                    widget.offerDetails!.userId.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  snapshot.connectionState ==
                                      ConnectionState.none) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.kprimaryColor,
                                ));
                              } else if (snapshot.hasData) {
                                if (snapshot.data != "") {
                                  return CachedNetworkImage(
                                    imageUrl: snapshot.data.toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 24,
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                      color: AppColors.kprimaryColor,
                                    ), // Loading indicator
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                            radius: 24,

                                            // radius: 30,
                                            backgroundImage: AssetImage(
                                              ImageConstant.senderImg,
                                            )), // Error icon
                                  );
                                } else {
                                  return CircleAvatar(
                                      radius: 24,
                                      backgroundImage: AssetImage(
                                        ImageConstant.senderImg,
                                      ));
                                }
                              } else {
                                return CircleAvatar(
                                    radius: 24,
                                    // radius: 30,
                                    backgroundImage: AssetImage(
                                      ImageConstant.senderImg,
                                    ));
                              }
                            },
                          ),
                        ),
                        horizontalTitleGap: 8.0,
                        title: Text(
                          widget.offerDetails!.userName.toString(),
                          style: AppTextStyle.bodyMediumBlackSemiBold,
                        ),
                        trailing: const SizedBox.shrink(),
                        subtitle: Row(
                          children: [
                            Text(
                              "Completed Job:${widget.offerDetails!.totalCompletedJob.toString()}",
                              style: AppTextStyle.bodySmallBlack600,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.offerDetails!.avgRating,
                                  itemBuilder: (context, index) => const Icon(
                                    CupertinoIcons.star_fill,
                                    color: Colors.black,
                                  ),
                                  unratedColor: Colors.black.withOpacity(.2),
                                  itemCount: 5, // Maximum rating value
                                  itemSize: 10.0, // Size of stars
                                  direction: Axis.horizontal,
                                ),
                                Text(
                                  "${widget.offerDetails!.avgRating.toStringAsFixed(1)}",
                                  style: AppTextStyle.bodySmallBlack600,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          widget.offerDetails!.jobTitle
                              .toString()
                              .toUpperCase(),
                          style: AppTextStyle.bodyLarge700,
                        ),
                      ),
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
                              ],
                            ),

                            DetailItem(
                              title: "Category:",
                              body: widget.offerDetails!.serviceCategoryType
                                  .toString(),
                            ),

                            DetailItem(
                              title: "District:",
                              body:
                                  " ${widget.offerDetails!.district.toString()}",
                            ),
                            DetailItem(
                              title: "Address:",
                              body:
                                  "${widget.offerDetails!.address.toString()}",
                            ),

                            Text(
                              "Description",
                              style: AppTextStyle.bodyMediumBlackBold,
                            ),
                            const SizedBox(
                              height: 5,
                            ),

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
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                              lessStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                            // defaultSizeBoxHeight,
                            DefaultTabController(
                              length: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TabBar(
                                      indicatorColor: AppColors.kprimaryColor,
                                      labelColor: AppColors.kprimaryColor,
                                      overlayColor:
                                          WidgetStateColor.transparent,
                                      tabs: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Basic',
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Standard',
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Premium',
                                          ),
                                        ),
                                      ]),
                                  defaultSizeBoxHeight,
                                  TabContentView(
                                      children: List.generate(
                                    3,
                                    (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Description",
                                          style:
                                              AppTextStyle.bodyMediumBlackBold,
                                        ),
                                        Text(
                                          'A dummy is a type of doll that looks like a person. Entertainers called ventriloquists can make dummies appear to talk. The automobile industry uses dummies in cars to study how safe cars are during a crash. A dummy can also be anything that looks real but doesnt work: a fake.',
                                          style: AppTextStyle.bodySmallGrey400,
                                        ),
                                        defaultSizeBoxHeight,
                                        PackageDetails(
                                          title: "Price",
                                          lable:
                                              "৳ ${widget.offerDetails!.rate.toString()}",
                                        ),
                                        PackageDetails(
                                          title: "Duration",
                                          lable: "6 Days",
                                        ),
                                        PackageDetails(
                                          title: "Revisions",
                                          lable: "4 Days",
                                        ),
                                        ...List.generate(
                                          6,
                                          (index) => PackageDetails(
                                            title: "Logo Transparency",
                                            ticMark: Icon(
                                              CupertinoIcons.checkmark,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),

                            widget.offerDetails!.totalCompletedJob != null &&
                                    widget.offerDetails!.totalCompletedJob!
                                            .toInt() >
                                        0
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Text(
                                                  widget.offerDetails!.avgRating
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .kprimaryColor,
                                                      fontSize: 25),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                RatingBarIndicator(
                                                  rating: widget
                                                      .offerDetails!.avgRating,
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star_rate_rounded,
                                                    color:
                                                        AppColors.kprimaryColor,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 30.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      defaultSizeBoxHeight,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${widget.offerDetails!.buyerReviewList!.length} Reviews",
                                              style: AppTextStyle
                                                  .bodyMediumBlackBold),
                                          GestureDetector(
                                              onTap: () {
                                                Get.to(RatingListScreen(
                                                  buyerReviewList: widget
                                                      .offerDetails!
                                                      .buyerReviewList!,
                                                  overallRating: widget
                                                      .offerDetails!.avgRating,
                                                ));
                                              },
                                              child: Text(
                                                'See All',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        AppColors.kprimaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ))
                                        ],
                                      ),
                                      defaultSizeBoxHeight,
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                            widget
                                                        .offerDetails!
                                                        .buyerReviewList!
                                                        .length <
                                                    5
                                                ? widget.offerDetails!
                                                    .buyerReviewList!.length
                                                : 5,
                                            (index) {
                                              return SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.1,
                                                  height: 150,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: ClientReviewCard(
                                                      maxLine: 3,
                                                      buyerReview: widget
                                                              .offerDetails!
                                                              .buyerReviewList![
                                                          index],
                                                    ),
                                                  ));
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : SizedBox.shrink(),
                            defaultSizeBoxHeight,
                            Text("Explore My Other Services",
                                style: AppTextStyle.titleText),

                            Obx(
                              () {
                                if (HomeController.to.getOfferList.isNotEmpty) {
                                  List<OfferList> offerList =
                                      HomeController.to.getOfferList;
                                  List<OfferList> myOffersList = offerList
                                      .where((offer) =>
                                          offer.userId.toString() ==
                                          widget.offerDetails!.userId
                                              .toString())
                                      .toList();
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        myOffersList.length,
                                        (index) {
                                          if (myOffersList.isNotEmpty) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0)
                                                      .copyWith(left: 8),
                                              child: SizedBox(
                                                width: 180,
                                                height: 180,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ServiceDetails(
                                                            offerDetails:
                                                                myOffersList[
                                                                    index],
                                                          ),
                                                        ));
                                                  },
                                                  child: MyServiceWidget(
                                                    offerItem:
                                                        myOffersList[index],
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Text("");
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.kprimaryColor,
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

  // void getSellerDetails() async {
  //   image = await ProfileScreenController.to.getProfileImageURL(widget.offerDetails!.userId.toString());
  //   // widget.sellerDetails =  (await FirebaseAPIs().getSenderInfo(widget.offerDetails!.userId.toString()))!;
  // }
}

class PackageDetails extends StatelessWidget {
  final String title;
  final String? lable;
  final Widget? ticMark;
  const PackageDetails({
    super.key,
    required this.title,
    this.lable,
    this.ticMark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.bodySmallGrey400,
          ),
          ticMark ??
              Text(
                lable ?? '',
                style: AppTextStyle.textFont14bold,
              ),
        ],
      ),
    );
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
              style: AppTextStyle.textFont14bold,
            )),
            Expanded(
                child: Text(
              body,
              style: AppTextStyle.bodySmallGrey400,
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
