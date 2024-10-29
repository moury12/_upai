
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/controllers/filter_controller.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  Rx<bool>  isNewService = false.obs;
  RxInt currentPage = 1.obs;
  RxInt currentPageForTopService = 1.obs;
  RxInt currentPageForNewService = 1.obs;
  //image segment

  RxBool isUnRead = false.obs;
  RxBool isServiceListLoading= false.obs;

  RxList<CategoryList> getCatList = <CategoryList>[].obs;
  RxList<dynamic> districtList = [].obs;
  RxList<dynamic> filterDistrictList = [].obs;
  RxList<OfferList> getOfferList = <OfferList>[].obs;
  RxList<OfferList> topServiceList = <OfferList>[].obs;
  RxList<OfferList> newServiceList = <OfferList>[].obs;
  RxList<OfferList> favOfferList = <OfferList>[].obs;
  FocusNode searchFocus = FocusNode();
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> searchOfferController = TextEditingController().obs;
  Rx<TextEditingController> searchCatController = TextEditingController().obs;
  Rx<bool> change = false.obs;
  ProfileScreenController? ctrl;
  RxInt? selectedPackageIndex;
  Rx<String?> selectedDistrictForAll = Rx<String?>(null);
  Rx<String?> searchingValue = "".obs;
  var filteredCategoryList = <CategoryList>[].obs;
  final box = Hive.box('userInfo');
  var isLoadingMore = false.obs;

  List<RxBool> isFav = <RxBool>[].obs;

  @override
  void onInit() async {

    await refreshAllData();

    districtList.value =
        await loadJsonFromAssets('assets/district/district.json');
    districtList
        .sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
    filterDistrictList.assignAll(districtList);

    isFav = List.generate(
      getOfferList.length,
      (index) => false.obs,
    );

    super.onInit();
  }

  Future<void> refreshAllData() async {
    ctrl = Get.put(ProfileScreenController());
    // getOfferList.clear();
    // newServiceList.clear();
    currentPage.value=1;
    currentPageForNewService.value=1;
    currentPageForTopService.value=1;
    getCategoryList();
    getOfferDataList();
  }

  Future<void> filterDistrict(String value) async {
    if (value == "All") {
      filterDistrictList.assignAll(districtList);
      filterDistrictList.refresh();
    } else {
      filterDistrictList.assignAll(districtList.where((dis) {
        return dis['name']
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase());
      }).toList());
      filterDistrictList.refresh();
    }
  }

  void getCategoryList() async {
    getCatList.value = await RepositoryData().getCategoryList(
        token: FirebaseAPIs.user['token'].toString(),
        userId: ProfileScreenController.to.userInfo.value.userId.toString());
    filteredCategoryList.value = getCatList;
  }
Future<OfferList?> findServiceByOfferID({ required String offerId})async{
    List<OfferList> offer = await RepositoryData().getOfferList(
      token: FirebaseAPIs.user['token'].toString(),
      mobile: ctrl!.userInfo.value.userId ?? '',
      currentPage: currentPage.value,
      catType: '',
      category: '',
      district: '',
      searchVal: offerId,
      sortBy: '', isLoadMore: false,    );
    OfferList specificOffer=offer.first;
    return specificOffer;
}
  void getOfferDataList({
    bool loadMoreData = false,
  }) async {
   try
   {
     isServiceListLoading.value= true;
      if (loadMoreData) {
        isLoadingMore.value = true;
        isServiceListLoading.value= false;
        currentPage.value++; // Increment page for pagination
        currentPageForNewService.value++;
        currentPageForTopService.value++;
      }

      Get.put(FilterController());

      // Fetch Top Offers
      List<OfferList> topOffer = await RepositoryData().getOfferList(
        token: FirebaseAPIs.user['token'].toString(),
        mobile: ctrl!.userInfo.value.userId ?? '',
        currentPage: currentPageForTopService.value,
        catType: '',
        category: '',
        district: '',
        searchVal: '',
        sortBy: 'RATING',
        isLoadMore: loadMoreData,
      );

      // Fetch New Offers
      List<OfferList> defaultOffer = await RepositoryData().getOfferList(
        isLoadMore: loadMoreData,
        currentPage: currentPage.value,
        token: FirebaseAPIs.user['token'].toString(),
        mobile: ctrl!.userInfo.value.userId ?? '',
        category: FilterController.to.selectedCategory.value ?? '',
        catType: FilterController.to.selectedServiceType.value ?? '',
        searchVal: searchOfferController.value.text,
        district: selectedDistrictForAll.value != 'All Districts'
            ? selectedDistrictForAll.value ?? ''
            : '',
        sortBy: FilterController.to.selectedSortBy.value ?? '',
      );

      // Fetch New Arrival Offers
      List<OfferList> newArrivalOffers = await RepositoryData().getOfferList(
        isLoadMore: loadMoreData,
        currentPage: currentPageForNewService.value,
        token: FirebaseAPIs.user['token'].toString(),
        mobile: ctrl!.userInfo.value.userId ?? '',
        category: FilterController.to.selectedCategory.value ?? '',
        catType: FilterController.to.selectedServiceType.value ?? '',
        searchVal: searchOfferController.value.text,
        district: selectedDistrictForAll.value != 'All Districts'
            ? selectedDistrictForAll.value ?? ''
            : '',
        sortBy: FilterController.to.selectedSortBy.value ?? 'NEWEST ARRIVAL',
      );

      // Top Offers Logic
      if (topOffer.isNotEmpty) {
        if (loadMoreData) {
          topServiceList.addAll(topOffer);
        } else {
          topServiceList.assignAll(topOffer);
        }
        topServiceList.refresh();
        if (loadMoreData) {
          currentPageForTopService.value++;
        }
      }

      // default Offers Logic
      if (defaultOffer.isNotEmpty) {
        if (loadMoreData) {
          getOfferList.addAll(defaultOffer);
        } else {
          getOfferList.assignAll(defaultOffer);
        }

        getOfferList.refresh();
        if (loadMoreData) {
          currentPage.value++;
        }
      } else if (!loadMoreData) {

        getOfferList.clear();
        getOfferList.refresh(); // Ensure the UI updates
      }

      // New Arrival Offers Logic
      if (newArrivalOffers.isNotEmpty) {
        if (loadMoreData) {
          newServiceList.addAll(newArrivalOffers);
        } else {
          newServiceList.assignAll(newArrivalOffers);
        }
        newServiceList.refresh();
        if (loadMoreData) {
          currentPageForNewService.value++;
        }
      } else if (!loadMoreData) {
        // Clear the list if there's no new arrival data
        newServiceList.clear();
        newServiceList.refresh(); // Ensure the UI updates
      }

      isLoadingMore.value = false;
    }
    catch(e){
     debugPrint(e.toString());
    }finally{
     isServiceListLoading.value= false;
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

  //for create offer image




}
