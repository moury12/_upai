import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/presentation/HomeScreen/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';
import '../../core/utils/custom_text_style.dart';
import 'widgets/seller_running_order_widget.dart';

class SellerRunningOrderListScreen extends StatelessWidget {
  final List<SellerRunningOrder> runningOrder;

  const SellerRunningOrderListScreen({super.key, required this.runningOrder});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 4 : 2;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // elevation: 0,
          // shadowColor: Colors.transparent,
          // surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.kprimaryColor,
          // foregroundColor: Colors.black,
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
              color: AppColors.kprimaryColor,
                backgroundColor: AppColors.strokeColor2,
                child: !NetworkController
                    .to.connectedInternet.value
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ShimmerRunnigOrder(forList: true,),
                )
                : SellerProfileController.to.seller.value.sellerRunningOrder!.isEmpty||SellerProfileController.to.seller.value.sellerRunningOrder==null?Center(child: Text("Running Order is Empty"),):ListView.builder(padding: EdgeInsets.all(12),
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
