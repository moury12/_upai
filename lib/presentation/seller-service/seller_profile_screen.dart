import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/controllers/order_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/HomeScreen/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/seller-service/my_service_details.dart';
import 'package:upai/presentation/seller-service/my_service_list_screen.dart';
import 'package:upai/presentation/seller-service/seller_running_order_list_screen.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';
import 'package:upai/presentation/create%20offer/create_offer_screen.dart';

import 'widgets/seller_running_order_widget.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  @override
  void initState() {
    Get.put(OrderController());
    Get.put(NetworkController());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns and aspect ratio dynamically
    int crossAxisCount = 2;

    if (screenWidth > 600) {
      crossAxisCount = 3;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4;
    }
    if (screenWidth > 1232) {
      crossAxisCount = 5;
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.kprimaryColor,
        onPressed: () {
          Get.to(() => const CreateOfferScreen());
        },
        child: const Icon(
          Icons.add_business_outlined,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: RefreshIndicator(
        color: Colors.black,
        backgroundColor: Colors.white,
        onRefresh: () => SellerProfileController.to.refreshAllData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Obx(() {
            var seller = SellerProfileController.to.seller.value;
            /*   if (seller.sellerProfile == null) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                  ),
                ),
              );
            } else {*/
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  seller.sellerProfile == null || !NetworkController.to.connectedInternet.value
                      ? ShimmerSellerStatus()
                      :
                      // SizedBox(
                      //         height: MediaQuery.sizeOf(context).height*.12,
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //           children: [
                      //             Expanded(
                      //               child: SellerStatusWidget(
                      //                 seller: seller,
                      //                 color: Colors.lightBlue,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 8,
                      //             ),
                      //             Expanded(
                      //               child: SellerStatusWidget(
                      //                 seller: seller,
                      //                 color: Colors.deepOrangeAccent,
                      //                 title: 'Completed Job',
                      //                 value: seller.sellerProfile!.completedJob,
                      //                 icon: Icons.verified,
                      //               ),
                      //             ),
                      //             // SizedBox(
                      //             //   width: 5,
                      //             // ),
                      //             // Expanded(
                      //             //   child: SellerStatusWidget(
                      //             //     seller: seller,
                      //             //     color: Colors.lightGreenAccent,
                      //             //     title: 'Review',
                      //             //     icon: Icons.star_rate_rounded,
                      //             //     value: seller.sellerProfile!.review,
                      //             //   ),
                      //             // ),
                      //           ],
                      //         ),
                      //       ),
                      GridView(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(mainAxisSpacing: 6, crossAxisSpacing: getResponsiveFontSize(context, 8), maxCrossAxisExtent: MediaQuery.of(context).size.width / 2.5),
                          shrinkWrap: true,
                          primary: false,
                          children: [
                            SellerStatusWidget(
                              seller: seller,
                              color: AppColors.kprimaryColor,
                            ),
                            SellerStatusWidget(
                              seller: seller,
                              color: AppColors.kprimaryColor,
                              title: 'Complete',
                              value: seller.sellerProfile!.completedJob,
                              icon: Icons.verified,
                            ),
                            SellerStatusWidget(
                              seller: seller,
                              color: AppColors.kprimaryColor,
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
                  seller.sellerRunningOrder != null && seller.sellerRunningOrder!.isEmpty
                      ? SizedBox.shrink()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 2, child: Text("Running Orders", style: AppTextStyle.titleText)),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(RunningOrderListScreen(runningOrder: seller.sellerRunningOrder ?? []));
                                },
                                child: Text("All Orders >>", style: AppTextStyle.titleTextSmallUnderline),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  seller.sellerRunningOrder == null || !NetworkController.to.connectedInternet.value
                      ? ShimmerRunnigOrder()
                      : seller.sellerRunningOrder!.isEmpty
                          ? SizedBox.shrink()
                          : Column(
                              children: List.generate(
                              seller.sellerRunningOrder!.length < 2 ? seller.sellerRunningOrder!.length : 2,
                              (index) {
                                final runningOrder = seller.sellerRunningOrder![index];
                                return SellerRunningOrderWidget(sellerRunningOrder: runningOrder);
                              },
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 2, child: Text("My Services", style: AppTextStyle.titleText)),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            Get.put(SellerProfileController());
                            Get.to(MyServiceListScreen(service: seller.myService ?? []));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text("All services >>", style: AppTextStyle.titleTextSmallUnderline),
                          ),
                        ),
                      ),
                    ],
                  ),
                  seller.myService == null || seller.myService!.isEmpty || !NetworkController.to.connectedInternet.value
                      ? ShimmerOfferList()
                      : GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 8, mainAxisSpacing: 8),
                          itemCount: seller.myService!.reversed.toList().length < 4 ? seller.myService!.reversed.toList().length : 4,
                          itemBuilder: (context, index) {
                            final service = SellerProfileController.to.myService[index];
                            return GestureDetector(
                                onTap: () {
                                  SellerProfileController.to.service.value = service;
                                  Get.to(const MyServiceDetails());
                                },
                                child: MyServiceWidget(
                                  service: service,
                                ));
                          },
                        ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
