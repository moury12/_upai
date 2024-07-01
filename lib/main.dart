
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/presentation/Inbox/chat_screen.dart';
import 'package:upai/presentation/Profile/profile_screen.dart';
import 'package:upai/presentation/ServiceDetails/service_details.dart';
import 'package:upai/presentation/first_screen.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/deafult_screen.dart';

import 'presentation/Inbox/controller/chat_screen_controller.dart';
import 'presentation/Inbox/inbox.dart';

void main() {
  Get.put(ChatScreenController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Upai',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white,centerTitle: true),
       bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white),
       primaryColor: Colors.white,

       // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const FirstScreen()),
        GetPage(name: '/inbox', page: () => const InboxScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/home2', page: () => const InboxScreen()),
        GetPage(name: '/servicedetails', page: () => ServiceDetails()),
        GetPage(name: '/chatscreen', page: () =>  ChatScreen()),
        GetPage(name: '/defaultscreen', page: () =>  DefaultScreen()),
      ],
      // initialBinding: BindingsBuilder(() {
      //   Get.lazyPut(() => LoginController());
      // }),
      // home:  FirstScreen(),
    );
  }
}
