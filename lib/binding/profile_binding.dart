import 'package:get/get.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {

    Get.put(ProfileScreenController());
  }

}