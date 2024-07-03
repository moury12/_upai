
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/data/repository/repository_details.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userIdController = TextEditingController();

  login() async {
    await RepositoryData()
        .login(emailController.text.trim(), passwordController.text.trim());
  }
}
