import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/api/api_client.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';

class HomeController extends GetxController {

   late Future getCatList;
   late Future getOfferList;
 //
 // late  UserInfoModel userInfo ;

  @override
  void onInit() {
    getCatList = RepositoryData().getCategoryList(token: FirebaseAPIs.user['token'].toString());
    getOfferList = RepositoryData().getOfferList(token: FirebaseAPIs.user['token'].toString());
    print("Home Controller Callled");
    // TODO: implement onInit
    super.onInit();
  }
}
