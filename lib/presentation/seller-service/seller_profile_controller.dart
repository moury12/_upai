import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:upai/Boxes/boxes.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/repository/repository_details.dart';

class SellerProfileController extends GetxController {
  static SellerProfileController get to => Get.find();
  Rx<SellerProfileModel> seller = SellerProfileModel().obs;
  RxList<MyService> myService = <MyService>[].obs;
  RxList<MyService> filterList = <MyService>[].obs;
  late UserInfoModel userData;
  Rx<TextEditingController> searchMyServiceController =
      TextEditingController().obs;
  @override
  void onInit() {
    debugPrint('user info ${Boxes.getUserData().get('user')}');
    refreshAllData();
    searchMyServiceController.value.addListener(() {
      filterMyService(searchMyServiceController.value.text);
    },);
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> refreshAllData() async {
    userData = userInfoModelFromJson(Boxes.getUserData().get('user'));

    getSellerProfile();

  }

  void getSellerProfile() async {
    seller.value = await RepositoryData.getSellerProfile(
        userData.token.toString(), userData.userId ?? '');
    myService.value =  seller.value.myService!;
    filterList.assignAll(myService);
    debugPrint('myService.toJson()');
    debugPrint(myService.toString());
  }

  void filterMyService(String query) {
    if (query.isEmpty) {
      filterList.assignAll(myService);
    } else {
      filterList.assignAll(myService.where(
        (e) => e.jobTitle!.toLowerCase().contains(query.toLowerCase()),
      ));
    }
  }
}
