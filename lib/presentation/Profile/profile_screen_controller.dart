

import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';

class ProfileScreenController extends GetxController{
static ProfileScreenController get to =>Get.find();
  final box = Hive.box("userInfo");
  late UserInfoModel userInfo;
  RxString profileImageUrl = ''.obs;
  RxBool save = false.obs;
  TextEditingController nameTE = TextEditingController();
  TextEditingController emailTE = TextEditingController();
  TextEditingController phoneTE = TextEditingController();

  @override
  void onInit() {
    userInfo = userInfoModelFromJson((box.get("user")));
    fetchProfileImage();
    // TODO: implement onInit
    super.onInit();
  }

  void fetchProfileImage() async {
    try {
      // Define the path where the image is stored
      final destination = '${userInfo.userId}/profile/file';

      // Get a reference to the file
      final ref = FirebaseStorage.instance.ref(destination);

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();

      // Update the profileImageUrl observable
      profileImageUrl.value = downloadUrl;
    } catch (e) {
      print('Error fetching profile image URL: $e');
    }
  }
}