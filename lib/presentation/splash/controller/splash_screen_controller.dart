
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/presentation/auth/login_screen.dart';
import 'package:upai/presentation/deafult_screen.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get to =>Get.find();
  final int _splashDuration = 2;
  final box = Hive.box("userInfo");
   Rx<bool> isLogin = false.obs;
  @override
  void onInit() {
    print(isLogin.value);
    _isLogin();
    super.onInit();
  }

  Future _isLogin() async {


    if(box.isNotEmpty)
      {
        isLogin.value = true;
      }
    //initailiy isLogin will be false!
    //check login credential from local Db!
    //if get credential data then isloging value will be true
    await Future.delayed(
      Duration(seconds: _splashDuration),
      () => isLogin.value
          ? Get.offAll(  DefaultScreen())
          : Get.offAll( LoginScreen()),
    );
  }
}
