import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';

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


}
void saveOfferToHive(OfferList offer) async{
  var box = await Hive.openBox('offer');
  Map<String, dynamic> offerJson =offer.toJson();
  await box.put(offer.offerId, jsonEncode(offerJson));
  debugPrint(box.values.toList().toString());
}
// void retrieveFavOffers() async {
//   var box = await Hive.openBox('offer');
//
//   // Safely cast Hive values to Map<String, dynamic> and handle nulls
//   List<OfferList> storedOffers = box.values.map((offer) {
//     if (offer is Map) { // Check if offer is of type Map
//       try {
//         // Safely cast to Map<String, dynamic>
//         return OfferList.fromJson(Map<String, dynamic>.from(offer.cast<String, dynamic>()));
//       } catch (e) {
//         print('Error casting offer data: $e');
//         return null;  // Handle invalid data by returning null
//       }
//     } else {
//       print('Invalid offer data format');
//       return null;  // Handle non-map values by returning null
//     }
//   }).where((element) => element != null).cast<OfferList>().toList(); // Filter out nulls and cast to List<OfferList>
//
//   // Assign the list of OfferList objects to the controller
//   HomeController.to.favOfferList.value = storedOffers;
//
//   // Example usage of the retrieved data
//   HomeController.to.favOfferList.forEach((offer) {
//     print(offer.jobTitle);  // Prints job titles
//   });
// }




void deleteFavOffers(String offerIndex)async{
  var box =await Hive.openBox('offer');
  for(int i=0; i<box.length;i++){
    Map<String,dynamic> offerJson =box.getAt(i);
    OfferList offer = OfferList.fromJson(offerJson);
    if(offer.offerId==offerIndex){
      await box.deleteAt(i);
      debugPrint('Offer with id $offerIndex deleted');
      return;
    }
  }
}
Future<OfferList?> getOfferById(String offerId) async {
  var box = await Hive.openBox('offerList');

  // Loop through all entries to find the one with the matching offerId
  for (int i = 0; i < box.length; i++) {
    Map<String, dynamic> offerJson = box.getAt(i);

    // Convert JSON back to OfferList to access the offerId field
    OfferList offer = OfferList.fromJson(offerJson);

    // Check if this entry's offerId matches the given offerId
    if (offer.offerId == offerId) {
      // Return the found offer
      return offer;
    }
  }}
