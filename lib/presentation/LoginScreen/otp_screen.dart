import 'dart:core';
import 'dart:ffi';
import 'dart:ffi';
import 'dart:ffi';
import 'dart:ffi';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/shared.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
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
  int _counter = 0;
  AnimationController? controller;
  int levelClock = 120;
  late FocusNode text1, text2, text3, text4, text5, text6;

  final TextEditingController fifthOtpController = TextEditingController();
  final TextEditingController sixthOtpController = TextEditingController();
  @override
  void initState() {
    text1 = FocusNode();
    text2 = FocusNode();
    text3 = FocusNode();
    text4 = FocusNode();
    text5 = FocusNode();
    text6 = FocusNode();
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
    fifthOtpController.clear();
    sixthOtpController.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Obx(() {
          bool areAllOtpFieldsFilled =
              (LoginController.to.firstOtp.value.toString()!='' &&
                  LoginController.to.secondOtp.value.toString()!='' &&
                  LoginController.to.thirdOtp.value.toString()!='' &&
                  LoginController.to.fourthOtp.value.toString()!='');
          debugPrint(LoginController.to.firstOtp.value);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: LoginController.to.otpVerification.value
                ? [
                    Text(
                      'Mobile Number Verification',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    RichText(
                        text: TextSpan(text: '', children: [
                      TextSpan(
                        text: 'Enter OTP code sent to ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      TextSpan(
                        text: LoginController.to.phoneController.value.text,
                        style: TextStyle(
                            fontSize: 14,
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
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(.5)),
                      ),
                      CountDownWidget(
                          animation: StepTween(begin: levelClock, end: 0)
                              .animate(controller!))
                    ]),
                    TextButton(
                      child: Text('Change Mobile Number'),
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
                    ),
                    Spacer(),
                    CustomButton(
                      text: "Login",
                      onTap: areAllOtpFieldsFilled
                          ? () {}
                          : null,
                    ),
                    defaultSizeBoxHeight
                  ]
                : [
                    Text(
                      'Continue with your mobile number',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Obx(() {
                        return CustomButton(
                            text: "Continue",
                            color: LoginController
                                            .to.phoneNumber.value.length ==
                                        11 &&
                                    RegExp(r'^-?[0-9]+$').hasMatch(
                                        LoginController.to.phoneNumber.value)
                                ? AppColors.kprimaryColor
                                : Colors.grey,
                            onTap: LoginController
                                        .to.phoneNumber.value.length ==
                                    11
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

class CountDownWidget extends AnimatedWidget {
  Animation<int> animation;
  CountDownWidget({super.key, required this.animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      timerText == '0:00' ? 'Resend OTP' : timerText,
      style: TextStyle(color: Colors.green, fontSize: 14),
    );
  }
}
