import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';

class ServiceDetailsController extends GetxController {
  static ServiceDetailsController get to => Get.find();
  RxList<OfferList> categoryWiseOfferList = <OfferList>[].obs;
  var heartIconColor = Colors.white.obs;
  RxInt currentPage = 1.obs;
  RxBool isFav = false.obs;
  RxBool initialState = true.obs;
  RxInt tabIndex = 0.obs;
  ProfileScreenController? ctrl;
  getCategoryWiseOfferList({
    required String category,
    required String mobileNo,
    bool loadMoreData = false,
  }) async {
    try{
      categoryWiseOfferList.value = await RepositoryData().getOfferList(
        token: FirebaseAPIs.user['token'].toString(),
        mobile: mobileNo,
        currentPage: currentPage.value,
        catType: '',
        category: category,
        district: '',
        searchVal: '',
        sortBy: '',
        isLoadMore: false,
      );
    }catch(e){
      initialState.value= false;
    }finally{
      initialState.value= false;

    }
  }
}
