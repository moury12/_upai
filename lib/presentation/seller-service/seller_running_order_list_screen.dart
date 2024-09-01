import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/HomeScreen/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';
import '../../core/utils/custom_text_style.dart';
import 'widgets/seller_running_order_widget.dart';

class RunningOrderListScreen extends StatelessWidget {
  final List<SellerRunningOrder> runningOrder;

  RunningOrderListScreen({super.key, required this.runningOrder});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 4 : 2;
    return Scaffold(
        backgroundColor: AppColors.strokeColor2,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.strokeColor2,
          foregroundColor: Colors.black,
          // leading: IconButton(
          //   icon: const Icon(CupertinoIcons.back),
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
          title: Text(
            "Seller Running Orders",
            style: AppTextStyle.appBarTitle,
          ),
        ),
        body: Obx(
          () {
            return RefreshIndicator(
              color: Colors.black,
                backgroundColor: AppColors.strokeColor2,
                child: SellerProfileController.to.seller.value.sellerRunningOrder==null
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ShimmerRunnigOrder(forList: true,),
                )
                : ListView.builder(padding: EdgeInsets.all(12),
              itemCount: SellerProfileController.to.seller.value.sellerRunningOrder!.length,
              itemBuilder: (context, index) {
                return SellerRunningOrderWidget(
                  sellerRunningOrder: SellerProfileController.to.seller.value.sellerRunningOrder![index],
                );
              },
            ), onRefresh: () {
              return SellerProfileController.to.refreshAllData();
            },);
          }
        ));
  }
}