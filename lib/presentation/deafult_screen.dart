import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/global_variable.dart';
import 'package:upai/presentation/Controller/default_controller.dart';
import 'package:upai/presentation/Explore/explore_screen.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/Inbox/inbox.dart';
import 'package:upai/presentation/Profile/profile_screen.dart';
import 'package:upai/widgets/custom_bottom_navbar.dart';
import 'package:get/get.dart';

class DeafultScreen extends StatelessWidget {
  final ctrl = Get.put(DefaultController());
  DeafultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: userType=="client"?ctrl.screensForClient[ctrl.selectedIndex.value]:ctrl.screensForServiceProvider[ctrl.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(

          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: SvgPicture.asset('assets/images/home.svg',
                color: ctrl.selectedIndex.value== 0 ? ctrl.selectedColor : ctrl.unselected,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/inbox.svg',
                color: ctrl.selectedIndex.value == 1 ? ctrl.selectedColor : ctrl.unselected,),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/explore.svg',
                color: ctrl.selectedIndex.value == 2 ? ctrl.selectedColor : ctrl.unselected,),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/person.svg',
                color: ctrl.selectedIndex.value == 3 ? ctrl.selectedColor : ctrl.unselected,),
              label: 'Person',
            ),
          ],
          selectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: AppColors.appTextColor,
          selectedIconTheme: IconThemeData(color:  ctrl.selectedColor),
          currentIndex: ctrl.selectedIndex.value,
          onTap: ctrl.onItemTapped,
          showUnselectedLabels: true,
        ),
      );
    });
  }
}
