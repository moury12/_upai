import 'package:flutter/cupertino.dart';
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
   refreshAllData();
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> refreshAllData()async{
    userData = userInfoModelFromJson(Boxes.getUserData().get('user'));
    getSellerProfile();
  }
   void getSellerProfile()async{

     seller.value =await RepositoryData.getSellerProfile(userData.token.toString(),userData.userId??'' );
   }
}