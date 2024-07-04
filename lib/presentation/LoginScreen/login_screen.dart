import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
import 'package:upai/widgets/custom_button.dart';
import 'package:upai/widgets/custom_text_field.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFeild(
                    hintText: "user id",
                    controller: controller.userIdTE,
                  ),
                  const SizedBox(height: 12),
                  CustomTextFeild(
                    hintText: "Name",
                    controller: controller.nameTE,
                  ),
                  const SizedBox(height: 12),

                  CustomTextFeild(
                    hintText: "Email",
                    controller: controller.emailTE,
                  ),
                  const SizedBox(height: 12),
                  CustomTextFeild(
                    hintText: "Password",
                    controller: controller.passwordTE,
                    // onChanged: (value) => controller.emailController.text.trim() = value!,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: "Login",
                    onTap: () async {

                      UserInfoModel userInfo = UserInfoModel();
                      userInfo.userEmail = controller.emailTE.text.trim().toString();
                      userInfo.id = "UPAI";
                      userInfo.userName = controller.nameTE.text.trim().toString();
                      userInfo.userId=controller.userIdTE.text.trim().toString();
                      FirebaseAPIs.createUser(userInfo.toJson());
                      var box = Hive.box('userInfo');
                      await box.put('user',userInfo.toJson());
                      print(box.values);
                      FirebaseAPIs.currentUser();
                      Get.offAndToNamed("/defaultscreen");
                    },

                  )
                ],
              ),
            )),
      );
    });
  }
}
