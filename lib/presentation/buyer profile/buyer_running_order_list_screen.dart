import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/buyer_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/buyer%20profile/widgets/buyer_running_order_widget.dart';
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 4 : 2;
    return Scaffold(
        backgroundColor: AppColors.strokeColor2,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(CupertinoIcons.back),
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
          title: Text(
            "Buyer Running Orders",
            style: AppTextStyle.appBarTitle,
          ),
        ),
        body: Obx(() {
          return RefreshIndicator(
            color: Colors.black,
            backgroundColor: AppColors.strokeColor2,
            child: BuyerProfileController.to.buyer.value.buyerRunningOrder!.isEmpty
                ? const Center(child: Text("No Running order"))
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   child: ShimmerRunnigOrder(forList: true,),
                // )
                : Container(
                    child: ListView.builder(
                      padding: EdgeInsets.all(12),
                      itemCount: BuyerProfileController.to.buyer.value.buyerRunningOrder!.length,
                      itemBuilder: (context, index) {
                        print("count $index");
                        return BuyerRunningOrderWidget(
                          buyerRunningOrder: BuyerProfileController.to.buyer.value.buyerRunningOrder![index],
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
