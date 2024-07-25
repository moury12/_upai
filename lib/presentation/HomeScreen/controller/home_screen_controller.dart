import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/data/api/api_client.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';

class HomeController extends GetxController {

  late Future getCatList;




  @override
  void onInit() {

    getCatList = RepositoryData().getCategoryList("","","","");

    print("Home Controller Callled");
    // TODO: implement onInit
    super.onInit();
  }
}
