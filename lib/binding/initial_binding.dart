import 'package:get/get.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/presentation/Inbox/controller/inbox_screen_controller.dart';
import 'package:upai/presentation/chat/Controller/chat_screen_controller.dart';
import 'package:upai/presentation/splash/controller/splash_screen_controller.dart';

import '../presentation/Profile/profile_screen_controller.dart';
import '../presentation/auth/controller/login_screen_controller.dart';
import '../presentation/notification/controller/notification_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {

    // Get.lazyPut(() => SplashScreenController(),);
    Get.lazyPut(() => NetworkController(),);
    //Get.lazyPut(() => ProfileScreenController(),);
    // Get.lazyPut(() => LoginController(),);
    // Get.lazyPut(() => InboxScreenController(),);
    Get.put(SplashScreenController());
    Get.put(InboxScreenController());
    Get.put(NotificationController());
    Get.put(ChatScreenController());
    Get.put(LoginController());
    // Get.lazyPut(() => NotificationController(),);
    // Get.lazyPut(() => ChatScreenController(),);
  }
}