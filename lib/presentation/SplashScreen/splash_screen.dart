import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
