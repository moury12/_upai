import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/Profile/profile_screen.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/SplashScreen/controller/splash_screen_controller.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';

import '../core/utils/image_path.dart';
import '../data/api/firebase_apis.dart';
import '../testnotification/notification_screen_test.dart';

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
                      child: ProfileScreenController
                              .to.profileImageUrl.value.isNotEmpty
                          ? Image.network(
                              ProfileScreenController.to.profileImageUrl.value,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            errorBuilder  :
                                  (context, child, loadingProgress) => SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                          child: CircularProgressIndicator())),
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
                  child:  Text(
                        ProfileScreenController.to.userInfo.name.toString(),
                        style: AppTextStyle.bodyLarge700.copyWith(
                          fontSize: 20.0,
                          color: AppColors.primaryTextColor,
                        ),

                  ),
                ),
                Center(
                  child:  Text(
                        ProfileScreenController.to.userInfo.userId.toString(),
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
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () {},
                ),
                _buildMenuOption(
                  icon: Icons.logout,
                  label: 'Log out',
                  onTap: () async {
                    final box = Hive.box('userInfo');
                    await box.delete("user");
                    SplashScreenController.to.isLogin.value = false;
                    Get.delete<SellerProfileController>(force: true);
                    Get.delete<HomeController>(force: true);
                    Get.delete<ProfileScreenController>(force: true);
                    print("Data deleted");
                    FirebaseAPIs.updateActiveStatus(false);
                    Get.offAllNamed('/login');
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ListTile(
            leading: Icon(icon, color: AppColors.iconColor),
            title: Text(
              label,
              style: TextStyle(
                color: AppColors.primaryTextColor,
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
