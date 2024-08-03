import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
import 'package:upai/presentation/sign%20up%20screen/sign_up_screen.dart';
import 'package:upai/widgets/custom_text_field.dart';

import '../../data/repository/repository_details.dart';
import '../../widgets/custom_button.dart';

enum UserType { Buyer, Seller }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserType? _selectedUserType = UserType.Buyer;
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
                      const SizedBox(height: 40,),
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: Image(
                            image: AssetImage(ImageConstant.upailogo),
                            fit: BoxFit.cover,)),
                      const SizedBox(height: 50,),
                      CustomTextField(
                        validatorText: "Please Enter CID",
                        prefixIcon: Icon(
                          Icons.numbers, color: AppColors.primaryColor,),
                        hintText: "CID",
                        controller: controller.CIDTE,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        validatorText: "Please Enter Mobile Number",
                        prefixIcon:Icon(
                          Icons.format_list_numbered, color: AppColors.primaryColor,),
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
                      Obx(() {
                        return CustomTextField(
                            obscureText: controller.isHidden.value,
                            validatorText: "Please Enter User Password",
                            prefixIcon: Icon(
                              Icons.lock, color: AppColors.primaryColor,),
                            hintText: "Password",
                            controller: controller.passwordTE,
                            suffixIcon: InkWell(
                                onTap: (){
                                  controller.changeVisibilty();
                                },
                                child: Container(
                                       child: controller.isHidden.value?const Icon(Icons.visibility_off):Icon(Icons.visibility),
                                ),
                              ),
                          // onChanged: (value) => controller.emailController.text.trim() = value!,
                        );
                      }),
                      const SizedBox(height: 3,),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Text("Forget Password", style: TextStyle()),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<UserType>(
                              activeColor: Colors.green,
                              tileColor: Colors.grey[200],
                              dense: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: EdgeInsets.all(0.0),
                              value: UserType.Buyer,
                              groupValue: _selectedUserType,
                              title: Text(UserType.Buyer.name),
                              onChanged: (val) {
                                setState(() {
                                  _selectedUserType = val;

                                  print(_selectedUserType!.name);
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RadioListTile<UserType>(
                              contentPadding: EdgeInsets.all(0.0),
                              tileColor: Colors.grey[200],
                              activeColor: Colors.green,
                              dense: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              value: UserType.Seller,
                              groupValue: _selectedUserType,
                              title: Text(UserType.Seller.name),
                              onChanged: (val) {
                                setState(() {
                                  _selectedUserType = val;
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Obx(() {
                        if (controller.progress.value) {
                          return CircularProgressIndicator(
                              color: AppColors.titleName);
                        }
                        else {
                          return CustomButton(
                            text: "Login",
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                controller.progress.value = true;
                                await RepositoryData().login(
                                    controller.CIDTE.text.trim().toString(),
                                    controller.userMobileTE.text.trim()
                                        .toString(),
                                    controller.passwordTE.text.trim()
                                        .toString(), _selectedUserType!.name);
                                controller.progress.value = false;
                              }
                            },

                          );
                        }
                      }),

                      const SizedBox(height: 20,),

                      InkWell(
                        onTap: () {
                          controller.progress.value = false;
                          Get.offAll(() => const SignUpScreen());
                        },
                        child: RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "Don't have an account?",
                                  style: AppTextStyle.titleText),
                              const TextSpan(text: " Sign Up",
                                  style: TextStyle(color: Colors.green))
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
