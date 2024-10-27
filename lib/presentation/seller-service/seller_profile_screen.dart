import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:upai/controllers/order_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/HomeScreen/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/create-offer/create_offer_screen.dart';
import 'package:upai/presentation/seller-service/my_service_details.dart';
import 'package:upai/presentation/seller-service/my_service_list_screen.dart';
import 'package:upai/presentation/seller-service/seller_running_order_list_screen.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';

import 'widgets/create_offer_button.dart';
import 'widgets/seller_running_order_widget.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  @override
  void initState() {
   SellerProfileController.to.refreshAllData();
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
      floatingActionButton: const CreateOfferButton(),
      body: RefreshIndicator(
        color: AppColors.kprimaryColor,
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
                  SellerProfileController.to.sellerProfileLoading.value || !NetworkController.to.connectedInternet.value
                      ? ShimmerSellerStatus()
                      :seller.sellerProfile == null || seller.myService!.isEmpty?SizedBox.shrink():

                      GridView(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(mainAxisSpacing: 6, crossAxisSpacing: getResponsiveFontSize(context, 8), maxCrossAxisExtent: MediaQuery.of(context).size.width / 2.5),
                          shrinkWrap: true,
                          primary: false,
                          children: [
                            SellerStatusWidget(
                              seller: seller,
                              color: AppColors.kprimaryColor,
                              title: 'Earning',
                              value: seller.sellerProfile!.totalEarning,
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
                              value: seller.sellerProfile!.review.toString(),
                            ),
                          ],
                        ),

                  const SizedBox(
                    height: 10,
                  ),
                  seller.sellerRunningOrder != null && seller.sellerRunningOrder!.isEmpty
                      ? const SizedBox.shrink()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 2, child: Text("Running Orders", style: AppTextStyle.titleText)),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(SellerRunningOrderListScreen(runningOrder: seller.sellerRunningOrder ?? []));
                                },
                                child: Text("All Orders >", style: AppTextStyle.titleTextSmallUnderline),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  SellerProfileController.to.sellerProfileLoading.value || !NetworkController.to.connectedInternet.value
                      ? const ShimmerRunnigOrder(forList: false,)
                      : seller.sellerRunningOrder!.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              children: List.generate(
                              seller.sellerRunningOrder!.length < 2 ? seller.sellerRunningOrder!.length : 2,
                              (index) {
                                final runningOrder = seller.sellerRunningOrder![index];
                                return SellerRunningOrderWidget(sellerRunningOrder: runningOrder);
                              },
                            )),
                  seller.myService == null || seller.myService!.isEmpty?const SizedBox.shrink(): Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 2, child: Text("My Offers", style: AppTextStyle.titleText)),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            Get.put(SellerProfileController());
                            Get.to(MyServiceListScreen(service: seller.myService ?? []));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text("All Offers >", style: AppTextStyle.titleTextSmallUnderline),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SellerProfileController.to.sellerProfileLoading.value||  !NetworkController.to.connectedInternet.value
                      ? const ShimmerOfferList()
                      :  seller.myService == null || seller.myService!.isEmpty?NoServiceWidget():GridView.builder(
                          shrinkWrap: true,
                          primary: false,

                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 8, mainAxisSpacing: 8,childAspectRatio: .8),
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

