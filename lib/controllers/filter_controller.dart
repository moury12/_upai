import 'package:get/get.dart';

class FilterController extends GetxController{
  static FilterController get to => Get.find();
  Rx<String?> selectedServiceType=Rx<String?>(null);
  Rx<String?> selectedCategory=Rx<String?>(null);
  Rx<String?> selectedSortBy=Rx<String?>(null);
  Rx<bool> isFilterValueEmpty = true.obs;
  @override
  void onInit() {
    checkIfFilterValueIsEmpty();

    super.onInit();
  }
  void checkIfFilterValueIsEmpty() {
    isFilterValueEmpty.value = selectedServiceType.value == null &&
        selectedSortBy.value == null &&
        selectedCategory.value == null;
  }
}