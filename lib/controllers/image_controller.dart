import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ImageController extends GetxController{
  static ImageController get to => Get.find();
  Rxn<String?> offerImageUrl =Rxn<String?>();
  Rxn<String?> defaultOfferImageUrl =Rxn<String?>();
  static FirebaseFirestore mDB = FirebaseFirestore.instance;

  static Future<String?> fetchOfferImageUrl(String offerId) async {
    try {
      // Reference to the specific document
      final documentRef = mDB
          .collection('OfferImage')
          .doc(offerId);

      // Get the document snapshot
      final documentSnapshot = await documentRef.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Extract the 'imageUrl' field from the document
        final data = documentSnapshot.data();
        return data?['imageUrl'].toString();
      } else {
        //  print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return null;
    }
  }
  static Future<String?> fetchDefaultOfferImageUrl(String category) async {
    try {
      // Reference to the specific document
      final documentRef = mDB
          .collection('CategoryDefaultOfferImage')
          .doc(category);

      // Get the document snapshot
      final documentSnapshot = await documentRef.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Extract the 'imageUrl' field from the document
        final data = documentSnapshot.data();
        return data?['imageURL'].toString();
      } else {
        //  print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return null;
    }
  }
}