import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:upai/Boxes/boxes.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';

double getResponsiveFontSize(BuildContext context, double baseFontSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  // Adjust the multiplier as needed for your design
  return baseFontSize * (screenWidth / 423); // 375 is the base width (e.g., iPhone 11)
}
Future<dynamic> loadJsonFromAssets(String filePath) async{
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
  HomeController.to.favOfferList.value= storedOffers.map((json) => OfferList.fromJson(json)).toList();

 debugPrint(box.keys.toString());

}
void saveOfferToHive(OfferList offer) async{
  var box = await Hive.openBox('offer');
  Map<String, dynamic> offerJson =offer.toJson();
  await box.put(offer.offerId, jsonEncode(offerJson));
  debugPrint(box.values.toList().toString());
}


 Future<bool> isFavourite(String offerId) async{

return Boxes.getFavBox().containsKey(offerId);
}


void deleteFavOffers(String offerIndex)async{

  Boxes.getFavBox().delete(offerIndex);
}
OfferList? getOfferByID(String id, List<OfferList> offers){
  try{
    return offers.firstWhere((element) => element.offerId==id,);

  }catch(e){
    debugPrint('Offer not found $e');
    return null;
  }
}
// Future<OfferList?> getOfferById(String offerId) async {
//   var box = await Hive.openBox('offerList');
//
//   // Loop through all entries to find the one with the matching offerId
//   for (int i = 0; i < box.length; i++) {
//     Map<String, dynamic> offerJson = box.getAt(i);
//
//     // Convert JSON back to OfferList to access the offerId field
//     OfferList offer = OfferList.fromJson(offerJson);
//
//     // Check if this entry's offerId matches the given offerId
//     if (offer.offerId == offerId) {
//       // Return the found offer
//       return offer;
//     }
//   }}
