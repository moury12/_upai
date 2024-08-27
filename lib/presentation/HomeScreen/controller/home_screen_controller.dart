import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hive/hive.dart';
import 'package:upai/Boxes/boxes.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/ChatScreen/Controller/chat_screen_controller.dart';
import 'package:upai/presentation/Inbox/controller/inbox_screen_controller.dart';
import 'package:upai/presentation/LoginScreen/controller/login_screen_controller.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/notification/controller/notification_controller.dart';

class HomeController extends GetxController {
  RxBool isSearching = false.obs;
  static HomeController get to => Get.find();
  RxList<CategoryList> getCatList = <CategoryList>[].obs;
  RxList<dynamic> districtList = [].obs;
  RxList<dynamic> filterDistrictList = [].obs;
  RxList<OfferList> getOfferList = <OfferList>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> searchCatController = TextEditingController().obs;
  Rx<TextEditingController> rateController = TextEditingController().obs;
  Rx<bool> change = false.obs;
  Rx<bool> changeQuantity = true.obs;
  Rx<bool> changeRate = false.obs;
  RxInt quantity = 1.obs;
  RxInt quantityForConform = 1.obs;
  var totalAmount = 0.obs;
  ProfileScreenController? ctrl;

  Rx<TextEditingController> quantityController =
      TextEditingController(text: '1').obs;
  Rx<TextEditingController> quantityControllerForConfromOrder =
      TextEditingController().obs;
  Rx<CategoryList?> selectedCategory = Rx<CategoryList?>(null);
  Rx<String?> selectedRateType = Rx<String?>(null);
  Rx<String?> selectedDistrict = Rx<String?>(null);
  var filteredOfferList = <OfferList>[].obs;
  var filteredCategoryList = <CategoryList>[].obs;
  final box = Hive.box('userInfo');

  @override
  void onClose() {
    quantityController.value.dispose();
    quantityControllerForConfromOrder.value.dispose();
    rateController.value.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    Get.put(ChatScreenController());
    Get.put(InboxScreenController());
    Get.put(NotificationController());
    refreshAllData();
    districtList.value =
        await loadJsonFromAssets('assets/district/district.json');
    filterDistrictList.assignAll(districtList);
    quantityController.value.text = quantity.value.toString();
    quantityControllerForConfromOrder.value.text =
        quantityForConform.value.toString();
    ever(quantity, (value) {
      quantityController.value.text = value.toString();
    });
    ever(quantityForConform, (value) {
      quantityControllerForConfromOrder.value.text = value.toString();
    });
    quantityControllerForConfromOrder.value.addListener(updateTotalAmount);
    rateController.value.addListener(updateTotalAmount);

    super.onInit();
  }

  Future<void> refreshAllData() async {
    ctrl = Get.put(ProfileScreenController());

    getCategoryList();
    getOfferDataList();
  }

  Future<void> filterDistrict(String value) async {
    if (value.isEmpty) {
      filterDistrictList.assignAll(districtList);
    } else {
      filterDistrictList.assignAll(districtList.where((dis) {
        // debugPrint( dis['name'].toString());
        // debugPrint( value);
        return dis['name']
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase());
      }).toList());
      filterDistrictList.refresh();
    }
  }

  void getCategoryList() async {
    getCatList.value = await RepositoryData()
        .getCategoryList(token: FirebaseAPIs.user['token'].toString());
    filteredCategoryList.value = getCatList;
  }

  void getOfferDataList() async {
    getOfferList.value = await RepositoryData().getOfferList(
        token: FirebaseAPIs.user['token'].toString(),
        mobile: ctrl!.userInfo.userId ?? '',
        name: ctrl!.userInfo.name ?? '');

    filteredOfferList.value = getOfferList;
  }

  void createOffer(
    String jobTitle,
    String description,
    String rate,
    String address,
  ) async {
    //debugPrint(box.values.map((e) => e['user_id'],).toString());
    Map<String, dynamic> data = jsonDecode(box.get("user"));
    await RepositoryData.createOffer(body: {
      "cid": "upai",
      "user_mobile": data['user_id'].toString(),
      "service_category_type": selectedCategory.value!.categoryName,
      "job_title": jobTitle,
      "description": description,
      "quantity": quantity.value.toString(),
      "rate_type": selectedRateType.value,
      "rate": rate,
      "date_time": DateTime.now().toString(),
      "district": selectedDistrict.value,
      "address": address
    });
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void increaseQuantityForConfrom() {
    quantityForConform.value++;
    changeQuantity.value = true;
  }

  void decreaseQuantityForConfrom() {
    if (quantityForConform.value > 1) {
      changeQuantity.value = true;

      quantityForConform.value--;
    }
  }

  void filterOffer(String query) async {
    if (query.isNotEmpty) {
      filteredOfferList.value = getOfferList.where(
        (element) {
          return element.jobTitle!.toLowerCase().contains(query.toLowerCase());
        },
      ).toList();
    } else {
      filteredOfferList.value = getOfferList;
    }
  }

  void filterCategory(String query) async {
    if (query.isNotEmpty) {
      filteredCategoryList.value = getCatList.where(
        (element) {
          return element.categoryName!
              .toLowerCase()
              .contains(query.toLowerCase());
        },
      ).toList();
    } else {
      filteredCategoryList.value = getCatList;
    }
  }

  void updateTotalAmount() {
    int rate = int.parse(
        rateController.value.text.isEmpty ? '0' : rateController.value.text);
    int quantity = int.parse(
        quantityControllerForConfromOrder.value.text.isEmpty
            ? '0'
            : quantityControllerForConfromOrder.value.text);
    totalAmount.value = rate * quantity;
  }
}
