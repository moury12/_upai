import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/presentation/home/widgets/shimmer_for_home.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';
import 'widgets/seller_running_order_widget.dart';

class SellerRunningOrderListScreen extends StatelessWidget {
  final List<SellerRunningOrder> runningOrder;

  const SellerRunningOrderListScreen({super.key, required this.runningOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: CustomAppBar(
          title: "seller_running_orders".tr,

        ),
        body: Obx(() {
          return RefreshIndicator(
            color: AppColors.kprimaryColor,
            backgroundColor: AppColors.strokeColor2,
            child: !NetworkController.to.connectedInternet.value
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ShimmerRunnigOrder(
                      forList: true,
                    ),
                  )
                : SellerProfileController
                            .to.seller.value.sellerRunningOrder!.isEmpty ||
                        SellerProfileController
                                .to.seller.value.sellerRunningOrder ==
                            null
                    ? const Center(
                        child: Text("Running Order is Empty"),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: SellerProfileController
                            .to.seller.value.sellerRunningOrder!.length,
                        itemBuilder: (context, index) {
                          return SellerRunningOrderWidget(
                            sellerRunningOrder: SellerProfileController
                                .to.seller.value.sellerRunningOrder![index],
                          );
                        },
                      ),
            onRefresh: () {
              return SellerProfileController.to.refreshAllData();
            },
          );
        }));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.kprimaryColor,
    foregroundColor : Colors.white,
      iconTheme: IconThemeData(
        size: defaultAppBarIcon,
color:  Colors.white
      ),
      titleTextStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      title: Text(
        title,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
