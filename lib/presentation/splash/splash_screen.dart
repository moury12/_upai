import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/utils/image_path.dart';
import 'controller/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 200.w, end: 100.w).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }
  @override
  void dispose() {
_controller.dispose();    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return  Scaffold(
      backgroundColor: const Color(0xffE4E4E4),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context,child) {
            return SizedBox(
              height: _animation.value,
                width: _animation.value,
                child: Image(image: AssetImage(ImageConstant.upailogo,),fit: BoxFit.cover,));
          }
        )
      ),
    );
  }
}
