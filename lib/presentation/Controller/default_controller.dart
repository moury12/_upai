import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/Explore/explore_screen.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/HomeScreen2/home_screen2.dart';
import 'package:upai/presentation/Inbox/inbox.dart';
import 'package:upai/presentation/Profile/profile_screen.dart';

class DefaultController extends GetxController

{

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
  var unselected = AppColors.appTextColor;

  void onItemTapped(int index) {
      selectedIndex.value = index;
  }

}