import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
import 'package:upai/presentation/sign%20up%20screen/sign_up_screen.dart';
import 'package:upai/widgets/custom_text_field.dart';

import '../../data/repository/repository_details.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE4E4E4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40,),
                      SizedBox(
                        height: 200,
                          width: 200,
                          child: Image(image: AssetImage(ImageConstant.upailogo),fit: BoxFit.cover,)),
                      SizedBox(height: 50,),
                      CustomTextField(
                        validatorText: "Please Enter CID",
                        prefixIcon: Icons.numbers,
                        hintText: "CID",
                        controller: controller.CIDTE,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        validatorText: "Please Enter Mobile Number",
                        prefixIcon: Icons.person,
                        hintText: "Mobile Number",
                        controller: controller.userMobileTE,
                      ),
                      // CustomTextFeild(
                      //   hintText: "Name",
                      //   controller: controller.nameTE,
                      // ),
                      // const SizedBox(height: 12),
          
                      // CustomTextFeild(
                      //   hintText: "Email",
                      //   controller: controller.emailTE,
                      // ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        validatorText: "Please Enter User Password",

                        prefixIcon: Icons.lock,
                        hintText: "Password",
                        controller: controller.passwordTE,
                        // onChanged: (value) => controller.emailController.text.trim() = value!,
                      ),
                      const SizedBox(height: 3,),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Text("Forget Password",style: TextStyle()),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: "Login",
                        onTap: () async {
                          if(_formKey.currentState!.validate())
                            {
          
                              // UserInfoModel userInfo = UserInfoModel();
                              // userInfo.id = controller.CIDTE.text.trim().toString();
                              // userInfo.userId=controller.userIdTE.text.trim().toString();
                              RepositoryData().login(controller.CIDTE.text.trim().toString(), controller.userMobileTE.text.trim().toString(), controller.passwordTE.text.trim().toString());

                            }

          
                        },
          
                      ),
                      const SizedBox(height: 20,),

                      InkWell(
                        onTap: (){
                          Get.offAll(()=>const SignUpScreen());
                        },
                        child: RichText(text:TextSpan(
                          children: [
                            TextSpan(text: "Don't have an account?",style: AppTextStyle.titleText),
                            const TextSpan(text: " Sign Up",style: TextStyle(color: Colors.green))
                          ]
                        )),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
