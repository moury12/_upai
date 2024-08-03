
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upai/domain/services/checkInternet.dart';



import 'package:upai/firebase_options.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/ChatScreen/chat_screen.dart';
import 'package:upai/presentation/Inbox/controller/inbox_screen_controller.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
import 'package:upai/presentation/LoginScreen/login_screen.dart';
import 'package:upai/presentation/Profile/profile_screen.dart';
import 'package:upai/presentation/ServiceDetails/service_details.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/SplashScreen/splash_screen.dart';
import 'package:upai/presentation/deafult_screen.dart';
import 'package:upai/presentation/first_screen.dart';
import 'package:upai/presentation/sign%20up%20screen/sign_up_screen.dart';

import 'presentation/ChatScreen/Controller/chat_screen_controller.dart';
import 'presentation/Inbox/inbox.dart';
 String boxName="userInfo";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(boxName);
  Get.put(LoginController());
  Get.put(ChatScreenController());
  Get.put(InboxScreenController());

  DependencyInjection.init();
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
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/inbox', page: () =>  const InboxScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/home', page: () =>  const HomeScreen()),
        GetPage(name: '/home2', page: () =>  const InboxScreen()),
        GetPage(name: '/servicedetails', page: () =>  ServiceDetails()),
        GetPage(name: '/chatscreen', page: () =>  ChatScreen()),
        GetPage(name: '/defaultscreen', page: () =>  DefaultScreen()),
        GetPage(name: '/login', page: () =>  const LoginScreen()),
      ],
      // initialBinding: BindingsBuilder(() {
      //   Get.lazyPut(() => LoginController());
      // }),
      // home:  FirstScreen(),
    );
  }
}
