import 'package:get/get.dart';
import 'package:upai/domain/services/checkInternet.dart';
import 'package:upai/presentation/ChatScreen/Controller/chat_screen_controller.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/Inbox/controller/inbox_screen_controller.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
import 'package:upai/presentation/SplashScreen/controller/splash_screen_controller.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NetworkController(),permanent:  true);
    Get.put(SplashScreenController());

    Get.put(LoginController());
    Get.put(ChatScreenController());
    Get.put(InboxScreenController());
    Get.put(InboxScreenController());

  }
}