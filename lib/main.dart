
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/deafult_screen.dart';

import 'presentation/LoginScreen/controller/login_screen_controller.dart';
import 'presentation/SplashScreen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dynamic Architechture!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
      home:  DeafultScreen(),
    );
  }
}
