import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/api/api_client.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
    RxList<CategoryList> getCatList=<CategoryList>[].obs;
  Rx<CategoryList?> selectedCategory = Rx<CategoryList?>(null);
  Rx<String?> selectedTimeUnit = Rx<String?>(null);
  late Future getOfferList;
 //
 // late  UserInfoModel userInfo ;

  @override
  void onInit() {
    getCategoryList();
    getOfferList = RepositoryData().getOfferList(token: FirebaseAPIs.user['token'].toString());
    print("Home Controller Callled");
    // TODO: implement onInit
    super.onInit();
  }
 void getCategoryList() async{
    getCatList.value = await RepositoryData().getCategoryList(token: FirebaseAPIs.user['token'].toString());
    if (getCatList.isNotEmpty) {
      selectedCategory.value = getCatList.first;
    }
  }
  RxInt quantity = 1.obs; // Default quantity set to 1

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}
