import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upai/binding/create_offer_binding.dart';
import 'package:upai/binding/initial_binding.dart';
import 'package:upai/binding/profile_binding.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/firebase_options.dart';
import 'package:upai/presentation/Profile/profile_screen.dart';
import 'package:upai/presentation/Service-details/service_details.dart';

import 'package:upai/presentation/chat/chat_screen.dart';
import 'package:upai/presentation/deafult_screen.dart';
import 'package:upai/presentation/splash/splash_screen.dart';
import 'package:upai/review/review_screen.dart';
import 'data/api/notification_access_token.dart';
import 'presentation/Inbox/inbox.dart';
import 'presentation/auth/login_screen.dart';
import 'presentation/auth/otp_screen.dart';
import 'presentation/create-offer/create_offer_screen.dart';
import 'presentation/home/category_list_screen.dart';
import 'presentation/home/home_screen.dart';
import 'presentation/service-list/service_list_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  await Hive.initFlutter();
  await Hive.openBox("userInfo");
  await Hive.openBox("dmPath");
  await Hive.openBox('offer');
  // DependencyInjection.init();
  runApp(const MyApp());
}

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
    notificationAccessToken.firebaseInit();
    notificationAccessToken.setupInteractMessage();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'width, height${MediaQuery.of(context).size.width},${MediaQuery.of(context).size.height}');
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Upai',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              foregroundColor: AppColors.colorWhite,
              backgroundColor: AppColors.kprimaryColor,
              centerTitle: true),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: AppColors.kprimaryColor),
          primaryColor: Colors.white,
          useMaterial3: true,
        ),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const SplashScreen()),
          GetPage(name: '/inbox', page: () => InboxScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
          GetPage(name: '/chatscreen', page: () => ChatScreen()),
          GetPage(name: '/defaultscreen', page: () => DefaultScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(
              name: '/profile',
              page: () => ProfileScreen(),
              binding: ProfileBinding()),
          GetPage(
              name: ServiceListScreen.routeName,
              page: () => ServiceListScreen()),
          GetPage(name: ServiceDetails.routeName, page: () => ServiceDetails()),
          GetPage(
              name: CategoryListScreen.routeName,
              page: () => const CategoryListScreen()),
          GetPage(name: OtpScreen.routeName, page: () => const OtpScreen()),
          GetPage(
              name: CreateOfferScreen.routeName,
              page: () => const CreateOfferScreen(),
              binding: CreateOfferBinding()),
        ],
        initialBinding: RootBinding());
  }
}
