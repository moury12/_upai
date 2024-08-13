import 'package:get/get.dart';
import 'package:upai/Boxes/boxes.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';

class SellerProfileController extends GetxController{
  static SellerProfileController get to =>Get.find();
  Rx<SellerProfileModel> seller = SellerProfileModel().obs;
  late UserInfoModel userData;
  @override
  void onInit() {
    userData = userInfoModelFromJson(Boxes.getUserData().get('user'));
    getSellerProfile();
    // TODO: implement onInit
    super.onInit();
  }
   void getSellerProfile()async{
     seller.value =await RepositoryData.getSellerProfile(FirebaseAPIs.user['token'].toString(),userData.userId??'' );
   }
}