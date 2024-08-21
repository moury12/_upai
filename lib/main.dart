
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upai/binding/initial_binding.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/firebase_options.dart';
import 'package:upai/presentation/ChatScreen/chat_screen.dart';
import 'package:upai/presentation/Explore/service_list_screen.dart';
import 'package:upai/presentation/HomeScreen/category_list_screen.dart';
import 'package:upai/presentation/LoginScreen/login_screen.dart';
import 'package:upai/presentation/LoginScreen/otp_screen.dart';
import 'package:upai/presentation/Profile/profile_screen.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/SplashScreen/splash_screen.dart';
import 'package:upai/presentation/deafult_screen.dart';
import 'package:upai/review/review_screen.dart';
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
  DependencyInjection.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('width, height${MediaQuery.of(context).size.width},${MediaQuery.of(context).size.height}');
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
       // GetPage(name: '/home2', page: () =>  const InboxScreen()),
/*
        GetPage(name: ServiceDetails.routeName, page: () =>  ServiceDetails()),
*/
        GetPage(name: '/chatscreen', page: () =>  ChatScreen()),
        GetPage(name: '/defaultscreen', page: () =>  DefaultScreen()),
        GetPage(name: '/login', page: () =>  const LoginScreen()),
        GetPage(name: '/profile', page: () =>  const ProfileScreen()),
        GetPage(name: ReviewScreen.routeName, page: () =>  const ReviewScreen()),
        GetPage(name: ServiceListScreen.routeName, page: () =>  ServiceListScreen()),
        GetPage(name: CategoryListScreen.routeName, page: () =>  const CategoryListScreen()),
        GetPage(name: OtpScreen.routeName, page: () =>  const OtpScreen()),
      ],
     initialBinding: RootBinding()

    );
  }
}
