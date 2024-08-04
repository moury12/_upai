
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/global_variable.dart';
import 'package:upai/widgets/custom_drawer.dart';
import 'package:upai/presentation/default_controller.dart';
import 'package:get/get.dart';

class DefaultScreen extends StatelessWidget {
  final ctrl = Get.put(DefaultController());

  DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return Text(ctrl.appBarTitle.value, style: AppTextStyle.bodyTitle700,);
          }),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        body: ctrl.userType == "Buyer" ? ctrl.screensForClient[ctrl
            .selectedIndex.value] : ctrl.screensForServiceProvider[ctrl
            .selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: SvgPicture.asset('assets/images/home.svg',
                color: ctrl.selectedIndex.value == 0 ? ctrl.selectedColor : ctrl
                    .unselected,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/inbox.svg',
                color: ctrl.selectedIndex.value == 1 ? ctrl.selectedColor : ctrl
                    .unselected,),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/explore.svg',
                color: ctrl.selectedIndex.value == 2 ? ctrl.selectedColor : ctrl
                    .unselected,),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/person.svg',
                color: ctrl.selectedIndex.value == 3 ? ctrl.selectedColor : ctrl
                    .unselected,),
              label: 'Person',
            ),
          ],
          selectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: AppColors.appTextColorGrey,
          selectedIconTheme: IconThemeData(color: ctrl.selectedColor),
          currentIndex: ctrl.selectedIndex.value,
          onTap: ctrl.onItemTapped,
          showUnselectedLabels: true,
        ),
      );
    });
  }
}
