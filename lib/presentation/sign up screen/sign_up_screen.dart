import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
import 'package:upai/presentation/LoginScreen/login_screen.dart';
import 'package:upai/widgets/custom_text_field.dart';

import '../../data/repository/repository_details.dart';
import '../../widgets/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE4E4E4),
      appBar: AppBar(
        backgroundColor:const Color(0xffdedede) ,
        title: Text("Sign Up Screen"),
        centerTitle: true,
      ),
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

                      SizedBox(
                          height: 200,
                          width: 200,
                          child: Image(image: AssetImage(ImageConstant.upailogo),fit: BoxFit.cover,)),
                      const SizedBox(height: 20,),
                      CustomTextField(
                        validatorText: "Please Enter CID",
                        prefixIcon: Icons.numbers,
                        hintText: "CID",
                        controller: controller.CIDTE,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        validatorText: "Please Enter User ID",
                        prefixIcon: Icons.format_list_numbered,
                        hintText: "User ID",
                        controller: controller.userMobileTE,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        validatorText: "Please Enter User Name",
                        prefixIcon: Icons.person,
                        hintText: "User Name",
                        controller: controller.userMobileTE,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        validatorText: "Please Enter User Email",
                        prefixIcon: Icons.email,
                        hintText: "User Email",
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
                      const SizedBox(height: 10),
                      CustomTextField(
                        validatorText: "Please Enter User Password",

                        prefixIcon: Icons.lock,
                        hintText: "Password",
                        controller: controller.passwordTE,
                        // onChanged: (value) => controller.emailController.text.trim() = value!,
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        validatorText: "Re-Enter User Password",

                        prefixIcon: Icons.lock,
                        hintText: "Confirm Password",
                        controller: controller.passwordTE,
                        // onChanged: (value) => controller.emailController.text.trim() = value!,
                      ),
                     const SizedBox(height: 20,),
                      CustomButton(
                        text: "Sign Up",
                        onTap: () async {
                          if(_formKey.currentState!.validate())
                          {

                            // UserInfoModel userInfo = UserInfoModel();
                            // userInfo.id = controller.CIDTE.text.trim().toString();
                            // userInfo.userId=controller.userIdTE.text.trim().toString();
                            // RepositoryData().login(controller.CIDTE.text.toString(), controller.userIdTE.text.toString(), controller.passwordTE.text.toString());
                            // FirebaseAPIs.createUser(userInfo.toJson());
                            // var box = Hive.box('userInfo');
                            // await box.put('user',userInfo.toJson());
                            // print(box.values);
                            // FirebaseAPIs.currentUser();
                            // Get.offAndToNamed("/defaultscreen");
                          }


                        },

                      ),
                      const SizedBox(height: 15,),

                      InkWell(
                        onTap: (){
                          Get.offAll(()=>const LoginScreen());
                        },
                        child: RichText(

                            text:TextSpan(
                            children: [
                              TextSpan(

                                  text: "Already have an account?",style: AppTextStyle.titleText),
                              const TextSpan(text: " Log in",style: TextStyle(color: Colors.green)),

                            ],
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
