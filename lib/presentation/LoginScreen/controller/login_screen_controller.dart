
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:upai/data/repository/repository_details.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  RxBool progress =false.obs;
  final CIDTE = TextEditingController();
  final passwordTE = TextEditingController();
  final userMobileTE = TextEditingController();
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  RxBool isHidden = true.obs;
  RxBool enterCorrectPhone = false.obs;
  RxBool otpVerification= false.obs;
  // Timer? timer;
  var phoneNumber = ''.obs;

  void changeVisibilty()
  {
    print("method Called");
    isHidden.value=!isHidden.value;
    update();

  }
  @override
  void onInit() {
    phoneController.value.addListener(() {
      phoneNumber.value =phoneController.value.text;
    },);
    super.onInit();
  }
//   void startTimer(){
//     timer=Timer.periodic(Duration(seconds: 2), (timer) {
// time.value.
//     },);
//   }
  }

