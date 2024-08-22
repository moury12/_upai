import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/SplashScreen/controller/splash_screen_controller.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {

    if (connectivityResult == ConnectivityResult.none) {
      FirebaseAPIs.updateActiveStatus(false);
      Get.rawSnackbar(
          messageText: const Text(
              'PLEASE CONNECT TO THE INTERNET',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
              )
          ),
          isDismissible: true,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon : const Icon(Icons.warning, color: Colors.white, ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }if(SplashScreenController.to.isLogin.value){

       _reloadData();
       FirebaseAPIs.updateActiveStatus(true);
      }
    }
  }
  void _reloadData() async{
    // Call your data loading functions here
    // For example:
   await HomeController.to.refreshAllData();
   await SellerProfileController.to.refreshAllData();
  }
  @override
  void onClose() {

    // TODO: implement onClose
    super.onClose();
  }


}


// class DependencyInjection {
//
//   static void init() {
//     Get.put<NetworkController>(NetworkController(),permanent:true);
//   }
// }