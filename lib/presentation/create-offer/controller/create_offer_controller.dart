import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/global_variable.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';
import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';

class CreateOfferController extends GetxController {
  static CreateOfferController get to => Get.find();
  Rx<TextEditingController> serviceController = TextEditingController().obs;
  RxList<TextEditingController> packagePriceControllers = RxList();
  RxList<TextEditingController> packageDurationControllers = RxList();
  RxList<TextEditingController> packageDescriptionControllers = RxList();
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<File?> image = Rx<File?>(null);
  final _picker = ImagePicker();
  String img = '';
  RxDouble uploadProgress = 0.0.obs;
  RxBool isUploading = false.obs;
  RxBool isLoading = false.obs;
  Rx<String?> selectedDistrict = Rx<String?>(null);
  var selectedCategory = Rx<String?>(null);
  Rx<String?> selectedServiceType = Rx<String?>(null);
  final box = Hive.box('userInfo');
  void initializeControllers() {
    // Assuming 3 packages for example
    int numberOfPackages = 3;
    packagePriceControllers =
        List.generate(numberOfPackages, (_) => TextEditingController()).obs;
    packageDurationControllers =
        List.generate(numberOfPackages, (_) => TextEditingController()).obs;
    packageDescriptionControllers =
        List.generate(numberOfPackages, (_) => TextEditingController()).obs;
  }

  void updatePackageList() {
    for (int i = 0; i < packageList.length; i++) {
      packageList[i]['package_description'] =
          packageDescriptionControllers[i].text;
      packageList[i]['price'] = packagePriceControllers[i].text;
      packageList[i]['duration'] = packageDurationControllers[i].text;
    }
  }

  RxList<dynamic> packageList = <dynamic>[].obs;
  RxList<dynamic> yourServiceList = [].obs;
  void editOfferData(MyService? service) {
    addressController.value = TextEditingController(
        text: service != null && service!.address!.isNotEmpty
            ? service!.address
            : addressController.value.text);
    initializeControllers();
    titleController.value = TextEditingController(
        text: service != null ? service!.jobTitle : titleController.value.text);

    for (var i = 0; i < packagePriceControllers.length; i++) {
      if (service != null /*||service!.package!=null*/) {
        if (i < service!.package!.length) {
          packagePriceControllers[i].text =
              service!.package![i].price.toString();
          packageList[i]['price'] = service!.package![i].price.toString();
        } else {
          packagePriceControllers[i].text = packagePriceControllers[i].text;
        }
      }
    }
    for (var i = 0; i < packageDurationControllers.length; i++) {
      // Ensure we don't exceed the number of packages

      if (service != null /*||service!.package!=null*/) {
        if (i < service!.package!.length) {
          packageDurationControllers[i].text =
              service!.package![i].duration.toString();
        } else {
          packageDurationControllers[i].text =
              packageDurationControllers[i].text;
        }
      }
    }
    for (var i = 0; i < packageDescriptionControllers.length; i++) {
      // Ensure we don't exceed the number of packages

      if (service != null /*||service!.package!=null*/) {
        if (i < service!.package!.length) {
          packageDescriptionControllers[i].text =
              service!.package![i].packageDescription.toString();
        } else {
          packageDescriptionControllers[i].text =
              packageDescriptionControllers[i].text;
        }
      }
    }

    descriptionController.value = TextEditingController(
        text: service != null
            ? service!.description
            : descriptionController.value.text);
    if (service != null) {
      var matchedServiceType = serviceType
          .where(
            (element) => element == service!.serviceType,
          )
          .toList();
      if (matchedServiceType.isNotEmpty) {
        selectedServiceType.value = matchedServiceType[0];
      } else {
        selectedServiceType.value = null;
      }
    } else {
      selectedServiceType.value = selectedServiceType.value;
    }
    if (service != null) {
      var filteredList = HomeController.to.getCatList
          .where((e) =>
              e.categoryName!.toLowerCase() ==
              service!.serviceCategoryType!.toLowerCase())
          .toList();
      print('filteredList.first');
      print(filteredList[0].categoryName);

      if (filteredList.isNotEmpty) {
        selectedCategory.value = filteredList.first.categoryName;
      } else {
        selectedCategory.value =
            null; // Or handle the case when no match is found
      }
    } else {
      selectedCategory.value = selectedCategory.value;
     image.value = null;
    }

    selectedDistrict.value = service != null && service!.district!.isNotEmpty
        ? service!.district
        : selectedDistrict.value;
  }

  @override
  void onInit() {
    initializeControllers();
    updatePackageList();
    packageList.assignAll([
      {
        "package_name": "Basic",
        "price": '',
        "duration": '',
        "package_description": '',
        "service_list": List.from(yourServiceList)
      },
      {
        "package_name": "Standard",
        "price": '',
        "duration": '',
        "package_description": '',
        "service_list": List.from(yourServiceList)
      },
      {
        "package_name": "Premium",
        "price": '',
        "duration": '',
        "package_description": '',
        "service_list": List.from(yourServiceList)
      }
    ]);
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    for (var controller in packagePriceControllers) {
      controller.dispose();
    }
    for (var controller in packageDescriptionControllers) {
      controller.dispose();
    }
    for (var controller in packageDurationControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  Future<void> createOffer({
   required String jobTitle,
   required String description,
    String? imgUrl,
   required String address,
  }) async {
    Map<String, dynamic> data = jsonDecode(box.get("user"));
    await RepositoryData.createOffer(
        token: FirebaseAPIs.user['token'].toString(),
        body: {
          "cid": "upai",
          "user_mobile": data['user_id'].toString(),
          "image_url": imgUrl,
          "service_category_type": selectedCategory.value,
          "job_title": jobTitle,
          "description": description,
          "date_time": DateTime.now().toString(),
          "district": selectedDistrict.value,
          "address": address,
          "service_type": selectedServiceType.value,
          "package": packageList
        });
    await SellerProfileController.to.refreshAllData();
    await HomeController.to.refreshAllData();
  }
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
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
  Future<void> editOffer(
      String offerId, title, description, rate, address) async {
    await RepositoryData.editOffer(
        token: ProfileScreenController.to.userInfo.value.token ?? '',
        body: {
          "user_id": ProfileScreenController.to.userInfo.value.userId,
          "offer_id": offerId,
          "service_category_type": selectedCategory.value!,
          "job_title": title,
          "description": description,
          "rate": rate,
          "district": selectedDistrict.value,
          "address": address
        });

    SellerProfileController.to.service.value = MyService(
      userName: ProfileScreenController.to.userInfo.value.name,
      userId: ProfileScreenController.to.userInfo.value.userId,
      serviceCategoryType: selectedCategory.value!,
      // rateType: selectedRateType.value,
      address: address,
      description: description,
      district: selectedDistrict.value,
      jobTitle: title,
      offerId: offerId,
      dateTime: SellerProfileController.to.service.value.dateTime,
    );

    await SellerProfileController.to.refreshAllData();
  }

  /// service Details

  void selectPackage(int index) {
    for (int i = 0; i < packageList.length; i++) {
      if (i == index) {
        packageList[i]['selected'] = true;
      } else {
        packageList[i]['selected'] = false;
      }
    }
    packageList.refresh();
  }
  void showPickerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,

      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading:  Icon(Icons.photo_library,color: AppColors.kprimaryColor,),
                title:  Text('Gallery',style: AppTextStyle.bodyMediumSemiBlackBold,),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading:  Icon(Icons.photo_camera,color: AppColors.kprimaryColor,),
                title: const Text('Camera'),
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
  Future<String?> uploadImage(String offerId) async {
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

      // Listen to upload progress
      uploadTask.snapshotEvents.listen((event) {
        uploadProgress.value = event.bytesTransferred / event.totalBytes;
      });

      // Wait for the upload to complete
      final snapshot = await uploadTask.whenComplete(() {});

      // Get the download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Save the download URL to Firestore
      await FirebaseFirestore.instance
          .collection('OfferImage')
          .doc(offerId)
          .set({'imageUrl': downloadUrl});

      isUploading.value = false;
      image.value = null;

      // Return the download URL
      return downloadUrl;
    } catch (e) {
      isUploading.value = false;
      image.value = null;

      // Handle the error
      print("Failed to upload image: $e");

      // Return null in case of failure
      return null;
    }
  }


}
