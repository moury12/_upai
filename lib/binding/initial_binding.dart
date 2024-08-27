import 'package:get/get.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/presentation/ChatScreen/Controller/chat_screen_controller.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/Inbox/controller/inbox_screen_controller.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
import 'package:upai/presentation/SplashScreen/controller/splash_screen_controller.dart';

import '../presentation/notification/controller/notification_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => SplashScreenController(),);
    Get.lazyPut(() => NetworkController(),);
    Get.lazyPut(() => LoginController(),);
    // Get.lazyPut(() => InboxScreenController(),);
    Get.put(InboxScreenController());
    Get.put(NotificationController());
    Get.put(ChatScreenController());
    // Get.lazyPut(() => NotificationController(),);
    // Get.lazyPut(() => ChatScreenController(),);
  }
}