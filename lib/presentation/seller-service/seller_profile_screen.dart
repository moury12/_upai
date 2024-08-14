import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/controllers/order_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/seller-service/my_service_list_screen.dart';
import 'package:upai/presentation/seller-service/running_order_list_screen.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/presentation/create%20offer/create_offer_screen.dart';

import 'widgets/running_order_widget.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  @override
  void initState() {
    Get.put(OrderController());
    Get.put(SellerProfileController());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(

        backgroundColor: AppColors.BTNbackgroudgrey,
        onPressed: () {
          Get.to(() => CreateOfferScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: RefreshIndicator(
        color: Colors.black,
        backgroundColor: Colors.white,
        onRefresh: () => SellerProfileController.to.refreshAllData(),
        child: Obx(() {
          var seller = SellerProfileController.to.seller.value;
          if (seller.sellerProfile == null) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                color: Colors.white,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 8,
                          childAspectRatio: MediaQuery.of(context).size.width <
                                  MediaQuery.of(context).size.height
                              ? 1.2
                              : 2.7,
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 2.5),
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        SellerStatusWidget(
                          seller: seller,
                          color: Colors.lightBlue,
                        ),
                        SellerStatusWidget(
                          seller: seller,
                          color: Colors.deepOrangeAccent,
                          title: 'Completed Job',
                          value: seller.sellerProfile!.completedJob,
                          icon: Icons.verified,
                        ),
                        SellerStatusWidget(
                          seller: seller,
                          color: Colors.lightGreenAccent,
                          title: 'Review',
                          icon: Icons.star_rate_rounded,
                          value: seller.sellerProfile!.review,
                        ),
                      ],
                    ),
                    // Container(
                    //   width: size.width,
                    //   // height: 400,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //     color: AppColors.containerBackground,
                    //   ),
                    //   child: Padding(
                    //     padding:
                    //         const EdgeInsets.only(left: 12, right: 12, top: 16),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Expanded(
                    //             flex: 8,
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   "Your Stats",
                    //                   style:
                    //                       AppTextStyle.bodyMediumSemiBlackBold,
                    //                 ),
                    //                 const SizedBox(
                    //                   height: 13,
                    //                 ),
                    //                 Text(
                    //                   "Total Earning",
                    //                   style: AppTextStyle.titleTextSmall,
                    //                 ),
                    //                 Text(
                    //                   "৳${seller.sellerProfile!.totalEarning.toString() ?? '-'}",
                    //                   style: AppTextStyle.bodyLargeSemiBlack,
                    //                 ),
                    //                 const SizedBox(
                    //                   height: 5,
                    //                 ),
                    //                 Container(
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(4),
                    //                       color: Colors.white,
                    //                     ),
                    //                     padding: const EdgeInsets.all(2),
                    //                     child: Text(
                    //                       "5% increased from previous month ",
                    //                       style: AppTextStyle
                    //                           .bodySmallestTextGrey400,
                    //                     )),
                    //               ],
                    //             )),
                    //         Expanded(
                    //             flex: 5,
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Container(
                    //                   alignment: Alignment.bottomRight,
                    //                   child: const Text("This month"),
                    //                 ),
                    //                 // Align(
                    //                 //   alignment: Alignment.bottomRight,
                    //                 //   child: Text(
                    //                 //       "This month"),
                    //                 // ),
                    //                 const SizedBox(
                    //                   height: 20,
                    //                 ),
                    //                 Text(
                    //                   "Completed Job",
                    //                   style: AppTextStyle.titleTextSmall,
                    //                 ),
                    //                 Text(
                    //                   "${seller.sellerProfile!.completedJob.toString() ?? '-'}",
                    //                   style: AppTextStyle.bodyLargeSemiBlack,
                    //                 ),
                    //                 const SizedBox(
                    //                   height: 5,
                    //                 ),
                    //                 Text(
                    //                   "Review",
                    //                   style: AppTextStyle.bodySmallGrey,
                    //                 ),
                    //                 Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.start,
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.center,
                    //                   children: [
                    //                     const Icon(
                    //                       Icons.star,
                    //                       size: 22,
                    //                     ),
                    //                     Text(
                    //                       "${seller.sellerProfile!.review.toString() ?? '-'}",
                    //                       style:
                    //                           AppTextStyle.bodyLargeSemiBlack,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ))
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
                        Text("Running Orders", style: AppTextStyle.titleText),
                        GestureDetector(
                          onTap: () {
                            Get.to(RunningOrderListScreen(runningOrder: seller.runningOrder??[]));
                          },
                          child: Text("All Orders >>",
                              style: AppTextStyle.titleTextSmallUnderline),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                        children: List.generate(
                      seller.runningOrder!.length < 2
                          ? seller.runningOrder!.length
                          : 2,
                      (index) {
                        final runningOrder = seller.runningOrder![index];
                        return RunningOrderWidget(runningOrder: runningOrder);
                      },
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("My Services", style: AppTextStyle.titleText),
                        GestureDetector(
                          onTap: () {
                            Get.to(MyServiceListScreen(service: seller.myService??[]));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text("All services >>",
                                style: AppTextStyle.titleTextSmallUnderline),
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width >
                                      MediaQuery.of(context).size.height
                                  ? MediaQuery.of(context).size.width / 4
                                  : MediaQuery.of(context).size.width / 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16),
                      itemCount: seller.myService!.length < 4
                          ? seller.myService!.length
                          : 4,
                      itemBuilder: (context, index) {
                        final service = seller.myService![index];
                        return MyServiceWidget(service: service,);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
