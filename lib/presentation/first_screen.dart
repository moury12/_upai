import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/global_variable.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/deafult_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              userType = "client";
              nextPage();
            }, child: Text("Client")),
            ElevatedButton(onPressed: (){
              userType = "serviceprovider";
              nextPage();
            }, child: Text("Service Provider")),
          ],
        ),
      ),
    );
  }

  void nextPage() {
    Get.toNamed("/defaultscreen");
  }
}
