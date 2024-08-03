import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/api/api_client.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
    RxList<CategoryList> getCatList=<CategoryList>[].obs;
  RxInt quantity = 0.obs;
  Rx<TextEditingController> quantityController = TextEditingController(text: '0').obs;
  Rx<CategoryList?> selectedCategory = Rx<CategoryList?>(null);
  Rx<String?> selectedTimeUnit = Rx<String?>(null);
  late Future getOfferList;
  final box = Hive.box('userInfo');

  LoginController controller = Get.put(LoginController());
 // late  UserInfoModel userInfo ;

  @override
  void onInit() {
    getCategoryList();
    getOfferList = RepositoryData().getOfferList(token: FirebaseAPIs.user['token'].toString());
    quantityController.value.text = quantity.value.toString();
    ever(quantity, (value) {
      quantityController.value.text = value.toString();

    });
    print("Home Controller Callled");
    // TODO: implement onInit
    super.onInit();
  }
 void getCategoryList() async{
    getCatList.value = await RepositoryData().getCategoryList(token: FirebaseAPIs.user['token'].toString());

  }

void createOffer(String jobTitle,String description,String rate,) async{
    debugPrint(box.values.map((e) => e['user_id'],).toString());
    await RepositoryData.createOffer(body:
    {

      "cid": box.values.map((e) => e['cid'],).join("").toString(),

      "user_mobile":box.values.map((e) => e['user_id'],).join("").toString(),
      "service_category_type":selectedCategory.value!.categoryName,
      "job_title":"helllo car",
      "description":"description",
      "quantity":quantity.value.toString(),
      "rate_type":selectedTimeUnit.value,
      "rate":"1000",
      "date_time":DateTime.now().toString()
    }

    );
}
  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

}
