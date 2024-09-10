import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';

class HomeController extends GetxController {

  //for create edit offer
  //

  //image segment
  RxDouble uploadProgress = 0.0.obs;
  RxBool isUploading = false.obs;
  RxBool isLoading=false.obs;
  RxBool isUnRead=false.obs;

  Rx<File?> image = Rx<File?>(null);
  final _picker = ImagePicker();
  String img = '';

  //
  RxBool isSearching = false.obs;

  static HomeController get to => Get.find();
  RxList<CategoryList> getCatList = <CategoryList>[].obs;
  RxList<dynamic> districtList = [].obs;
  RxList<dynamic> filterDistrictList = [].obs;
  RxList<OfferList> getOfferList = <OfferList>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> searchOfferController = TextEditingController().obs;
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
  Rx<String?> selectedDistrictForAll = Rx<String?>(null);
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
    refreshAllData();
    districtList.value =
    await loadJsonFromAssets('assets/district/district.json');
    districtList.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
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
    if (value == "All") {
      filterDistrictList.assignAll(districtList);
      filterDistrictList.refresh();
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
        .getCategoryList(token: FirebaseAPIs.user['token'].toString(),userId:ProfileScreenController.to.userInfo.value.userId.toString());
    filteredCategoryList.value = getCatList;
  }

  void getOfferDataList() async {
    getOfferList.value = await RepositoryData().getOfferList(
        token: FirebaseAPIs.user['token'].toString(),
        mobile: ctrl!.userInfo.value.userId ?? '');
    filteredOfferList.value = getOfferList;
  }
  Future<void> createOffer(String jobTitle,
      String description,
      String rate,
      String address,) async {
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
    await SellerProfileController.to.refreshAllData();
    await HomeController.to.refreshAllData();
  }

  Future<void> editOffer(String offerId, title, description, rate,
      address) async {
    await RepositoryData.editOffer(
        token: ProfileScreenController.to.userInfo.value.token ?? '',
        body: {
          "user_id": ProfileScreenController.to.userInfo.value.userId,
          "offer_id": offerId,
          "service_category_type": selectedCategory.value!.categoryName,
          "job_title": title,
          "description": description,
          "quantity": quantity.value.toString(),
          "rate_type": selectedRateType.value,
          "rate": rate,
          "district": selectedDistrict.value,
          "address": address

        });
    // Get.snackbar('Success', "Update Done");

    SellerProfileController.to.service.value = MyService(
        userName: ProfileScreenController.to.userInfo.value.name,
        userId: ProfileScreenController.to.userInfo.value.userId,
        serviceCategoryType: selectedCategory.value!.categoryName,
        rateType: selectedRateType.value,
        address: address,
        description: description,
        district: selectedDistrict.value,
        jobTitle: title,
        offerId: offerId,
        dateTime: SellerProfileController.to.service.value.dateTime,
        quantity: quantity.value,
        rate: int.parse(rate));
    // getOfferDataList();
    await SellerProfileController.to.refreshAllData();

    // Get.back();
    // SellerProfileController.to.myService.refresh();
    // SellerProfileController.to.service.value =
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

  void filterOffer(String query, String? district) async {
    if (query.isNotEmpty || district != null) {
      if (district == "All Districts"||district ==null) {
        filteredOfferList.value = getOfferList.where(
              (element) {
            final isQueryMatching =
            element.jobTitle!.toLowerCase().contains(query.toLowerCase());

            return isQueryMatching;
          },
        ).toList();

        // filteredOfferList.value=getOfferList.toList();
      } else {
        debugPrint('------------${selectedDistrictForAll.value}');
        debugPrint('------------${searchOfferController.value.text}');
        filteredOfferList.value = getOfferList.where(
              (element) {
            final isDistrictMatching = element.district !=
                null /*&&selectedDistrictForAll.value!="All Districts"*/ &&
                element.district!.contains(district);

            final isQueryMatching =
            element.jobTitle!.toLowerCase().contains(query.toLowerCase());

            return isQueryMatching && isDistrictMatching;
          },
        ).toList();
      }
    } else {
      debugPrint('----++--${selectedDistrictForAll.value}');
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


  //for create offer image
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      print('image got');
      // ctrl.update();
      // ctrl.canEdit!.value = true;
      // debugPrint('///////////////');
      // debugPrint(ctrl.canEdit!.value.toString());
      // setState(() {});
    } else {
      // ctrl.canEdit.value = false;
      // setState(() {
      //
      // });
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //       "No Image Selected!",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     backgroundColor: Colors.deepOrange,
      //   ));
      // }
    }
  }

  void showPickerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Future uploadFile() async {
  //   if (image == null) return;
  //   final fileName = 'profile';
  //  // final destination = '${ctrl.userInfo.value.userId}/$fileName';
  //
  //   try {
  //     final ref = FirebaseStorage.instance.ref(destination).child('file/');
  //     // Uint8List imageData = await File(image!.path).readAsBytes();
  //
  //     await ref.putFile(image!);
  //     ctrl.fetchProfileImage();
  //   } catch (e) {
  //     ctrl.canEdit.value = false;
  //     print('error occured');
  //   }
  // }
  //


//upload image in firebase
  Future<void> uploadImage(String offerId) async {

      isUploading.value = true;


    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('OfferImages')
          .child(offerId)
          .child('image.jpg');

      final uploadTask = storageRef.putFile(
        image.value!,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      uploadTask.snapshotEvents.listen((event) {
        uploadProgress.value =
            event.bytesTransferred / event.totalBytes;
      });

      final snapshot = await uploadTask.whenComplete(() {});

      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Save the download URL to Firestore
      await FirebaseFirestore.instance
          .collection('OfferImage')
          .doc(offerId)
          .set({'imageUrl': downloadUrl});
      isUploading.value = false;

      image.value=null;
      print("image upload  called");


      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("Image uploaded successfully!"),
      //   backgroundColor: Colors.green,
      // ));
    } catch (e) {
      isUploading.value = false;
      print("image upload catch called");
      image.value=null;


      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("Failed to upload image: $e"),
      //   backgroundColor: Colors.red,
      // ));
    }
//

  }
  // Future<File?> compressImage(File file) async {
  //   // Get the directory to store the compressed image
  //   final directory = await getTemporaryDirectory();
  //   final targetPath = path.join(directory.path, "compressed_${path.basename(file.path)}");
  //
  //   // Compress the image
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path, // Original file path
  //     targetPath,         // Destination path
  //     quality: 50,        // Adjust quality (0-100), lower quality means more compression
  //   );
  //
  //   return result;
  // }


}
