import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Boxes/boxes.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/controllers/filter_controller.dart';
import 'package:upai/controllers/image_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';

double getResponsiveFontSize(BuildContext context, double baseFontSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  // Adjust the multiplier as needed for your design
  return baseFontSize *
      (screenWidth / 423); // 375 is the base width (e.g., iPhone 11)
}
void changeLanguage(String languageCode) {
var locale = Locale(languageCode);
Get.updateLocale(locale);
}

Future<dynamic> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

void retrieveFavOffers() async {
  var box = await Hive.openBox('offer');

  // List<Map<String, dynamic>> storedOffers =jsonDecode(box.values.toString());
  List<Map<String, dynamic>> storedOffers = box.values
      .map((offer) => jsonDecode(offer))
      .cast<Map<String, dynamic>>()
      .toList();
  HomeController.to.favOfferList.value =
      storedOffers.map((json) => OfferList.fromJson(json)).toList();

  debugPrint(box.keys.toString());
}

void saveOfferToHive(OfferList offer) async {
  var box = await Hive.openBox('offer');
  Map<String, dynamic> offerJson = offer.toJson();
  await box.put(offer.offerId, jsonEncode(offerJson));
  debugPrint(box.values.toList().toString());
}

Future<bool> isFavourite(String offerId) async {
  return Boxes.getFavBox().containsKey(offerId);
}

void deleteFavOffers(String offerIndex) async {
  Boxes.getFavBox().delete(offerIndex);
}

OfferList? getOfferByID(String id, List<OfferList> offers) {
  try {
    return offers.firstWhere(
      (element) => element.offerId == id,
    );
  } catch (e) {
    debugPrint('Offer not found $e');
    return null;
  }
}

Future<void> fetchImages(/*  String offerId,*/ String category,
    ImageController imageController) async {
  /* imageController.offerImageUrl.value =
  await ImageController.fetchOfferImageUrl(offerId);*/

  // imageController.defaultOfferImageUrl.value =
  // await ImageController.fetchDefaultOfferImageUrl(category);
}

enum SnackBarType { success, failed, alert }

void showCustomSnackbar({
  required String title,
  required String message,
  required SnackBarType type,
  SnackPosition position = SnackPosition.BOTTOM, // Default position
}) {
  Color backgroundColor = AppColors.kPrimaryColor;
  IconData icon = Icons
      .sentiment_dissatisfied_outlined; // Default color is red for failure/error
  Color textColor = Colors.white;
  switch (type) {
    case SnackBarType.success:
      backgroundColor = AppColors.kPrimaryColor;
      icon = Icons.emoji_emotions_outlined;
      break;
    case SnackBarType.failed:
      backgroundColor = Colors.redAccent;
      Icons.sentiment_dissatisfied_outlined;
      break;
    // TODO: Handle this case.
    case SnackBarType.alert:
      backgroundColor = Colors.orangeAccent;
     icon= Icons.sentiment_neutral;
      break;
    // TODO: Handle this case.
  }
  Get.snackbar(
    title,
    message,
    backgroundColor: backgroundColor,
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.all(12),
    colorText: textColor,
    dismissDirection: DismissDirection.horizontal,
    icon: Icon(
      icon,
      color: Colors.white,
      size: 30,
    ),
    snackPosition: position,
    duration: Duration(
        seconds: 3), // Duration for how long the snackbar will be displayed
  );
}

Future<void> resetData({bool showSnackbar=true}) async{
  if(!FilterController.to.isFilterValueEmpty.value ||
      HomeController.to.selectedDistrictForAll.value!= null||
      HomeController.to.searchOfferController.value.text.isNotEmpty){
    HomeController.to.searchOfferController.value.clear();
    HomeController.to.selectedDistrictForAll.value = null;
    FilterController.to.selectedSortBy.value = null;
    FilterController.to.selectedServiceType.value = null;
    FilterController.to.selectedCategory.value = null;
    HomeController.to.searchFocus.unfocus();

    FilterController.to.checkIfFilterValueIsEmpty();
  if(showSnackbar) {
    showCustomSnackbar(
        title: 'Success',
        message: "All Filter data reset",
        type: SnackBarType.success);
  }
  }
  HomeController.to.refreshAllData();
}

