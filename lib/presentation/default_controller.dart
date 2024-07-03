import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/Explore/explore_screen.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/HomeScreen2/home_screen2.dart';
import 'package:upai/presentation/Inbox/inbox.dart';
import 'package:upai/presentation/Profile/profile_screen.dart';

class DefaultController extends GetxController

{
  final box = Hive.box("userInfo");

  @override
  void onInit() {
    FirebaseAPIs.getSelfInfo();

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
    HomeScreen(),
    InboxScreen(),
    ExploreScreen(),
    ProfileScreen()
  ];
  final List<Widget> screensForServiceProvider = [
    HomeScreen2(),
    InboxScreen(),
    ExploreScreen(),
    ProfileScreen()
  ];
  var selectedColor = Colors.black;
  RxInt selectedIndex = 0.obs;
  var unselected = AppColors.appTextColorGrey;

  void onItemTapped(int index) {
      selectedIndex.value = index;
  }

}