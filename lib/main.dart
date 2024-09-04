import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upai/binding/initial_binding.dart';
import 'package:upai/binding/profile_binding.dart';
import 'package:upai/core/utils/app_colors.dart';
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
import 'data/api/notification_access_token.dart';
import 'presentation/Inbox/inbox.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationAccessToken().showNotification(message);
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Ensure Firebase is initialized if you plan to use it here
//   await Firebase.initializeApp();
//
//   // Handle the background message here
//   print('Handling a background message: ${message.messageId}');
//   // You can also show a notification or perform other tasks here.
// }

// String boxName="userInfo";
// String boxName="userInfo";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // WidgetsFlutterBinding.ensureInitialized();
  //createNotificationChannel();
  // Register the background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  await Hive.initFlutter();
  await Hive.openBox("userInfo");
  await Hive.openBox("dmPath");

  // DependencyInjection.init();
  runApp(const MyApp());
}
// void createNotificationChannel() async {
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'default_channel_id', // This matches the ID in AndroidManifest.xml
//     'Default Notifications', // The name of the channel (visible to the user)
//     description: 'This channel is used for default notifications.',
//     importance: Importance.high, // The importance level of the channel
//   );
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationAccessToken notificationAccessToken = NotificationAccessToken();

  @override
  void initState() {
    notificationAccessToken.requestNotificationPermission();
    notificationAccessToken.firebaseInit(context);
    notificationAccessToken.setupInteractMessage(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('width, height${MediaQuery.of(context).size.width},${MediaQuery.of(context).size.height}');
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Upai',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(foregroundColor: AppColors.colorWhite, backgroundColor: AppColors.kprimaryColor, centerTitle: true),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColors.kprimaryColor),
          primaryColor: Colors.white,

          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const SplashScreen()),
          GetPage(name: '/inbox', page: () =>  InboxScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
          // GetPage(name: '/home2', page: () => const InboxScreen()),
/*
        GetPage(name: ServiceDetails.routeName, page: () =>  ServiceDetails()),
*/
          GetPage(name: '/chatscreen', page: () => ChatScreen()),
          GetPage(name: '/defaultscreen', page: () => DefaultScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/profile', page: () => ProfileScreen(), binding: ProfileBinding()),
          // GetPage(name: ReviewScreen.routeName, page: () =>  const ReviewScreen()),
          GetPage(name: ServiceListScreen.routeName, page: () => ServiceListScreen()),
          GetPage(name: CategoryListScreen.routeName, page: () => const CategoryListScreen()),
          GetPage(name: OtpScreen.routeName, page: () => const OtpScreen()),
        ],
        initialBinding: RootBinding());
  }
}
