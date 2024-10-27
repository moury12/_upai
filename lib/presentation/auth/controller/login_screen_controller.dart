
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
   Rx<TextEditingController> firstOtpController = TextEditingController().obs;
   Rx<TextEditingController> secondOtpController = TextEditingController().obs;
   Rx<TextEditingController> thirdOtpController = TextEditingController().obs;
   Rx<TextEditingController> forthOtpController = TextEditingController().obs;
  RxBool isHidden = true.obs;
  RxBool enterCorrectPhone = false.obs;
  RxBool otpVerification= false.obs;
  // Timer? timer;
  var phoneNumber = ''.obs;
  var firstOtp = ''.obs;
  var secondOtp = ''.obs;
  var thirdOtp = ''.obs;
  var fourthOtp = ''.obs;

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
    firstOtpController.value.addListener(() {
      firstOtp.value =firstOtpController.value.text;
    },);secondOtpController.value.addListener(() {
      secondOtp.value =secondOtpController.value.text;
      print(' secondOtp.value');
      print( secondOtp.value);
    },);thirdOtpController.value.addListener(() {
      thirdOtp.value =thirdOtpController.value.text;
    },);forthOtpController.value.addListener(() {
      fourthOtp.value =forthOtpController.value.text;
    },);
    super.onInit();
  }
  @override
  void onClose() {
    firstOtpController.value.dispose();
    secondOtpController.value.dispose();
    thirdOtpController.value.dispose();
    forthOtpController.value.dispose();
    super.onClose();
  }
//   void startTimer(){
//     timer=Timer.periodic(Duration(seconds: 2), (timer) {
// time.value.
//     },);
//   }
  }

