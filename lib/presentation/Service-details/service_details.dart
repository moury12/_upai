import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/Service-details/rating_list_screen.dart';

import 'package:upai/presentation/create-offer/widget/tab_content_view.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/widgets/custom_network_image.dart';
import 'package:upai/widgets/favourite_icon_button.dart';
import '../../Model/offer_list_model.dart';
import 'service_details_controller.dart';
import 'widgets/client_review.dart';

class ServiceDetails extends StatefulWidget {
  static const String routeName = '/service-details';
  ServiceDetails({
    super.key,
    this.offerDetails,

  });
  final OfferList? offerDetails;
  // final String? offerId;
  Map<String, dynamic> sellerDetails = {};

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  void initState() {
    Get.put(ServiceDetailsController());
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ProfileScreenController.to.serviceSellerProfileImageUrl.value = '';

      ProfileScreenController.to.id.value = widget.offerDetails!.userId ?? '';
      loadData();
    });



    super.initState();
  }

  loadData() async {


     ServiceDetailsController.to.getCategoryWiseOfferList(
         category: widget.offerDetails!.serviceCategoryType.toString(),
         mobileNo: widget.offerDetails!.userId.toString());

    await ProfileScreenController.to
        .fetchServiceSellerProfileImage(widget.offerDetails!.userId.toString());

  }

  @override
  Widget build(BuildContext context) {
    double appBarIconSize = ScreenUtil().screenHeight < ScreenUtil().screenWidth
        ? 14.sp
        : defaultAppBarIconSize;
    return Scaffold(
      floatingActionButton:ProfileScreenController.to.userInfo.value.userId ==
          widget.offerDetails!.userId?SizedBox.shrink(): ElevatedButton(
        onPressed: () async {
          if (ProfileScreenController.to.userInfo.value.userId ==
              widget.offerDetails!.userId) {
            showCustomSnackbar(
                title: 'alert'.tr,
                message: "this_is_your_own_service".tr,
                type: SnackBarType.alert);
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
            overlayColor: AppColors.kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: AppColors.colorWhite,
            elevation: 4,
            surfaceTintColor: Colors.transparent,
            shadowColor: AppColors.kPrimaryColor.withOpacity(.5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 30.w,
                width: 30.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Obx(() {
                  return CustomNetworkImage(
                      imageUrl: ProfileScreenController
                          .to.serviceSellerProfileImageUrl.value,
                      errorWidget: Image.asset(ImageConstant.senderImg));
                }),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "chat".tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: defaultTitleFontSize),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.colorWhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ElevatedButton(

            onPressed:ProfileScreenController.to.userInfo.value.userId ==
                widget.offerDetails!.userId?null: () {
              if (ProfileScreenController.to.userInfo.value.userId ==
                  widget.offerDetails!.userId) {
                showCustomSnackbar(
                    title: 'alert'.tr,
                    message: "this_is_your_own_service".tr,
                    type: SnackBarType.alert);
              }
              else {
                Get.put(OrderController());
                var packageName = widget
                    .offerDetails!
                    .package![ServiceDetailsController.to.tabIndex.value]
                    .packageName;
                var packagePrice = widget.offerDetails!
                    .package![ServiceDetailsController.to.tabIndex.value].price;
                var duration = widget
                    .offerDetails!
                    .package![ServiceDetailsController.to.tabIndex.value]
                    .duration;
                OrderController.to.awardCreateJob(
                    duration!,
                    widget.offerDetails!.offerId ?? '',
                    widget.offerDetails!.userId ?? '',
                    widget.offerDetails!.jobTitle ?? '',
                    widget.offerDetails!.description ?? '',
                    (ServiceDetailsController.to.tabIndex.value + 1).toString(),
                    packageName!,
                    packagePrice!);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: AppColors.kPrimaryColor,
            ),
            child: widget.offerDetails!.package == null ||
                    widget.offerDetails!.package!.isEmpty
                ? Text(
                    'confirm'.tr,
                    style: AppTextStyle.bodySmallwhite(context),
                  )
                : Obx(() {
                    return Text(
                      "${'confirm_offer'.tr}  ( ${widget.offerDetails!.package![ServiceDetailsController.to.tabIndex.value].duration} )",
                      style: AppTextStyle.bodySmallwhite(context),
                    );
                  }),
          ),
        ),
      ),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40.w,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
        iconTheme: IconThemeData(size: appBarIconSize),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: FavouriteIconButton(offerItem: widget.offerDetails!),
          )
        ],
      ),
      body: SafeArea(
        child: widget.offerDetails == null
            ? DefaultCircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNetworkImage(
                      imgPreview: true,
                      height: 250.w,
                      imageUrl: widget.offerDetails!.imgUrl ?? '',
                    ),
                    ListTile(
                      leading: Container(
                        height: 40.w,
                        width: 40.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Obx(() {
                          return CustomNetworkImage(
                            imageUrl: ProfileScreenController
                                .to.serviceSellerProfileImageUrl.value,
                            errorWidget: CircleAvatar(
                                backgroundImage: AssetImage(
                              ImageConstant.senderImg,
                            )),
                          );
                        }),
                      ),
                      horizontalTitleGap: 8.sp,
                      title: Text(
                        widget.offerDetails!.userName.toString(),
                        style: AppTextStyle.bodyMediumBlackSemiBold(context),
                      ),
                      trailing: const SizedBox.shrink(),
                      subtitle: Row(
                        children: [
                          Text(
                            "${'completed_job'.tr}:${widget.offerDetails!.totalCompletedJob.toString()}",
                            style: AppTextStyle.bodySmallBlack600(context),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: double.parse(double.parse(
                                        widget.offerDetails!.avgRating ?? '0.0')
                                    .toStringAsFixed(1)),
                                itemBuilder: (context, index) => Icon(
                                  CupertinoIcons.star_fill,
                                  color: Colors.black,
                                ),
                                unratedColor: Colors.black.withOpacity(.2),
                                itemCount: 5, // Maximum rating value
                                itemSize: 10.sp, // Size of stars
                                direction: Axis.horizontal,
                              ),
                              Text(
                                "${double.parse(widget.offerDetails!.avgRating ?? '0.0').toStringAsFixed(1)}",
                                style: AppTextStyle.bodySmallBlack600(context),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.sp),
                      child: Text(
                        widget.offerDetails!.jobTitle.toString().toUpperCase(),
                        style: AppTextStyle.bodyLarge700(context),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${'posted_on'.tr} ${MyDateUtil.formatDate(widget.offerDetails!.dateTime.toString())}",
                                style: TextStyle(fontSize: default10FontSize),
                              ),
                            ],
                          ),
                          DetailItem(
                            title: "${'user_id'.tr}:",
                            body: widget.offerDetails!.userId.toString(),
                          ),

                          DetailItem(
                            title: "${'category'.tr}:",
                            body: widget.offerDetails!.serviceCategoryType
                                .toString(),
                          ),
                          DetailItem(
                            title: "${'service_type'.tr}:",
                            body: widget.offerDetails!.serviceType.toString(),
                          ),
                          DetailItem(
                            title: "${'district'.tr}:",
                            body: "${widget.offerDetails!.district.toString()}",
                          ),
                          DetailItem(
                            title: "${'address'.tr}:",
                            body: "${widget.offerDetails!.address.toString()}",
                          ),

                          Text(
                            "${'description'.tr}",
                            style: AppTextStyle.bodyMediumBlackBold(context),
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          ReadMoreText(
                            widget.offerDetails!.description.toString(),
                            style: AppTextStyle.bodySmallGrey400(context),
                            textAlign: TextAlign.start,
                            trimMode: TrimMode.Line,
                            trimLines: 5,
                            //colorClickableText: Colors.pink,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: ' Show less',
                            moreStyle: TextStyle(
                                fontSize: default12FontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            lessStyle: TextStyle(
                                fontSize: default12FontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                          // defaultSizeBoxHeight,
                          widget.offerDetails!.package!.isNotEmpty
                              ? DefaultTabController(
                                  length: widget.offerDetails!.package!.length,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TabBar(
                                          onTap: (value) {
                                            ServiceDetailsController
                                                .to.tabIndex.value = value;
                                            print(ServiceDetailsController
                                                .to.tabIndex.value);
                                          },
                                          indicatorColor:
                                              AppColors.kPrimaryColor,
                                          labelColor: AppColors.kPrimaryColor,
                                          overlayColor:
                                              WidgetStateColor.transparent,
                                          tabs: List.generate(
                                            widget
                                                .offerDetails!.package!.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget
                                                        .offerDetails!
                                                        .package![index]
                                                        .duration ??
                                                    '',
                                                style: AppTextStyle.tapTitle(
                                                    context),
                                              ),
                                            ),
                                          )),
                                      TabContentView(
                                          children: List.generate(
                                        widget.offerDetails!.package!.length,
                                        (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            widget.offerDetails!.package![index]
                                                    .packageDescription!.isEmpty
                                                ? SizedBox.shrink()
                                                : Text(
                                                    "Description",
                                                    style: AppTextStyle
                                                        .bodyMediumBlackBold(
                                                            context),
                                                  ),
                                            widget.offerDetails!.package![index]
                                                    .packageDescription!.isEmpty
                                                ? SizedBox.shrink()
                                                : Text(
                                                    widget
                                                            .offerDetails!
                                                            .package![index]
                                                            .packageDescription ??
                                                        '',
                                                    style: AppTextStyle
                                                        .bodySmallGrey400(
                                                            context),
                                                  ),
                                            PackageDetails(
                                              title: "Price",
                                              lable:
                                                  "৳ ${widget.offerDetails!.package![index].price ?? ''}",
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                          widget.offerDetails!.totalCompletedJob != null &&
                                  int.parse(widget.offerDetails!
                                              .totalCompletedJob ??
                                          '0') >
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
                                                double.parse(widget
                                                            .offerDetails!
                                                            .avgRating ??
                                                        '0.0')
                                                    .toStringAsFixed(1),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    fontSize: 25.sp),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              RatingBarIndicator(
                                                rating: double.parse(
                                                    double.parse(widget
                                                                .offerDetails!
                                                                .avgRating ??
                                                            '0.0')
                                                        .toStringAsFixed(1)),
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star_rate_rounded,
                                                  color:
                                                      AppColors.kPrimaryColor,
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
                                            "${widget.offerDetails!.totalCompletedJob!.length} Reviews",
                                            style: AppTextStyle
                                                .bodyMediumBlackBold(context)),
                                        GestureDetector(
                                            onTap: () {
                                              Get.to(RatingListScreen(
                                                buyerReviewList: widget
                                                    .offerDetails!
                                                    .buyerReviewList!
                                                    .where(
                                                      (element) => element
                                                          .buyerReview!
                                                          .isNotEmpty,
                                                    )
                                                    .toList(),
                                                overallRating: double.parse(
                                                    double.parse(widget
                                                                .offerDetails!
                                                                .avgRating ??
                                                            '0.0')
                                                        .toStringAsFixed(1)),
                                              ));
                                            },
                                            child: Text(
                                              'See All',
                                              style: TextStyle(
                                                  fontSize: default14FontSize,
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                  fontWeight: FontWeight.w600),
                                            ))
                                      ],
                                    ),
                                    defaultSizeBoxHeight,
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          widget.offerDetails!.buyerReviewList!
                                                      .length <
                                                  5
                                              ? widget.offerDetails!
                                                  .buyerReviewList!.length
                                              : 5,
                                          (index) {
                                            if (widget
                                                .offerDetails!
                                                .buyerReviewList![index]
                                                .buyerReview!
                                                .isNotEmpty) {
                                              return SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.1,
                                                  height: 150.w,
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
                                            } else {
                                              return SizedBox.shrink();
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox.shrink(),



                          Obx(() {

                            return ServiceDetailsController
                                    .to.categoryWiseOfferList.isNotEmpty
                                ?!ServiceDetailsController.to.initialState.value? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text("explore_related_service".tr,
                                      style: AppTextStyle.titleText(context)),
                                    SizedBox(
                                        height: 220,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                              ServiceDetailsController
                                                  .to.categoryWiseOfferList.length,
                                              (index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(12.0)
                                                          .copyWith(left: 6),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      print('maruf');
                                                      // Get.to(ServiceDetails(offerDetails: ServiceDetailsController.to.categoryWiseOfferList[index],));
                                                      // widget.offerDetails!=ServiceDetailsController.to.categoryWiseOfferList[index];
                                                      // setState(() {
                                                      //
                                                      // });

                                                      // OfferList singleOffer =  ServiceDetailsController.to.categoryWiseOfferList[index];
                                                      // Get.delete<ServiceDetailsController>(force: true);

                                                      // print("navigate call");

                                                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ServiceDetails(
                                                      //           offerDetails: ServiceDetailsController.to.categoryWiseOfferList[index],)));
                                                      //  Using GetX navigation to off all routes except for the current one
                                                      //   Get.off(
                                                      //     GetPageRoute(
                                                      //       page: () => ServiceDetails(
                                                      //         offerDetails:ServiceDetailsController.to.categoryWiseOfferList[index],
                                                      //       ),
                                                      //     ),
                                                      //   );
                                    //                                                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                    // //                                                   /*
                                                      Get.offUntil(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ServiceDetails(

                                                                    offerDetails:
                                                                    ServiceDetailsController
                                                                        .to
                                                                        .categoryWiseOfferList[
                                                                    index],
                                                                  ),
                                                            ), (route) {

                                                          return route
                                                              .settings.name !=
                                                              '/ServiceDetails';
                                                        });
                                    //                                                     */
                                    // //   Navigator.pushReplacement(
                                    //                                                     //       context,
                                    //                                                     //       MaterialPageRoute(
                                    //                                                     //           builder: (context) {
                                    //                                                     //
                                    //                                                     //             // ServiceDetailsController.to.getCategoryWiseOfferList(
                                    //                                                     //             //     category: widget.offerDetails!.serviceCategoryType.toString(),
                                    //                                                     //             //     mobileNo: widget.offerDetails!.userId.toString());
                                    //                                                     //             return  ;}
                                    //                                                     //       ));
                                    //                                                     // }
                                    //
                                    //                                                   },);
                                                      // Navigator.pop(context);
                                                      // if(mounted) {
                                                       /* Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) {

                                                                  // ServiceDetailsController.to.getCategoryWiseOfferList(
                                                                  //     category: widget.offerDetails!.serviceCategoryType.toString(),
                                                                  //     mobileNo: widget.offerDetails!.userId.toString());
                                                                  return  ServiceDetails(

                                                                    offerDetails:
                                                                    ServiceDetailsController
                                                                        .to
                                                                        .categoryWiseOfferList[
                                                                    index],
                                                                  ) ;}
                                                            ));*/
                                                      // }
                                                      // Get.off(ServiceDetails(
                                                      //   offerDetails:
                                                      //   ServiceDetailsController
                                                      //       .to
                                                      //       .categoryWiseOfferList[
                                                      //   index],
                                                      // ));
                                                      // Get.offUntil(
                                                      //     MaterialPageRoute(
                                                      //       builder: (context) =>
                                                      //           ServiceDetails(
                                                      //
                                                      //             offerDetails:
                                                      //             ServiceDetailsController
                                                      //                 .to
                                                      //                 .categoryWiseOfferList[
                                                      //             index],
                                                      //           ),
                                                      //     ), (route) {
                                                      //
                                                      //   return route
                                                      //       .settings.name !='/ServiceDetails';
                                                      // });
                                    /*
                                          Get.off(ServiceDetails(
                                            offerDetails:
                                            ServiceDetailsController
                                                .to
                                                .categoryWiseOfferList[
                                            index],
                                          ));
                                    */
                                                      // loadData();

                                                      // loadData();
                                                      // Get.to(
                                                      //   ServiceDetails(
                                                      //
                                                      //     offerDetails:
                                                      //         ServiceDetailsController
                                                      //                 .to
                                                      //                 .categoryWiseOfferList[
                                                      //             index],
                                                      //   ),
                                                      // );
                                                    },
                                                    child: MyServiceWidget(
                                                      offerItem:
                                                          ServiceDetailsController
                                                                  .to
                                                                  .categoryWiseOfferList[
                                                              index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                            :DefaultCircularProgressIndicator()
                                : SizedBox.shrink();
                          }),
                        ],
                      ),
                    )
                  ],
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

class DefaultCircularProgressIndicator extends StatelessWidget {
  const DefaultCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.kPrimaryColor,
      ),
    );
  }
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
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.bodySmallGrey400(context),
            ),
          ),
          ticMark ??
              Text(
                lable ?? '',
                style: AppTextStyle.textFont14bold(context),
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
              style: AppTextStyle.textFont14bold(context),
            )),
            Expanded(
                child: Text(
              body,
              style: AppTextStyle.bodySmallGrey400(context),
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
            style: TextStyle(
              fontSize: defaultTitleFontSize,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
              text: text,
              style: TextStyle(
                fontSize: default14FontSize,
                color: Colors.black.withOpacity(.6),
                fontWeight: FontWeight.w500,
              )),
        ]),
      ),
    );
  }
}
