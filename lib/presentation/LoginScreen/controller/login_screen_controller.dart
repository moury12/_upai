
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
  RxBool isHidden = true.obs;

  void changeVisibilty()
  {
    print("method Called");
    isHidden.value=!isHidden.value;
    update();

  }

  // login() async {
  //   await RepositoryData()
  //       .login(CID.text.trim(), passwordTE.text.trim());
  }

