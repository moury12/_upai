import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';

class ProfileScreenController extends GetxController {
  static ProfileScreenController get to => Get.find();
  final box = Hive.box("userInfo");
   Rx<UserInfoModel> userInfo= UserInfoModel().obs;
  RxString profileImageUrl = ''.obs;
  Rx<String> id = ''.obs;
  RxBool canEdit=false.obs;
  TextEditingController nameTE = TextEditingController();
  TextEditingController emailTE = TextEditingController();
  TextEditingController phoneTE = TextEditingController();

  @override
  void onInit() {
    getUserData();
    debugPrint(userInfo.value.toJson().toString());
    id.value = userInfo.value.userId ?? "";
    canEdit.value =false;
     fetchProfileImage();
    // getImage();
    // TODO: implement onInit
    super.onInit();
  }
@override
  void onClose() {
  canEdit.value =false;
    // TODO: implement onClose
    super.onClose();
  }
Future<void> getUserData()async{
  userInfo.value = userInfoModelFromJson((box.get("user")));

}

  void fetchProfileImage() async {
    try {
      // Define the path where the image is stored
      final destination = 'ProfileImages/${id.value}/file';

      // Get a reference to the file
      final ref = FirebaseStorage.instance.ref(destination);

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();
      FirebaseAPIs.updateProfileImageURL(downloadUrl.toString());

      // Update the profileImageUrl observable
      profileImageUrl.value = downloadUrl;
      canEdit.value = false;
    } catch (e) {
      print('Error fetching profile image URL: $e');
    }
  }
  Future<String> getProfileImageURL(String userID) async {
    try {
      // Define the path where the image is stored
      final destination = 'ProfileImages/$userID/file';

      // Get a reference to the file
      final ref = FirebaseStorage.instance.ref(destination);

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl.toString();

      // Update the profileImageUrl observable

      // canEdit.value = false;
    } catch (e) {
      print('Error fetching profile image URL: $e');
      return "";
    }
  }
  void updateProfile(String name, email)async{
    RepositoryData.updateProfile(token: userInfo.value.token??'',body: {
      "user_id":userInfo.value.userId,
      "name":name,
      "email":email
    });
    UserInfoModel userInfodetails = UserInfoModel();
    userInfodetails.cid = userInfo.value.userId;
    userInfodetails.name = name;
    userInfodetails.userId = userInfo.value.userId;
    userInfodetails.email = email;
    userInfodetails.mobile = userInfo.value.mobile;
    userInfodetails.token =userInfo.value.token;
    userInfodetails.userType = userInfo.value.userType;
    await box.put('user', jsonEncode(userInfodetails.toJson()));
    await getUserData();
    print("value is  : ${box.get("user")}");
    print("&&&&&&&&&&&&&&&&&&&");
    print(box.values);
  }

  // void getImage() {
  //   profileImageUrl.value = userInfo.value.image.toString();
  // }
}
