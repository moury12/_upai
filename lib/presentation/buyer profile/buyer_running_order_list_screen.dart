import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/buyer_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/seller-service/seller_running_order_list_screen.dart';
import 'package:upai/presentation/seller-service/widgets/seller_running_order_widget.dart';
import '../../core/utils/custom_text_style.dart';
import 'buyer_profile_controller.dart';

class BuyerRunningOrderListScreen extends StatelessWidget {
  final BuyerProfileModel buyer;

  const BuyerRunningOrderListScreen({
    super.key,
    required this.buyer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:CustomAppBar(title: "buyer_running_orders".tr,),
        body: Obx(() {
          return RefreshIndicator(
            color: AppColors.kprimaryColor,
            backgroundColor: AppColors.strokeColor2,
            child:
                BuyerProfileController.to.buyer.value.buyerRunningOrder!.isEmpty
                    ? const Center(child: Text("No Running order"))
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: ShimmerRunnigOrder(forList: true,),
                    // )
                    : Container(
                        child: ListView.builder(
                          padding: EdgeInsets.all(12),
                          itemCount: BuyerProfileController
                              .to.buyer.value.buyerRunningOrder!.length,
                          itemBuilder: (context, index) {
                            print("count $index");
                            return SellerRunningOrderWidget(
                              isBuyer: true,
                              sellerRunningOrder: BuyerProfileController
                                  .to.buyer.value.buyerRunningOrder![index],
                            );
                          },
                        ),
                      ),
            onRefresh: () {
              return BuyerProfileController.to.refreshAllData();
            },
          );
        }));
  }
}
