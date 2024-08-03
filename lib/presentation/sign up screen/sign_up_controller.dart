import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  RxBool progress = false.obs;
  RxBool isHiddenPass = true.obs;
  RxBool isHiddenConPass = true.obs;
  final CIDTE = TextEditingController();
  final passwordTE = TextEditingController();
  final conPasswordTE = TextEditingController();
  final userMobileTE = TextEditingController();
  final userEmailTE = TextEditingController();
  final userNameTE = TextEditingController();
  void changePassVisibilty()
  {
    print("method Called");
    isHiddenPass.value=!isHiddenPass.value;
    update();

  }
  void changeConPassVisibilty()
  {
    print("method Called");
    isHiddenConPass.value=!isHiddenConPass.value;
    update();

  }
}