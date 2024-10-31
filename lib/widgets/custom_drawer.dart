import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/auth/otp_screen.dart';
import 'package:upai/presentation/buyer%20profile/buyer_profile_controller.dart';
import 'package:upai/presentation/favourite_offer/favourite_offer_screen.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';
import 'package:upai/presentation/splash/controller/splash_screen_controller.dart';
import 'package:upai/widgets/custom_network_image.dart';
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
          child: Stack(

            children: [
              CustomPaint(
                painter: CurvedPainter(),
                size: MediaQuery.of(context).size,

              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Obx(() {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(360),

                          child: ProfileScreenController
                              .to.profileImageUrl.value.isNotEmpty
                              ? CustomNetworkImage(
                            imageUrl: ProfileScreenController
                                .to.profileImageUrl.value
                                .toString(),
                            height: 100,
                            width: 100,
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
                      defaultSizeBoxWidth,
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Obx(() {
                            return Text(
                              ProfileScreenController.to.userInfo.value.name.toString().toUpperCase(),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight:FontWeight.w700,
                              ),
                            );
                          }),
                          Text(
                            ProfileScreenController.to.userInfo.value.userId.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],),
                      )
                    ],
                  ),
                ),


                const SizedBox(height: 20),
                  Align(

                    alignment: Alignment.bottomRight,
                    child: DropdownButton<Locale>(
                      value: Get.locale,
                      icon: Icon(
                        Icons.language,
                        color: AppColors.kprimaryColor,
                      ),
                      items: [
                        const DropdownMenuItem(
                          value: Locale('en'),
                          child: Text('English'),
                        ),
                        const DropdownMenuItem(
                          value: Locale('bn'),
                          child: Text('বাংলা'),
                        ),
                        // DropdownMenuItem(
                        //   value: Locale('hi'),
                        //   child: Text('Hindi'),
                        // ),
                        // DropdownMenuItem(
                        //   value: Locale('fr'),
                        //   child: Text('French'),
                        // ),
                      ],
                      onChanged: (Locale? locale) {
                        var localeCode = Locale(locale!.languageCode);
                        Get.updateLocale(localeCode);

                      },
                    ),
                  ),
                _buildMenuOption(
                  icon: Icons.person,
                  label: 'profile'.tr,
                  onTap: () {
                    Get.toNamed('/profile');
                    if (Scaffold.of(context).isDrawerOpen) {
                      Scaffold.of(context).closeDrawer();
                    }
                  },
                ),
                _buildMenuOption(
                  icon: Icons.home_repair_service_rounded,
                  label: 'my_running_orders'.tr,
                  onTap: () {
                    BuyerProfileController.to.getBuyerProfile();
                    Get.to(BuyerRunningOrderListScreen(
                      buyer: BuyerProfileController.to.buyer.value,
                    ));
                    if (Scaffold.of(context).isDrawerOpen) {
                      Scaffold.of(context).closeDrawer();
                    }
                  },
                ),
                _buildMenuOption(
                  icon: Icons.favorite,
                  label: 'favourite_offer'.tr,
                  onTap: () {
                    Get.to(const FavouriteOfferScreen());
                    if (Scaffold.of(context).isDrawerOpen) {
                      Scaffold.of(context).closeDrawer();
                    }
                    // BuyerProfileController.to.getBuyerProfile();
                    // Get.to(BuyerRunningOrderListScreen(
                    //   buyer: BuyerProfileController.to.buyer.value,
                    // ));
                  },
                ),
                _buildMenuOption(
                  icon: Icons.logout,
                  label: 'logout'.tr,
                  onTap: () async {
                    await FirebaseAPIs.updateActiveStatus(false);
                    await FirebaseAPIs.updatePushToken(
                        ProfileScreenController.to.userInfo.value.userId
                            .toString(),
                        "");
                    final box = Hive.box('userInfo');
                    await box.delete("user");
                    SplashScreenController.to.isLogin.value = false;
                    Get.delete<SellerProfileController>(force: true);
                    Get.delete<BuyerProfileController>(force: true);
                    Get.delete<HomeController>(force: true);
                    Get.delete<ProfileScreenController>(force: true);
                    FirebaseAPIs.user = {};
                    Get.offAll(const OtpScreen());
                  },
                ),



                // const Align(
                //   alignment: Alignment.bottomRight,
                //   child: Text("app version:12-09-2024"),
                // )
              ],)
            ],
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
        const Divider(
          color: AppColors.dividerColor,
          thickness: 0.8,
        ),
      ],
    );
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = AppColors.kprimaryColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;
    double height=150;
    var path = Path();
    path.moveTo(0, height*0.85);
path.quadraticBezierTo(size.width *0.15, height, size.width*0.45, height * 0.85);
path.quadraticBezierTo(size.width *0.85, height*0.70, size.width, height * 0.85);
    path.lineTo(size.width,0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
