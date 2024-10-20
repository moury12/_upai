import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/data/repository/repository_details.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RxInt currentPage =1.obs;
  //image segment
  RxDouble uploadProgress = 0.0.obs;
  RxBool isUploading = false.obs;
  RxBool isLoading=false.obs;
  RxBool isUnRead=false.obs;


  Rx<File?> image = Rx<File?>(null);
  final _picker = ImagePicker();
  String img = '';
  RxBool isSearching = false.obs;
  RxBool searchICon = false.obs;
  RxBool isFilttering = false.obs;
  RxList<CategoryList> getCatList = <CategoryList>[].obs;
  RxList<dynamic> districtList = [].obs;
  RxList<dynamic> filterDistrictList = [].obs;
  RxList<OfferList> getOfferList = <OfferList>[].obs;
  RxList<OfferList> favOfferList = <OfferList>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> searchOfferController = TextEditingController().obs;
  Rx<TextEditingController> searchCatController = TextEditingController().obs;
  Rx<bool> change = false.obs;
  ProfileScreenController? ctrl;
RxInt? selectedPackageIndex;
  Rx<String?> selectedDistrictForAll = Rx<String?>(null);
  Rx<String?> searchingValue = "".obs;
  var filteredOfferList = <OfferList>[].obs;
  var filteredCategoryList = <CategoryList>[].obs;
  final box = Hive.box('userInfo');
var isLoadingMore = false.obs;

  List<RxBool> isFav=<RxBool>[].obs;

  @override
  void onInit() async {

   await refreshAllData();
    districtList.value =
    await loadJsonFromAssets('assets/district/district.json');
    districtList.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
    filterDistrictList.assignAll(districtList);


    isFav =  List.generate(getOfferList.length, (index) => false.obs,);

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
          .getCategoryList(token: FirebaseAPIs.user['token'].toString(),
          userId: ProfileScreenController.to.userInfo.value.userId.toString());
      filteredCategoryList.value = getCatList;
    }

    void getOfferDataList({bool loadMoreData = false}) async {
      if (loadMoreData) {
        isLoadingMore.value = true; // Start loading more data
      }
      List<OfferList> newOffers = await RepositoryData().getOfferList(
          isLoadMore: loadMoreData,
          currentPage: loadMoreData ? currentPage.value : 1,
          token: FirebaseAPIs.user['token'].toString(),
          mobile: ctrl!.userInfo.value.userId ?? '');
      print('Fetched new offers: ${newOffers.map((element) => element,)}');


      if (newOffers.isNotEmpty) {
        if (loadMoreData) {
          getOfferList.addAll(newOffers);
          getOfferList.refresh(); // Append new data
        } else {
          getOfferList.assignAll(newOffers);
          getOfferList.refresh();
        }
        if (loadMoreData) {
          currentPage.value++;
        }
        // Increment page
      }
      filteredOfferList.value = getOfferList;
      isLoadingMore.value = false;
    }





    void filterOffer(String query, String? district) async {
      if (query.isNotEmpty || district != null) {
        if (district == "All Districts" || district == null) {
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
                  element.district!.toLowerCase() == district.toLowerCase();

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

        image.value = null;
        print("image upload  called");


        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text("Image uploaded successfully!"),
        //   backgroundColor: Colors.green,
        // ));
      } catch (e) {
        isUploading.value = false;
        print("image upload catch called");
        image.value = null;


        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text("Failed to upload image: $e"),
        //   backgroundColor: Colors.red,
        // ));
      }
//

    }
  }

