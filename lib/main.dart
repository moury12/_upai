import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'data/api/notification_access_token.dart';
import 'presentation/Inbox/inbox.dart';
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
  Map<String, Map<String, String>> translations = await loadTranslations();
  // DependencyInjection.init();
  runApp(MyApp(translations: translations));
}

Future<Map<String, Map<String, String>>> loadTranslations() async {
  Map<String, Map<String, String>> translations = {};

  // Load and decode each JSON file
  String enJson = await rootBundle.loadString('assets/language/en.json');
  translations['en'] = Map<String, String>.from(jsonDecode(enJson));

  String bnJson = await rootBundle.loadString('assets/language/bn.json');
  translations['bn'] = Map<String, String>.from(jsonDecode(bnJson));

  return translations;
}


class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> translations;
  const MyApp({super.key, required this.translations});

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
debugPrint(MediaQuery.of(context).size.height.toString());
debugPrint(MediaQuery.of(context).size.width.toString());
    return ScreenUtilInit(
      designSize: const Size(423,945),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        translationsKeys: widget.translations,
          locale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          debugShowCheckedModeBanner: false,
          title: 'Upai',
          // theme: ThemeData().appBarTheme(),
          theme:ThemeDataClass().themeData ,
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => const SplashScreen()),
            GetPage(name: '/inbox', page: () => const InboxScreen()),
            GetPage(name: '/home', page: () => const HomeScreen()),
            GetPage(name: '/chatscreen', page: () => ChatScreen()),
            GetPage(name: '/defaultscreen', page: () => DefaultScreen()),

            GetPage(
                name: '/profile',
                page: () => const ProfileScreen(),
                binding: ProfileBinding()),
            GetPage(
                name: ServiceListScreen.routeName,
                page: () => const ServiceListScreen()),
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
          initialBinding: RootBinding()),
    );
  }
}
class ThemeDataClass{
  ThemeData themeData=ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(

    ),
    appBarTheme: AppBarTheme(
        backgroundColor  : AppColors.colorWhite,
        foregroundColor: AppColors.kprimaryColor,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
color: AppColors.kprimaryColor ,

          fontWeight: FontWeight.w600,
        ),
        // iconTheme: IconThemeData(size: 15.sp,color:  AppColors.kprimaryColor),
        centerTitle: true),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    ),
    primaryColor: AppColors.kprimaryColor,
    useMaterial3: true,
    splashColor:AppColors.kprimaryColor.withOpacity(.2),
    shadowColor: AppColors.kprimaryColor.withOpacity(.2),

  );
}