
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/presentation/HomeScreen/home_screen.dart';
import 'package:upai/presentation/LoginScreen/login_screen.dart';
import 'package:upai/presentation/deafult_screen.dart';

class SplashScreenController extends GetxController {
  final int _splashDuration = 2;
  final box = Hive.box("userInfo");
  @override
  void onInit() {
    _isLogin();
    super.onInit();
  }

  Future _isLogin() async {
    bool isLoging = false;
    if(box.isNotEmpty)
      {
        isLoging = true;
      }
    //initailiy isLogin will be false!
    //check login credential from local Db!
    //if get credential data then isloging value will be true
    await Future.delayed(
      Duration(seconds: _splashDuration),
      () => isLoging == true
          ? Get.offAll( const LoginScreen())
          : Get.offAll( DefaultScreen()),
    );
  }
}
