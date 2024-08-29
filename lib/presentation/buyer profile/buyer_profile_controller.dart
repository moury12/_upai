import 'package:get/get.dart';
import 'package:upai/Model/buyer_profile_model.dart';

import '../../data/repository/repository_details.dart';
import '../Profile/profile_screen_controller.dart';

class BuyerProfileController extends GetxController {
  static BuyerProfileController get to => Get.find();
  Rx<BuyerProfileModel> buyer = BuyerProfileModel().obs;
  // RxList<MyService> myService = <MyService>[].obs;
  // Rx<MyService> service = MyService().obs;
  // RxList<MyService> filterList = <MyService>[].obs;
  ProfileScreenController? ctrl;

  // Rx<TextEditingController> searchMyServiceController =
  //     TextEditingController().obs;
  @override
  void onInit() {
    // debugPrint('user info ${Boxes.getUserData().get('user')}');
    refreshAllData();
    // searchMyServiceController.value.addListener(
    //       () {
    //     filterMyService(searchMyServiceController.value.text);
    //   },
    // );
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> refreshAllData() async {
    ctrl = Get.put(ProfileScreenController());

    getBuyerProfile();
  }


  // void deleteOffer(String offerId) async {
  //   await RepositoryData.deleteOffer(
  //       token: ctrl!.userInfo.value.token.toString(),
  //       body: {"user_id": ctrl!.userInfo.value.userId, "offer_id": offerId});
  //   // seller.value.myService!.removeWhere((service) => service.offerId == offerId);
  //   myService.refresh();
  //   await getSellerProfile();
  // }


  Future<void> getBuyerProfile() async {
    buyer.value = await RepositoryData.getBuyerProfile(
        ctrl!.userInfo.value.token.toString(), ctrl!.userInfo.value.userId ?? '');
    // myService.value = seller.value.myService!;
    // filterList.assignAll(myService);
    // debugPrint('myService.toJson()');
    // debugPrint(myService.toString());
  }

  // void filterMyService(String query) {
  //   if (query.isEmpty) {
  //     filterList.assignAll(myService);
  //   } else {
  //     filterList.assignAll(myService.where(
  //           (e) => e.jobTitle!.toLowerCase().contains(query.toLowerCase()),
  //     ));
  //   }
  // }
}