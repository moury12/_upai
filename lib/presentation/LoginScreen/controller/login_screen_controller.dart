
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/data/repository/repository_details.dart';

class LoginController extends GetxController {
  final emailTE = TextEditingController();
  final passwordTE = TextEditingController();
  final userIdTE = TextEditingController();
  final nameTE = TextEditingController();

  login() async {
    await RepositoryData()
        .login(emailTE.text.trim(), passwordTE.text.trim());
  }
}
