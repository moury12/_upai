import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceDetailsController extends GetxController{
  static ServiceDetailsController get to => Get.find();

  var heartIconColor = Colors.white.obs;
  RxBool isFav =  false.obs;


}