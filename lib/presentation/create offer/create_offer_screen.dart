import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';
import 'package:upai/presentation/HomeScreen/widgets/search_able_dropdown.dart';
import 'package:upai/presentation/create%20offer/controller/create_offer_controller.dart';
import 'package:upai/widgets/custom_text_field.dart';

import '../HomeScreen/widgets/custom_button_widget.dart';
import 'widget/tab_content_view.dart';

class CreateOfferScreen extends StatefulWidget {
  static const String routeName ='/create-offer';
  final MyService? service;


  const CreateOfferScreen({super.key, this.service, });

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  final box = Hive.box('userInfo');
  // var serviceArgument =Get.arguments()['service'];
   var isEditArgument =false;
  Map<String, dynamic>? arguments = Get.arguments;
  @override
  void initState() {

   if(arguments!=null) {
      CreateOfferController.to.editOfferData(arguments!['service']);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Get.arguments()');
    debugPrint(arguments.toString());
    HomeController.to.isLoading.value = false;
    HomeController.to.isUploading.value = false;
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

          title: Text(isEditArgument ? 'Edit Offer' : "Create New Offer",
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
                  controller: CreateOfferController.to.titleController.value,
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
                  controller: CreateOfferController.to.descriptionController.value,
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
                                : isEditArgument== true
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category Type",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.kprimaryColor,
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
                            style: TextStyle(
                              color: AppColors.kprimaryColor,
                            ),
                            iconEnabledColor: AppColors.kprimaryColor,
                            borderRadius: BorderRadius.circular(12),
                            underline: const SizedBox.shrink(),
                            value: CreateOfferController.to.selectedServiceType.value,
                            hint: Text(
                              "Select a service type",
                              style: TextStyle(
                                color: AppColors.kprimaryColor,
                              ),
                            ),
                            items: CreateOfferController.to.serviceType.map((element) {
                              return DropdownMenuItem<String>(
                                value: element,
                                child: Text(element),
                              );
                            }).toList(),
                            onChanged: isEditArgument
                                ? null
                                : (value) {
                              CreateOfferController
                                        .to.selectedServiceType.value = value!;
                                  },
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                defaultSizeBoxHeight,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.kprimaryColor,
                      ),
                    ),
                    defaultSizeBoxHeight,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.kprimaryColor),
                          borderRadius: BorderRadius.circular(12)),
                      child: Obx(() {

                        // print(CreateOfferController.to.selectedCategory.value!.toJson());
                        return FittedBox(
                          child: DropdownButton<CategoryList>(
                            dropdownColor: Colors.white,
                            iconEnabledColor: AppColors.kprimaryColor,
                            borderRadius: BorderRadius.circular(12),
                            underline: const SizedBox.shrink(),
                            style: TextStyle(
                              color: AppColors.kprimaryColor,
                            ),
                            value: /*CreateOfferController.to.selectedCategory.value != null
                                && HomeController.to.getCatList.contains(CreateOfferController.to.selectedCategory.value)
                                ? */
                            CreateOfferController
                                    .to.selectedCategory.value /*:null */,
                            hint: Text(
                              "Select a category",
                              style: TextStyle(
                                color: AppColors.kprimaryColor,
                              ),
                            ),
                            items: HomeController.to.getCatList.map((element) {
                              return DropdownMenuItem<CategoryList>(
                                value: element,
                                child: Text(element.categoryName ?? ''),
                              );
                            }).toList(),
                            onChanged: isEditArgument
                                ? null
                                : (value) {
                                    CreateOfferController.to.selectedCategory.value =
                                        value!;
                                  },
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                defaultSizeBoxHeight,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Services",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.kprimaryColor,
                      ),
                    ),
                    defaultSizeBoxHeight,
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            validatorText: "Please Enter service",

                            hintText: "Enter service",
                            controller:CreateOfferController.to.serviceController.value,
                            // onChanged: (value) => controller.emailController.text.trim() = value!,
                          ),
                        ),
                        defaultSizeBoxWidth,
                        CustomButton(
                            onTap: () {
                              if (CreateOfferController.to.serviceController.value.text.isNotEmpty) {
                                CreateOfferController.to.yourServiceList.add({
                                  "service_name": CreateOfferController.to.serviceController.value.text,
                                  "status": false
                                });
                                for (var package in CreateOfferController.to.packageList) {
                                  package['service_list'] = List.from(
                                      CreateOfferController.to.yourServiceList
                                          .map((service) {
                                    return {
                                      "service_name": service['service_name'],
                                      "status":
                                          false // Each service starts as unselected for each package
                                    };
                                  }).toList());
                                }
                                CreateOfferController.to.packageList.refresh();CreateOfferController.to.serviceController.value
                                    .clear();
                                debugPrint(CreateOfferController.to.yourServiceList
                                    .toString());
                              } else {
                                Get.snackbar(
                                    "failed", "Please Enter valid service");
                              }
                            },
                            title: 'Add')
                      ],
                    ),
                  ],
                ),
                Obx(() {
                  return Wrap(
                    children: List.generate(
                      CreateOfferController.to.yourServiceList.length,
                      (index) => Container(
                        padding: const EdgeInsets.only(left: 8),
                        margin:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        decoration: BoxDecoration(
                          color: AppColors.kprimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                CreateOfferController.to.yourServiceList[index]
                                    ['service_name'],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  CreateOfferController.to.yourServiceList
                                      .removeAt(index);
                                  for (var element in CreateOfferController.to.packageList) {
                                    element['service_list']
                                      .removeAt(index);
                                  }
                                  CreateOfferController.to.packageList.refresh();
                                },
                                icon: const Icon(
                                  CupertinoIcons.multiply_circle,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                defaultSizeBoxHeight,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColors.kprimaryColor, width: 1.5)),
                  child: DefaultTabController(
                    length: CreateOfferController.to.packageList.length,
                    child: Obx(() {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CreateOfferController.to.packageList.isEmpty
                              ? const SizedBox.shrink()
                              : TabBar(
                                  overlayColor: WidgetStateColor.transparent,
                                  onTap: (value) {
                                    // HomeController.to.selectPackage(value);
                                    HomeController.to.update();
                                    debugPrint(CreateOfferController.to.packageList
                                        .toString());
                                  },
                                  tabs: [
                                    ...List.generate(
                                      CreateOfferController.to.packageList.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FittedBox(
                                          child: Text(
                                            CreateOfferController.to.packageList[index]
                                                ['package_name'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  indicatorColor: AppColors.kprimaryColor,
                                  labelColor: AppColors.kprimaryColor,
                                ),
                          TabContentView(
                            children: CreateOfferController.to.packageList.isNotEmpty
                                ? List.generate(
                                    CreateOfferController.to.packageList.length,
                                    (index) => SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          defaultSizeBoxHeight,
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Price",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .kprimaryColor,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    CustomTextField(
                                                      validatorText:
                                                          "Please Enter Price",
                                                      hintText:
                                                          "Please Enter Price",
                                                      inputType:
                                                          TextInputType.number,
                                                      controller: CreateOfferController.to.packagePriceControllers[
                                                          index],
                                                      onChanged: (value) {
                                                        CreateOfferController.to.packageList[index]
                                                            ['price'] = value;
                                                        CreateOfferController.to.packageList
                                                            .refresh();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              defaultSizeBoxWidth,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Duration",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .kprimaryColor,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    CustomTextField(
                                                      validatorText:
                                                          "Please Enter Duration",
                                                      hintText:
                                                          "Please Enter Duration",
                                                      inputType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        CreateOfferController.to.packageList[index]
                                                            [
                                                            'duration'] = value;
                                                        CreateOfferController.to.packageList
                                                            .refresh();
                                                      },
                                                      controller: CreateOfferController.to.packageDurationControllers[
                                                          index],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              defaultSizeBoxHeight,
                                              Text(
                                                "Package Description",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                  color:
                                                      AppColors.kprimaryColor,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              CustomTextField(
                                                validatorText:
                                                    "Please Enter Description",
                                                hintText:
                                                    "Please Enter Description",
                                                maxLines: 3,
                                                onChanged: (value) {
                                                  CreateOfferController.to.packageList[
                                                              index][
                                                          'package_description'] =
                                                      value;
                                                  CreateOfferController.to.packageList
                                                      .refresh();
                                                },
                                                controller: CreateOfferController.to
                                                        .packageDescriptionControllers[
                                                    index],
                                              ),
                                            ],
                                          ),
                                          CreateOfferController.to.packageList[index]
                                                      ['service_list']
                                                  .isEmpty
                                              ? const SizedBox.shrink()
                                              : Column(
                                                  children: List.generate(
                                                    CreateOfferController.to.packageList[index]
                                                            ['service_list']
                                                        .length,
                                                    (serviceIndex) {
                                                      // data[index]={serviceIndex:CreateOfferController.to.packageList[index]['service_list'][serviceIndex]['selected']};
                                                      //
                                                      // print('YYYYYYYYYYYYYYY');
                                                      // print(data);
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              CreateOfferController.to.packageList[index]
                                                                              [
                                                                              'service_list']
                                                                          [
                                                                          serviceIndex]
                                                                      [
                                                                      'service_name'] ??
                                                                  '',
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          Checkbox(
                                                            activeColor: AppColors
                                                                .kprimaryColor,
                                                            value: CreateOfferController.to.packageList[
                                                                        index][
                                                                    'service_list']
                                                                [
                                                                serviceIndex]['status'],
                                                            //value: data[serviceIndex],
                                                            onChanged: (value) {
                                                              debugPrint(
                                                                  CreateOfferController.to.packageList
                                                                      .toString());
                                                              debugPrint(
                                                                  serviceIndex
                                                                      .toString());
                                                              // Update the selected value for the specific service in the package
                                                              CreateOfferController.to.packageList[index]
                                                                              [
                                                                              'service_list']
                                                                          [
                                                                          serviceIndex]
                                                                      [
                                                                      'status'] =
                                                                  value ??
                                                                      false;

                                                              // Refresh the package list to notify the UI of changes
                                                              CreateOfferController.to.packageList
                                                                  .refresh();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  )
                                : [
                                    const Center(child: Text('No Packages Available'))
                                  ],
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                defaultSizeBoxHeight,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "District",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.kprimaryColor,
                      ),
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
                  ],
                ),
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
                  controller: CreateOfferController.to.addressController.value,
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
                                          if (CreateOfferController
                                                      .to
                                                      .selectedServiceType
                                                      .value !=
                                                  null &&
                                              CreateOfferController.to.selectedCategory
                                                      .value !=
                                                  null &&
                                              CreateOfferController
                                                      .to
                                                      .selectedServiceType
                                                      .value !=
                                                  null &&
                                              CreateOfferController.to.selectedDistrict
                                                      .value !=
                                                  null &&
                                              CreateOfferController.to.titleController.value.text.isNotEmpty &&
                                              CreateOfferController.to.descriptionController.value
                                                  .text.isNotEmpty &&
                                              CreateOfferController.to.addressController.value
                                                  .text.isNotEmpty &&
                                              CreateOfferController.to.packageList.isNotEmpty &&
                                              CreateOfferController.to.packagePriceControllers
                                                  .map(
                                                    (element) => element.text,
                                                  )
                                                  .where(
                                                    (element) =>
                                                        element.isNotEmpty,
                                                  )
                                                  .toList()
                                                  .isNotEmpty &&
                                              CreateOfferController.to.packageDurationControllers
                                                  .map(
                                                    (element) => element.text,
                                                  )
                                                  .where(
                                                    (element) =>
                                                        element.isNotEmpty,
                                                  )
                                                  .toList()
                                                  .isNotEmpty &&
                                              CreateOfferController.to.packageList
                                                  .map(
                                                    (element) =>
                                                        element['service_list'],
                                                  )
                                                  .where(
                                                    (element) =>
                                                        element.isNotEmpty,
                                                  )
                                                  .toList()
                                                  .isNotEmpty &&
                                              box.isNotEmpty) {
                                            if (widget.service != null) {
                                              await CreateOfferController.to.editOffer(
                                                  widget.service!.offerId ?? '',
                                                  CreateOfferController.to.titleController.value.text,
                                                  CreateOfferController.to.descriptionController.value.text,
                                                  '',
                                                  CreateOfferController.to.addressController.value.text);

                                              Get.back();
                                              Get.snackbar("Success",
                                                  "Updated Successfully");
                                            } else {
                                              await CreateOfferController.to
                                                  .createOffer(
                                                      CreateOfferController.to.titleController.value.text,
                                                      CreateOfferController.to.descriptionController.value
                                                          .text,
                                                      CreateOfferController.to.addressController.value.text);

                                              clearAllField();
                                            }
                                          } else {
                                            Get.snackbar(
                                                "Failed", "All field Required");
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

  void clearAllField() {
    CreateOfferController.to.titleController.value.clear();
    CreateOfferController.to.descriptionController.value.clear();
    for (var controller in CreateOfferController.to.packagePriceControllers) {
      controller.clear();
    }
    for (var controller in CreateOfferController.to.packageDescriptionControllers) {
      controller.clear();
    }
    for (var controller in CreateOfferController.to.packageDurationControllers) {
      controller.clear();
    }
    for (var element in CreateOfferController.to.packageList) {
      element['service_list'].clear();
    }
    CreateOfferController.to.yourServiceList.clear();
    // CreateOfferController.to.packageList.map((e) => e['service_list'].clear(),);
    CreateOfferController.to.selectedCategory.value = null;
    CreateOfferController.to.selectedDistrict.value = null;
    CreateOfferController.to.packageList.refresh();
    CreateOfferController.to.selectedServiceType.value = null;

    CreateOfferController.to.addressController.value.clear();
  }

}
