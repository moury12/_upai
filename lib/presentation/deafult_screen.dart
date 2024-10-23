import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upai/controllers/filter_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';
import 'package:upai/widgets/custom_drawer.dart';
import 'package:upai/presentation/default_controller.dart';
import 'package:get/get.dart';

class DefaultScreen extends StatelessWidget {
  final ctrl = Get.put(DefaultController());

  DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (ctrl.selectedIndex.value != 0) {
            ctrl.selectedIndex.value = 0;
          } else if (ctrl.selectedIndex.value == 0 &&
              (HomeController.to.searchOfferController.value.text.isNotEmpty ||
                  HomeController.to.selectedDistrictForAll.value != null ||
                  FilterController.to.selectedSortBy.value != null ||
                  FilterController.to.selectedServiceType.value != null ||
                  FilterController.to.selectedCategory.value != null)) {
            resetData();
          } else if (ctrl.selectedIndex.value == 0 ) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.strokeColor2,
                  title: Image.asset(
                    ImageConstant.upailogo1,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                  content: Text(
                    'Are you sure to close this app?',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.cancelButtonColor,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          exit(0);
                        },
                        child: Text('Yes')),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.kprimaryColor,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No'))
                  ],
                );
              },
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.kprimaryColor,
            surfaceTintColor: Colors.white,
            title: Obx(() {
              return ctrl.selectedIndex.value == 0
                  ? Image.asset(
                      ImageConstant.upaiLogoAppbar,
                      height: 90,
                      fit: BoxFit.fitHeight,
                    )
                  : Text(
                      ctrl.appBarTitle.value,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    );
            }),
            centerTitle: true,
          ),
          drawer: const CustomDrawer(),
          body: ctrl.screensForClient[ctrl.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: SvgPicture.asset(
                  height: 24,
                  width: 24,
                  'assets/images/home.svg',
                  color: ctrl.selectedIndex.value == 0
                      ? ctrl.selectedColor
                      : ctrl.unselected,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: SvgPicture.asset(
                  height: 24,
                  width: 24,
                  'assets/images/seller.svg',
                  color: ctrl.selectedIndex.value == 1
                      ? ctrl.selectedColor
                      : ctrl.unselected,
                ),
                label: 'Service',
              ),
              // BottomNavigationBarItem( backgroundColor: Colors.white,
              //   icon: SvgPicture.asset(
              //     height: 24,
              //     width: 24,
              //     'assets/images/explore.svg',
              //     color: ctrl.selectedIndex.value == 2
              //         ? ctrl.selectedColor
              //         : ctrl.unselected,
              //   ),
              //   label: 'Explore',
              // ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: SvgPicture.asset(
                  height: 24,
                  width: 24,
                  'assets/images/inbox.svg',
                  color: ctrl.selectedIndex.value == 2
                      ? ctrl.selectedColor
                      : ctrl.unselected,
                ),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: SvgPicture.asset(
                  height: 24,
                  width: 24,
                  'assets/images/notification.svg',
                  color: ctrl.selectedIndex.value == 3
                      ? ctrl.selectedColor
                      : ctrl.unselected,
                ),
                label: 'Notification',
              ),

              // BottomNavigationBarItem( backgroundColor: Colors.white,
              //   icon: SvgPicture.asset(
              //     // height: 24,
              //     // width: 24,
              //
              //     'assets/images/person.svg',
              //     color: ctrl.selectedIndex.value == 4
              //         ? ctrl.selectedColor
              //         : ctrl.unselected,
              //   ),
              //   label: 'Person',
              // ),
            ],
            selectedItemColor: AppColors.kprimaryColor,
            selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.kprimaryColor),
            unselectedItemColor: AppColors.appTextColorGrey,
            selectedIconTheme: IconThemeData(color: ctrl.selectedColor),
            currentIndex: ctrl.selectedIndex.value,
            onTap: ctrl.onItemTapped,
            showUnselectedLabels: true,
          ),
        ),
      );
    });
  }
}
