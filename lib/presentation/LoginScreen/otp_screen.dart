import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/widgets/custom_button.dart';

import 'widgets/otp_container.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late FocusNode text1, text2, text3, text4, text5, text6;

  final TextEditingController firstOtpController = TextEditingController();
  final TextEditingController secondOtpController = TextEditingController();
  final TextEditingController thirdOtpController = TextEditingController();
  final TextEditingController forthOtpController = TextEditingController();
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
    text1.requestFocus();    super.initState();
  }
  void clear() {
    firstOtpController.clear();
    secondOtpController.clear();
    thirdOtpController.clear();
    forthOtpController.clear();
    fifthOtpController.clear();
    sixthOtpController.clear();
  }
  @override
  void dispose() {

    firstOtpController.dispose();
    secondOtpController.dispose();
    thirdOtpController.dispose();
    forthOtpController.dispose();
    fifthOtpController.dispose();
    sixthOtpController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.strokeColor2,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:12.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top + 12,
              ),
              Text(
                'OTP Verification',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Text(
                'Enter the code from sms we sent',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(.5)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  OtpContainer(
                      controller: firstOtpController,
                      focusNode: text1),
                  OtpContainer(
                      controller: secondOtpController,
                      focusNode: text2),
                  OtpContainer(
                      controller: thirdOtpController,
                      focusNode: text3),
                  OtpContainer(
                      controller: forthOtpController,
                      focusNode: text4),
                  OtpContainer(
                      controller: fifthOtpController,
                      focusNode: text5),
                  OtpContainer(
                      controller: sixthOtpController,
                      focusNode: text6),
                ],
              ), SizedBox(height: 20,),              Container(
                child:
                // controller.progress?CircularProgressIndicator(color: AppColors.titleName):
                CustomButton(
                  text: "Login",
                  onTap: () async {

                  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
