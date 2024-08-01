

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';

class ProfileScreenController extends GetxController{
  final box = Hive.box("userInfo");
  TextEditingController nameTE = TextEditingController();
  TextEditingController emailTE = TextEditingController();
  TextEditingController phoneTE = TextEditingController();

  @override
  void onInit() {


    // TODO: implement onInit
    super.onInit();
  }

}