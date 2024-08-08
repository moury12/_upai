import 'package:flutter/material.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';

class NotificatonScreen extends StatefulWidget {
  const NotificatonScreen({super.key});

  @override
  State<NotificatonScreen> createState() => _NotificatonScreenState();
}

class _NotificatonScreenState extends State<NotificatonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset(ImageConstant.notification),
              SizedBox(height: 10,),
              Text("No Notification Yet",style: AppTextStyle.bodyMedium400),
            ],
          ),
        ),
      ),

    );
  }
}
