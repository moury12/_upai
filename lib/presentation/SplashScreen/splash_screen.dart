import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/image_path.dart';
import 'controller/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return  Scaffold(
      backgroundColor: const Color(0xffE4E4E4),
      body: Center(
        child: SizedBox(
          height: 150,
            width: 150,
            child: Image(image: AssetImage(ImageConstant.upailogo,),fit: BoxFit.cover,))
      ),
    );
  }
}
