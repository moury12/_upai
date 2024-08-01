import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  RxBool progress = false.obs;
  final CIDTE = TextEditingController();
  final passwordTE = TextEditingController();
  final conPasswordTE = TextEditingController();
  final userMobileTE = TextEditingController();
  final userEmailTE = TextEditingController();
  final userNameTE = TextEditingController();
}