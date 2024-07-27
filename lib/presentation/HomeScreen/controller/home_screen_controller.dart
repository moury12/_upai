import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/repository/repository_details.dart';

class HomeController extends GetxController {

  late Future getCatList;
  final box = Hive.box("userInfo");

 late  UserInfoModel userInfo ;

  @override
  Future<void> onInit() async {
    // userInfo = userInfoModelFromJson(box.get('user'));
    //Map<String,dynamic> userData = await box.get('user')['token'];

    getCatList = RepositoryData().getCategoryList(token:box.get('user')['token'].toString());

    print("Home Controller Callled");
    // TODO: implement onInit
    super.onInit();
  }
}
