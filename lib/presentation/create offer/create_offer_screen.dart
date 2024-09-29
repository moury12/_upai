import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/HomeScreen/widgets/search_able_dropdown.dart';
import 'package:upai/widgets/custom_text_field.dart';

import 'widget/tab_content_view.dart';

class CreateOfferScreen extends StatefulWidget {
  final MyService? service;
  final bool? isEdit;

  const CreateOfferScreen({super.key, this.service, this.isEdit = false});

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  final box = Hive.box('userInfo');

  late TextEditingController titleController;
  late TextEditingController addressController;
  late TextEditingController descriptionController;

  late TextEditingController rateController;

  List<String> timeUnits = ['Hour', 'Task', 'Per Day', 'Piece'];
  List<String> serviceType = ['Local', 'Online'];
  Map data = {};

  @override
  void initState() {
    // print(district.toString());

    addressController = TextEditingController(
        text: widget.service != null && widget.service!.address!.isNotEmpty
            ? widget.service!.address
            : '');
    titleController = TextEditingController(
        text: widget.service != null ? widget.service!.jobTitle : '');
    addressController = TextEditingController(
        text: widget.service != null ? widget.service!.address : '');
    descriptionController = TextEditingController(
        text: widget.service != null ? widget.service!.description : '');
    rateController = TextEditingController(
        text: widget.service != null ? widget.service!.rate.toString() : '');
    HomeController.to.quantityController.value.text =
        widget.service != null ? widget.service!.quantity.toString() : '';
    HomeController.to.quantity.value =
        widget.service != null ? widget.service!.quantity!.toInt() : 1;
    // HomeController.to.selectedCategory.value = widget.service != null
    //     ? HomeController.to.getCatList
    //         .where((e) =>
    //             e.categoryName!.toLowerCase().contains(widget.service!.serviceCategoryType!.toLowerCase())
    //             )
    //         .toList()[0]
    //     : null;
    if (widget.service != null) {
      var filteredList = HomeController.to.getCatList
          .where((e) => e.categoryName!
              .toLowerCase()
              .contains(widget.service!.serviceCategoryType!.toLowerCase()))
          .toList();

      if (filteredList.isNotEmpty) {
        HomeController.to.selectedCategory.value = filteredList[0];
      } else {
        HomeController.to.selectedCategory.value =
            null; // Or handle the case when no match is found
      }
    } else {
      HomeController.to.selectedCategory.value = null;
      HomeController.to.image.value = null;
    }
    // debugPrint(widget.service!.rateType);
    HomeController.to.selectedRateType.value = widget.service != null &&
            timeUnits.any((item) => item.contains(widget.service!.rateType!))
        ? widget.service!.rateType.toString()
        : null;
    HomeController.to.selectedDistrict.value =
        widget.service != null && widget.service!.district!.isNotEmpty
            ? widget.service!.district
            : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeController.to.isLoading.value = false;
    HomeController.to.isUploading.value = false;
    double screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      onPopInvoked: (didPop) {
        HomeController.to.image.value = null;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.kprimaryColor,
            ),
          ),
          title: Text(widget.isEdit! ? 'Edit Offer' : "Create New Offer",
              style: TextStyle(
                  color: AppColors.kprimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
        body: Container(
          // constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: AppColors.strokeColor2,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(35))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Job Title",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.kprimaryColor),
                ),
                defaultSizeBoxHeight,
                CustomTextField(
                  validatorText: "Please Enter Job Title",

                  hintText: "Please Enter Job Title",
                  controller: titleController,
                  // onChanged: (value) => controller.emailController.text.trim() = value!,
                ),
                defaultSizeBoxHeight,
                Text(
                  "Job Description",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.kprimaryColor),
                ),
                defaultSizeBoxHeight,
                CustomTextField(
                  validatorText: "Please Enter Job Description",
                  hintText: "Please Enter Job Description",
                  controller: descriptionController,
                  maxLines: 3,
                  // onChanged: (value) => controller.emailController.text.trim() = value!,
                ),
                defaultSizeBoxHeight,
                Text(
                  "Offer Image (optional)",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.kprimaryColor),
                ),
                defaultSizeBoxHeight,
                InkWell(
                  onTap: () {
                    HomeController.to.showPickerDialog(context);
                  },
                  child: Center(
                    child: Stack(children: [
                      Obx(() {
                        return SizedBox(
                            height: 120,
                            width: 130,
                            child: HomeController.to.image.value != null
                                ? Image.file(
                                    File(HomeController.to.image.value!.path),
                                    // height: 150,
                                    // width: 150,
                                    fit: BoxFit.fill,
                                  )
                                : widget.isEdit == true
                                    ? FutureBuilder(
                                        future: FirebaseAPIs.fetchOfferImageUrl(
                                            widget.service!.offerId.toString()),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.waiting &&
                                              snapshot.connectionState ==
                                                  ConnectionState.none) {
                                            return Image.asset(
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.none,
                                              ImageConstant.dummy,
                                              // height: 80,
                                            );
                                          } else if (snapshot.hasData) {
                                            return Image.network(
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              snapshot.data.toString(),
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child; // Image has finished loading
                                                }
                                                return SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: AppColors
                                                          .kprimaryColor,
                                                      // value: loadingProgress.expectedTotalBytes != null
                                                      //     ? loadingProgress.cumulativeBytesLoaded /
                                                      //     (loadingProgress.expectedTotalBytes ?? 1)
                                                      //     : null,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            return FutureBuilder(
                                              future: FirebaseAPIs
                                                  .fetchDefaultOfferImageUrl(
                                                      widget.service!
                                                          .serviceCategoryType
                                                          .toString()),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                        ConnectionState
                                                            .waiting &&
                                                    snapshot.connectionState ==
                                                        ConnectionState.none) {
                                                  return Image.asset(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    fit: BoxFit.none,
                                                    ImageConstant.dummy,
                                                    // height: 80,
                                                  );
                                                } else if (snapshot.hasData) {
                                                  return Image.network(
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                      snapshot.data.toString());
                                                } else {
                                                  return Image.asset(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    fit: BoxFit.none,
                                                    ImageConstant.dummy,
                                                    // height: 80,
                                                  );
                                                }
                                              },
                                            );
                                          }
                                        },
                                      )
                                    : Image(
                                        image: AssetImage(ImageConstant.dummy),
                                        fit: BoxFit.cover,
                                      ));
                      }),
                      Positioned(
                          right: -2,
                          top: -2,
                          child: Icon(
                            Icons.photo_camera,
                            size: 25,
                            color: AppColors.kprimaryColor,
                          ))
                    ]),
                  ),
                ),
                defaultSizeBoxHeight,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.kprimaryColor),
                      borderRadius: BorderRadius.circular(12)),
                  child: Obx(() {
                    return FittedBox(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        underline: const SizedBox.shrink(),
                        value: HomeController.to.selectedServiceType.value,
                        hint: const Text("Select a service type"),
                        items: serviceType.map((element) {
                          return DropdownMenuItem<String>(
                            value: element,
                            child: Text(element),
                          );
                        }).toList(),
                        onChanged: widget.isEdit!
                            ? null
                            : (value) {
                                HomeController.to.selectedServiceType.value =
                                    value!;
                              },
                      ),
                    );
                  }),
                ),
                defaultSizeBoxHeight,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.kprimaryColor),
                      borderRadius: BorderRadius.circular(12)),
                  child: Obx(() {
                    return FittedBox(
                      child: DropdownButton<CategoryList>(
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        underline: const SizedBox.shrink(),
                        value: HomeController.to.selectedCategory.value,
                        hint: const Text("Select a category"),
                        items: HomeController.to.getCatList.map((element) {
                          return DropdownMenuItem<CategoryList>(
                            value: element,
                            child: Text(element.categoryName.toString()),
                          );
                        }).toList(),
                        onChanged: widget.isEdit!
                            ? null
                            : (value) {
                                HomeController.to.selectedCategory.value =
                                    value!;
                              },
                      ),
                    );
                  }),
                ),
                defaultSizeBoxHeight,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        validatorText: "Please Enter service",

                        hintText: "Enter service",
                        controller: HomeController.to.serviceController.value,
                        // onChanged: (value) => controller.emailController.text.trim() = value!,
                      ),
                    ),
                    defaultSizeBoxWidth,
                    CustomButton(
                        onTap: () {
                          HomeController.to.yourServiceList.add({
                            "name":
                                HomeController.to.serviceController.value.text,
                            "selected": false
                          });
                          HomeController.to.packageList.forEach((package) {
                            package['service_list'] = List.from(HomeController
                                .to.yourServiceList
                                .map((service) {
                              return {
                                "name": service['name'],
                                "selected":
                                    false // Each service starts as unselected for each package
                              };
                            }).toList());
                          });
                          HomeController.to.packageList.refresh();
                          debugPrint(
                              HomeController.to.yourServiceList.toString());
                        },
                        title: 'Add')
                  ],
                ),

                Obx(() {
                  return Wrap(
                    children: List.generate(
                      HomeController.to.yourServiceList.length,
                      (index) => Container(
                        padding: EdgeInsets.all(8),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        decoration: BoxDecoration(
                          color: AppColors.kprimaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          HomeController.to.yourServiceList[index]['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
                DefaultTabController(
                  length: HomeController.to.packageList.length,
                  child: Obx(() {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TabBar(
                          onTap: (value) {
                            // HomeController.to.selectPackage(value);
                            HomeController.to.update();
                            debugPrint(
                                HomeController.to.packageList.toString());

                            print('*********************');
                            // print(HomeController.to.packageList[2]['service_list'][2]['selected']);
                          },
                          tabs: [
                            ...List.generate(
                              HomeController.to.packageList.length,
                              (index) => Text(
                                HomeController.to.packageList[index]['p_name'],
                              ),
                            ),
                          ],
                        ),
                        TabContentView(
                          children: List.generate(
                            HomeController.to.packageList.length,
                            (index) => SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "Rate",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: AppColors.kprimaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    validatorText: "Please Enter Rate",
                                    hintText: "Please Enter Rate",
                                    inputType: TextInputType.number,
                                    controller: HomeController
                                        .to.packageList[index]['price'],
                                  ),
                                  ...List.generate(
                                    HomeController
                                        .to
                                        .packageList[index]['service_list']
                                        .length,
                                    (serviceIndex) {
                                      // data[index]={serviceIndex:HomeController.to.packageList[index]['service_list'][serviceIndex]['selected']};
                                      //
                                      // print('YYYYYYYYYYYYYYY');
                                      // print(data);
                                      var serviceList = HomeController.to
                                          .packageList[index]['service_list'];
                                      return Row(
                                        children: [
                                          Text(
                                            HomeController.to.packageList[index]
                                                    ['service_list']
                                                [serviceIndex]['name'],
                                          ),
                                          Checkbox(
                                            value: HomeController
                                                        .to.packageList[index]
                                                    ['service_list']
                                                [serviceIndex]['selected'],
                                            //value: data[serviceIndex],
                                            onChanged: (value) {
                                              debugPrint(index.toString());
                                              debugPrint(
                                                  serviceIndex.toString());
                                              // Update the selected value for the specific service in the package
                                              HomeController.to.packageList[
                                                          index]['service_list']
                                                      [serviceIndex]
                                                  ['selected'] = value ?? false;

                                              // Refresh the package list to notify the UI of changes
                                              HomeController.to.packageList
                                                  .refresh();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),

                // Text(
                //   "Package: ",
                //   style: TextStyle(
                //       fontWeight: FontWeight.w700,
                //       fontSize: 12,
                //       color: AppColors.kprimaryColor),
                // ),

                defaultSizeBoxHeight,
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rate",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: AppColors.kprimaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            validatorText: "Please Enter Rate",
                            hintText: "Please Enter Rate",
                            inputType: TextInputType.number,
                            controller: rateController,

                            // onChanged: (value) => controller.emailController.text.trim() = value!,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: AppColors.kprimaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.kprimaryColor),
                                      child: FittedBox(
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            if (HomeController
                                                .to
                                                .quantityController
                                                .value
                                                .text
                                                .isEmpty) {
                                              HomeController.to.quantity.value =
                                                  0;
                                            }
                                            HomeController.to
                                                .decreaseQuantity();
                                          },
                                        ),
                                      )),
                                ),
                                Expanded(
                                  child: CustomTextField(
                                      padding: EdgeInsets.zero,
                                      textInputFormatter: [
                                        FilteringTextInputFormatter
                                            .digitsOnly, /*FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9][0-9][0-9]?$')),*/
                                      ],
                                      validatorText: "Please Enter quantity",
                                      hintText: "0",
                                      textAlign: TextAlign.center,
                                      inputType: TextInputType.number,
                                      controller: HomeController
                                          .to.quantityController.value,
                                      onChanged: (value) {
                                        int? newValue = int.tryParse(value!);
                                        if (newValue != null && newValue > 0) {
                                          HomeController.to.quantity.value =
                                              newValue;
                                        }
                                      }

                                      // onChanged: (value) => controller.emailController.text.trim() = value!,
                                      ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.kprimaryColor),
                                    child: FittedBox(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          if (HomeController
                                              .to
                                              .quantityController
                                              .value
                                              .text
                                              .isEmpty) {
                                            HomeController.to.quantity.value =
                                                0;
                                          }
                                          debugPrint(HomeController
                                              .to.quantity.value
                                              .toString());
                                          HomeController.to.increaseQuantity();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    )
                  ],
                ),
                defaultSizeBoxHeight,
                Obx(() {
                  if (HomeController.to.districtList.isEmpty) {
                    HomeController.to.districtList.refresh();

                    return CircularProgressIndicator(
                      color: AppColors.kprimaryColor,
                    );
                  } else {
                    return const SearchableDropDown(
                      fromHome: false,
                    );
                  }
                }),
                defaultSizeBoxHeight,
                Text(
                  "Address",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColors.kprimaryColor),
                ),
                defaultSizeBoxHeight,
                CustomTextField(
                  validatorText: "Please Enter address",

                  hintText: "Please Enter address",
                  controller: addressController,
                  // onChanged: (value) => controller.emailController.text.trim() = value!,
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  // alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return HomeController.to.isUploading.value
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator(
                                            color: AppColors.kprimaryColor,
                                            strokeWidth: 6,
                                            // value:HomeController.to.uploadProgress.value,color: AppColors.kprimaryColor,
                                            //
                                          ),
                                        ),
                                        Text(
                                          ' ${(HomeController.to.uploadProgress.value * 100).toStringAsFixed(0)}%',
                                          style: AppTextStyle.titleText,
                                        ),
                                      ]),
                                )
                              : HomeController.to.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: AppColors.kprimaryColor,
                                    ))
                                  : CustomButton(
                                      title: widget.service != null
                                          ? 'Update offer'
                                          : 'Create Offer',
                                      onTap: () async {
                                        {
                                          HomeController.to.isLoading.value =
                                              true;
                                          if (HomeController.to.selectedRateType.value != null &&
                                              HomeController.to.selectedCategory
                                                      .value !=
                                                  null &&
                                              HomeController.to.selectedDistrict
                                                      .value !=
                                                  null &&
                                              titleController.text.isNotEmpty &&
                                              descriptionController
                                                  .text.isNotEmpty &&
                                              rateController.text.isNotEmpty &&
                                              addressController
                                                  .text.isNotEmpty &&
                                              HomeController
                                                  .to
                                                  .quantityController
                                                  .value
                                                  .text
                                                  .isNotEmpty &&
                                              box.isNotEmpty) {
                                            if (widget.service != null) {
                                              await HomeController.to.editOffer(
                                                  widget.service!.offerId ?? '',
                                                  titleController.text,
                                                  descriptionController.text,
                                                  rateController.text,
                                                  addressController.text);

                                              // Get.to(MyServiceDetails());
                                              // SellerProfileController.to.myService.refresh();
                                              //  SellerProfileController.to.service.update(
                                              //   (val) async {
                                              //     return SellerProfileController.to
                                              //         .refreshAllData();
                                              //   },
                                              // );
                                              // await SellerProfileController.to.refreshAllData();
                                              // Future.delayed(Duration(milliseconds: 300),() => Get.back(),);
                                              // clear();

                                              Get.back();
                                              Get.snackbar("Success",
                                                  "Updated Successfully");
                                            } else {
                                              await HomeController.to
                                                  .createOffer(
                                                      titleController.text,
                                                      descriptionController
                                                          .text,
                                                      rateController.text,
                                                      addressController.text);
                                              // await SellerProfileController.to
                                              //     .refreshAllData();
                                              clear();
                                            }

                                            // clear();
                                          } else {
                                            Get.snackbar(
                                                "All field Required", "");
                                            // clear();
                                          }
                                          HomeController.to.isLoading.value =
                                              false;
                                        }
                                      },
                                    );
                        }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clear() {
    titleController.clear();
    descriptionController.clear();
    // HomeController.to.image.value=null;
    HomeController.to.selectedCategory.value = null;
    HomeController.to.selectedRateType.value = null;
    HomeController.to.selectedDistrict.value = null;
    rateController.clear();
    addressController.clear();
    HomeController.to.quantityController.value.clear();
    HomeController.to.quantity.value = 1;
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kprimaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12)),
        onPressed: onTap,
        child: Text(title));
  }
}
