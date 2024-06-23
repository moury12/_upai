
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
import 'package:upai/widgets/custom_button.dart';
import 'package:upai/widgets/custom_text_field.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFeild(
              hintText: "Email",
              controller: controller.emailController,
            ),
            const SizedBox(height: 12),
            CustomTextFeild(
              hintText: "Password",
              controller: controller.passwordController,
              // onChanged: (value) => controller.emailController.text.trim() = value!,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: "Login",
              onTap: controller.login,
            )
          ],
        ),
      )),
    );
  }
}
