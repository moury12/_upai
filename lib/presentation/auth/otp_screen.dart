import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/data/repository/repository_details.dart';
import 'package:upai/presentation/auth/controller/login_screen_controller.dart';
import 'package:upai/presentation/auth/widgets/count_down_timer_widget.dart';
import 'package:upai/widgets/custom_button.dart';
import 'package:upai/widgets/custom_text_field.dart';

import 'widgets/otp_container.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  AnimationController? controller;
  int levelClock = 120;
  late FocusNode text1, text2, text3, text4;

  @override
  void initState() {
    text1 = FocusNode();
    text2 = FocusNode();
    text3 = FocusNode();
    text4 = FocusNode();

    text1.requestFocus();
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    super.initState();
  }

  void clear() {
    LoginController.to.firstOtpController.value.clear();
    LoginController.to.secondOtpController.value.clear();
    LoginController.to.thirdOtpController.value.clear();
    LoginController.to.forthOtpController.value.clear();
  }
@override
  void dispose() {
    controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(size:defaultAppBarIconSize ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Obx(() {
          bool areAllOtpFieldsFilled =
              (LoginController.to.firstOtp.value.toString() != '' &&
                  LoginController.to.secondOtp.value.toString() != '' &&
                  LoginController.to.thirdOtp.value.toString() != ''/* &&
                  LoginController.to.fourthOtp.value.toString() != ''*/);
          debugPrint(LoginController.to.firstOtp.value);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: LoginController.to.otpVerification.value
                ? [
                     Text(
                      'Mobile Number Verification',
                      style:
                          TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                        text: TextSpan(text: '', children: [
                      TextSpan(
                        text: 'Enter OTP code sent to ',
                        style: TextStyle(
                            fontSize: default14FontSize,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      TextSpan(
                        text: LoginController.to.phoneController.value.text,
                        style:  TextStyle(
                            fontSize: default14FontSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ])),
                    defaultSizeBoxHeight,
                    Row(
                      children: [
                        OtpContainer(
                            controller:
                                LoginController.to.firstOtpController.value,
                            focusNode: text1),
                        OtpContainer(
                            controller:
                                LoginController.to.secondOtpController.value,
                            focusNode: text2),
                        OtpContainer(
                            controller:
                                LoginController.to.thirdOtpController.value,
                            focusNode: text3),
                        OtpContainer(
                            controller:
                                LoginController.to.forthOtpController.value,
                            focusNode: text4),
                        // OtpContainer(
                        //     controller: fifthOtpController, focusNode: text5),
                        // OtpContainer(
                        //     controller: sixthOtpController, focusNode: text6),
                      ],
                    ),
                    defaultSizeBoxHeight,
                    Row(children: [
                      Text(
                        'Resend Code in ',
                        style: TextStyle(
                            fontSize: default14FontSize,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      CountDownWidget(
                        animation: StepTween(begin: levelClock, end: 0)
                            .animate(controller!),
                        onResendTap: () {
                          controller!.reset();
                          controller!.forward();
                        },
                      )
                    ]),
                    TextButton(
                      onPressed: () {
                        LoginController.to.otpVerification.value = false;
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: AppColors.kprimaryColor,
                          backgroundColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          surfaceTintColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          padding: EdgeInsets.zero),
                      child: const Text('Change Mobile Number'),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: "Login",
                      onTap: areAllOtpFieldsFilled ? () async{
                        debugPrint("${LoginController.to.firstOtpController.value.text+LoginController.to.secondOtpController.value.text+LoginController.to.thirdOtpController.value.text}");
                        await RepositoryData().login(
                            "upai",
                          LoginController.to.phoneController.value.text,
                            LoginController.to.firstOtpController.value.text+LoginController.to.secondOtpController.value.text+LoginController.to.thirdOtpController.value.text
                           );
                      } : null,
                    ),
                    defaultSizeBoxHeight
                  ]
                : [
                     Text(
                      'Continue with your mobile number',
                      style:
                          TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    defaultSizeBoxHeight,
                    defaultSizeBoxHeight,
                    Obx(() {
                      return CustomTextField(
                        labelText: "Mobile Number",
                        enableBorderColor: Colors.grey.withOpacity(.5),
                        validatorText: "Please Enter Mobile Number",
                        prefixIcon: Icons.call,
                        inputType: TextInputType.number,
                        hintText: "Enter your mobile number",
                        controller: LoginController.to.phoneController.value,
                      );
                    }),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Obx(() {
                        return CustomButton(
                            text: "Continue",
                            color: /*LoginController
                                            .to.phoneNumber.value.length ==
                                        11 &&*/
                                    RegExp(r'^-?[0-9]+$').hasMatch(
                                        LoginController.to.phoneNumber.value)
                                ? AppColors.kprimaryColor
                                : Colors.grey,
                            onTap: /*LoginController
                                .to.phoneNumber.value.length ==
                                11 &&*/
                                RegExp(r'^-?[0-9]+$').hasMatch(
                                    LoginController.to.phoneNumber.value)
                                ? () {
                                    LoginController.to.otpVerification.value =
                                        true;
                                    controller!.forward();
                                  }
                                : null);
                      }),
                    )
                  ],
          );
        }),
      ),
    );
  }
}
