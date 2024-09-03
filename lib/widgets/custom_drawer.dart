import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/SplashScreen/controller/splash_screen_controller.dart';
import 'package:upai/presentation/buyer%20profile/buyer_profile_controller.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';
import '../core/utils/image_path.dart';
import '../data/api/firebase_apis.dart';
import '../presentation/buyer profile/buyer_running_order_list_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});
  // final UserInfoModel userInfo;
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.backgroundLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Obx(() {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: ProfileScreenController.to.profileImageUrl.value.isNotEmpty
                          ? Image.network(
                              ProfileScreenController.to.profileImageUrl.value,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                              errorBuilder: (context, child, loadingProgress) => SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.kprimaryColor,
                                  ))),
                            )
                          : Image.asset(
                              ImageConstant.senderImg,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),

                      // backgroundColor: Colors.grey.shade200,
                    );
                  }),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Obx(() {
                    return Text(
                      ProfileScreenController.to.userInfo.value.name.toString(),
                      style: AppTextStyle.bodyLarge700.copyWith(
                        fontSize: 20.0,
                        color: AppColors.kprimaryColor,
                      ),
                    );
                  }),
                ),
                Center(
                  child: Text(
                    ProfileScreenController.to.userInfo.value.userId.toString(),
                    style: AppTextStyle.titleText.copyWith(
                      fontSize: 14.0,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildMenuOption(
                  icon: Icons.person,
                  label: 'Profile',
                  onTap: () => Get.toNamed('/profile'),
                ),
                _buildMenuOption(
                  icon: Icons.home_repair_service_rounded,
                  label: 'My Orders',
                  onTap: () {
                    BuyerProfileController.to.getBuyerProfile();
                    Get.to(BuyerRunningOrderListScreen(
                      buyer: BuyerProfileController.to.buyer.value,
                    ));
                  },
                ),
                _buildMenuOption(
                  icon: Icons.logout,
                  label: 'Log out',
                  onTap: () async {
                    FirebaseAPIs.user = {};
                    FirebaseAPIs.updateActiveStatus(false);
                    FirebaseAPIs.deletePushToken(ProfileScreenController.to.userInfo.value.userId.toString());
                    final box = Hive.box('userInfo');
                    await box.delete("user");
                    SplashScreenController.to.isLogin.value = false;
                    Get.delete<SellerProfileController>(force: true);
                    Get.delete<BuyerProfileController>(force: true);
                    Get.delete<HomeController>(force: true);
                    Get.delete<ProfileScreenController>(force: true);
                    print("Data deleted");

                    Get.offAllNamed('/login');
                  },
                ),
                // _buildMenuOption(icon: Icons.add, label: "nw", onTap: (){
                //   Get.to(NotificationScreenTest());
                // })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ListTile(
            leading: Icon(icon, color: AppColors.kprimaryColor),
            title: Text(
              label,
              style: TextStyle(
                color: AppColors.kprimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Divider(
          color: AppColors.dividerColor,
          thickness: 0.8,
        ),
      ],
    );
  }
}
