import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/buyer%20profile/buyer_profile_controller.dart';
import 'package:upai/presentation/seller-service/seller_profile_screen.dart';
import 'package:upai/presentation/Inbox/inbox.dart';
import 'package:upai/presentation/Profile/profile_screen.dart';
import 'package:upai/presentation/notification/notificaton_screen.dart';
import 'seller-service/controller/seller_profile_controller.dart';

class DefaultController extends GetxController {
  late UserInfoModel userData;
  final box = Hive.box("userInfo");
  // String userType="";
  @override
  void onInit() {

    userData = userInfoModelFromJson(box.get('user'));
    Get.put(ProfileScreenController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(SellerProfileController(), permanent: true);
    Get.put(BuyerProfileController(), permanent: true);
    FirebaseAPIs.getSelfInfo();
    WidgetsBinding.instance.addObserver(AppLifecycleListener());

    // var userJsonString = box.get('user');
    // Map<String,dynamic> data = json.decode(userJsonString.toString());
    // userType = data['user_type'].toString();

    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline

    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (box.isNotEmpty) {
        if (message.toString().contains('resume')) {
          FirebaseAPIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          FirebaseAPIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });

    // TODO: implement onInit
    super.onInit();
  }

  final List<Widget> screensForClient = [
    const HomeScreen(),
    const SellerProfileScreen(),
    // ExploreScreen(),
     const InboxScreen(),
    const NotificationScreen(),
    // ProfileScreen()
  ];
  // final List<Widget> screensForServiceProvider = [
  //   const HomeScreen2(),
  //   const InboxScreen(),
  //    ExploreScreen(),
  //   // const ProfileScreen()
  // ];
  var selectedColor = AppColors.kprimaryColor;
  RxInt selectedIndex = 0.obs;
  var unselected = AppColors.appTextColorGrey;
  RxString appBarTitle = "Upai".obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        appBarTitle.value = "Upai";
        // if(HomeController.to.searchICon.value){
        //   HomeController.to.searchICon.value=false;
        // }
      case 1:
        appBarTitle.value = "My Services";
      // case 2:
      //   appBarTitle.value="Explore";
      case 2:
        appBarTitle.value = "Inbox";
      case 3:
        appBarTitle.value = "Notification";
      //
      // case 4:
      //   appBarTitle.value="Profile";
    }
  }
}
