import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
import 'package:upai/presentation/LoginScreen/otp_screen.dart';
import 'package:upai/presentation/LoginScreen/widgets/otp_container.dart';
import 'package:upai/presentation/sign%20up%20screen/sign_up_screen.dart';
import 'package:upai/review/review_screen.dart';
import 'package:upai/widgets/custom_text_field.dart';

import '../../Boxes/boxes.dart';
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
  bool _progress = false;
  final _formKey = GlobalKey<FormState>();
  LoginController controller = LoginController.to;

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
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image(
                      image: AssetImage(ImageConstant.upailogo1),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // CustomTextField(
                  //   validatorText: "Please Enter CID",
                  //   prefixIcon: Icons.account_circle_rounded,
                  //   hintText: "CID",
                  //   controller: controller.CIDTE,
                  // ),
                  // const SizedBox(height: 20),
                  CustomTextField(
                    labelText: "Mobile Number",
                    validatorText: "Please Enter Mobile Number",
                    prefixIcon: Icons.call,
                    inputType: TextInputType.number,
                    hintText: "Enter your mobile number",
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
                    labelText: "Password",
                    validatorText: "Please Enter User Password",
                    isPasswordField: true,
                    prefixIcon: Icons.lock,
                    hintText: "Enter your password",
                    controller: controller.passwordTE,
                    // onChanged: (value) => controller.emailController.text.trim() = value!,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Text("Forget Password?", style: TextStyle()),
                  ),
                  const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: RadioListTile<UserType>(
                  //         activeColor: Colors.green,
                  //         tileColor: Colors.grey[200],
                  //         dense: true,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         contentPadding: EdgeInsets.all(0.0),
                  //         value: UserType.Buyer,
                  //         groupValue: _selectedUserType,
                  //         title: Text(UserType.Buyer.name),
                  //         onChanged: (val) {
                  //           setState(() {
                  //             _selectedUserType = val;
                  //
                  //             print(_selectedUserType!.name);
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Expanded(
                  //       child: RadioListTile<UserType>(
                  //         contentPadding: EdgeInsets.all(0.0),
                  //         tileColor: Colors.grey[200],
                  //         activeColor: Colors.green,
                  //         dense: true,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10.0),
                  //         ),
                  //         value: UserType.Seller,
                  //         groupValue: _selectedUserType,
                  //         title: Text(UserType.Seller.name),
                  //         onChanged: (val) {
                  //           setState(() {
                  //             _selectedUserType = val;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  CustomButton(
                      text: 'Send OTP',
                      onTap: () {
                        Get.toNamed(OtpScreen.routeName);
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child:
                        // controller.progress?CircularProgressIndicator(color: AppColors.titleName):
                        CustomButton(
                      text: "Login",
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          // UserInfoModel userInfo = UserInfoModel();
                          // userInfo.id = controller.CIDTE.text.trim().toString();
                          // userInfo.userId=controller.userIdTE.text.trim().toString();

                         // await RepositoryData().getDmPath(baseUrl: "http://192.168.0.139:8002/upai_api/dmpath");
                          // if (Boxes.getDmPathBox().containsKey("BaseUrl")) {
                            RepositoryData().login(
                                "upai",
                                controller.userMobileTE.text.trim().toString(),
                                controller.passwordTE.text.trim().toString(),
                                _selectedUserType!.name);
                          // }
                          // else
                          //   {
                          //     Get.snackbar("Something wrong!", "Click again");
                          //     return;
                          //   }
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // InkWell(
                  //   onTap: () {
                  //     Get.offAll(() => const SignUpScreen());
                  //   },
                  //   child: RichText(text: TextSpan(
                  //       children: [
                  //         TextSpan(text: "Don't have an account?",
                  //             style: AppTextStyle.titleText),
                  //         const TextSpan(text: " Sign Up",
                  //             style: TextStyle(color: Colors.green))
                  //       ]
                  //   )),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
