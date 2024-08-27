import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/repository/repository_details.dart';

class ProfileScreenController extends GetxController {
  static ProfileScreenController get to => Get.find();
  final box = Hive.box("userInfo");
  late UserInfoModel userInfo;
  RxString profileImageUrl = ''.obs;
  Rx<String> id = ''.obs;
  RxBool canEdit=false.obs;
  TextEditingController nameTE = TextEditingController();
  TextEditingController emailTE = TextEditingController();
  TextEditingController phoneTE = TextEditingController();

  @override
  void onInit() {
    getUserData();
    debugPrint(userInfo.toJson().toString());
    id.value = userInfo.userId ?? "";
    canEdit.value =false;
    fetchProfileImage();
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
  userInfo = userInfoModelFromJson((box.get("user")));

}
  void fetchProfileImage() async {
    try {
      // Define the path where the image is stored
      final destination = '${id.value}/profile/file';

      // Get a reference to the file
      final ref = FirebaseStorage.instance.ref(destination);

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();

      // Update the profileImageUrl observable
      profileImageUrl.value = downloadUrl;
      canEdit.value = false;
    } catch (e) {
      print('Error fetching profile image URL: $e');
    }
  }
  void updateProfile(String name, email)async{
    RepositoryData.updateProfile(token: userInfo.token??'',body: {
      "user_id":userInfo.userId,
      "name":name,
      "email":email
    });
    UserInfoModel userInfodetails = UserInfoModel();
    userInfodetails.cid = userInfo.userId;
    userInfodetails.name = name;
    userInfodetails.userId = userInfo.userId;
    userInfodetails.email = email;
    userInfodetails.mobile = userInfo.mobile;
    userInfodetails.token =userInfo.token;
    userInfodetails.userType = userInfo.userType;
    await box.put('user', jsonEncode(userInfodetails.toJson()));
    await getUserData();
    print("value is  : ${box.get("user")}");
    print("&&&&&&&&&&&&&&&&&&&");
    print(box.values);
  }
}
