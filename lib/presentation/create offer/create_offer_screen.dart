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

import '../HomeScreen/widgets/custom_button_widget.dart';
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

  static TextEditingController titleController=TextEditingController();
  static TextEditingController addressController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();

  List<String> timeUnits = ['Hour', 'Task', 'Per Day', 'Piece'];
  List<String> serviceType = ['Local', 'Online'];
  Map data = {};

  @override
  void initState() {
    // print(district.toString());
    // HomeController.to.getCategoryList();
    addressController = TextEditingController(
        text: widget.service != null && widget.service!.address!.isNotEmpty
            ? widget.service!.address
            : addressController.text);
    HomeController.to.initializeControllers();
    titleController = TextEditingController(
        text: widget.service != null ? widget.service!.jobTitle : titleController.text);
    // print( 'package-------------');
    // print(widget.service!.package!.map((e) => e.packageName,));
    for (var i = 0; i < HomeController.to.priceControllers.length; i++) {
      // Ensure we don't exceed the number of packages

        if(widget.service!=null/*||widget.service!.package!=null*/) {
          if (i < widget.service!.package!.length) {
          HomeController.to.priceControllers[i].text = widget.service!.package![i].price.toString();
        }else{
          HomeController.to.priceControllers[i].text=HomeController.to.priceControllers[i].text;
        }
      }
    }
    for (var i = 0; i < HomeController.to.durationControllers.length; i++) {
      // Ensure we don't exceed the number of packages

        if(widget.service!=null/*||widget.service!.package!=null*/) {
          if (i < widget.service!.package!.length) {
        HomeController.to.durationControllers[i].text = widget.service!.package![i].duration.toString();}
        else{
          HomeController.to.durationControllers[i].text=HomeController.to.durationControllers[i].text;
        }
      }
    }
    for (var i = 0; i < HomeController.to.descriptionControllers.length; i++) {
      // Ensure we don't exceed the number of packages

        if(widget.service!=null/*||widget.service!.package!=null*/) {
          if (i < widget.service!.package!.length) {
        HomeController.to.descriptionControllers[i].text = widget.service!.package![i].packageDescription.toString();}
        else{
          HomeController.to.descriptionControllers[i].text=HomeController.to.descriptionControllers[i].text;
        }
      }
    }



    descriptionController = TextEditingController(
        text: widget.service != null ? widget.service!.description : descriptionController.text);
    if (widget.service != null) {
      var matchedServiceType = serviceType
          .where(
            (element) => element == widget.service!.serviceType,
          )
          .toList();
      if (matchedServiceType.isNotEmpty) {
        HomeController.to.selectedServiceType.value = matchedServiceType[0];
      } else {
        HomeController.to.selectedServiceType.value = null;
      }
    } else {
      HomeController.to.selectedServiceType.value = HomeController.to.selectedServiceType.value;
    }
    if (widget.service != null) {
      var filteredList = HomeController.to.getCatList
          .where((e) =>
              e.categoryName!.toLowerCase() ==
              widget.service!.serviceCategoryType!.toLowerCase())
          .toList();
      print('filteredList.first');
      print(filteredList[0].categoryName);

      if (filteredList.isNotEmpty) {
        HomeController.to.selectedCategory.value = filteredList.first;
      } else {
        HomeController.to.selectedCategory.value =
            null; // Or handle the case when no match is found
      }
    }
    else {
      HomeController.to.selectedCategory.value = HomeController.to.selectedCategory.value;
      HomeController.to.image.value = null;
    }
    // debugPrint(widget.service!.rateType);
    // HomeController.to.selectedRateType.value = widget.service != null &&
    //         timeUnits.any((item) => item.contains(widget.service!.rateType!))
    //     ? widget.service!.rateType.toString()
    //     : null;
    HomeController.to.selectedDistrict.value =
        widget.service != null && widget.service!.district!.isNotEmpty
            ? widget.service!.district
            : HomeController.to.selectedDistrict.value;

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
/*           actions: [IconButton(onPressed:  () {
             if(
             HomeController.to.packageList.map((element) => element['service_list'],)
                 .where((element) => element.isNotEmpty,).toList().isNotEmpty
             ){
               print('true');
               // print(HomeController.to.priceControllers.map((element) => element.text,).toList());
             }else{
               print('false');
             }
           }, icon: Icon(Icons.clear,color: Colors.black,))],*/
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
                            value: HomeController.to.selectedServiceType.value,
                            hint: Text(
                              "Select a service type",
                              style: TextStyle(
                                color: AppColors.kprimaryColor,
                              ),
                            ),
                            items: serviceType.map((element) {
                              return DropdownMenuItem<String>(
                                value: element,
                                child: Text(element),
                              );
                            }).toList(),
                            onChanged: widget.isEdit!
                                ? null
                                : (value) {
                                    HomeController
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
                        // print('object');
                        for (var element in HomeController.to.getCatList) {
                          print(element.toJson());
                        }
                        // print(HomeController.to.selectedCategory.value!.toJson());
                        return FittedBox(
                          child: DropdownButton<CategoryList>(
                            dropdownColor: Colors.white,
                            iconEnabledColor: AppColors.kprimaryColor,
                            borderRadius: BorderRadius.circular(12),
                            underline: const SizedBox.shrink(),
                            style: TextStyle(
                              color: AppColors.kprimaryColor,
                            ),
                            value: /*HomeController.to.selectedCategory.value != null
                                && HomeController.to.getCatList.contains(HomeController.to.selectedCategory.value)
                                ? */
                                HomeController
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
                            controller:
                                HomeController.to.serviceController.value,
                            // onChanged: (value) => controller.emailController.text.trim() = value!,
                          ),
                        ),
                        defaultSizeBoxWidth,
                        CustomButton(
                            onTap: () {
                              if (HomeController
                                  .to.serviceController.value.text.isNotEmpty) {
                                HomeController.to.yourServiceList.add({
                                  "service_name": HomeController
                                      .to.serviceController.value.text,
                                  "status": false
                                });
                                for (var package in HomeController.to.packageList) {
                                  package['service_list'] = List.from(
                                      HomeController.to.yourServiceList
                                          .map((service) {
                                    return {
                                      "service_name": service['service_name'],
                                      "status":
                                          false // Each service starts as unselected for each package
                                    };
                                  }).toList());
                                }
                                HomeController.to.packageList.refresh();
                                HomeController.to.serviceController.value
                                    .clear();
                                debugPrint(HomeController.to.yourServiceList
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
                      HomeController.to.yourServiceList.length,
                      (index) => Container(
                        padding: EdgeInsets.only(left: 8),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        decoration: BoxDecoration(
                          color: AppColors.kprimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                HomeController.to.yourServiceList[index]
                                    ['service_name'],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  HomeController.to.yourServiceList
                                      .removeAt(index);
                                  for (var element in HomeController.to.packageList) {
                                    element['service_list']
                                      ..removeAt(index);
                                  }
                                  HomeController.to.packageList.refresh();
                                },
                                icon: Icon(
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
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColors.kprimaryColor, width: 1.5)),
                  child: DefaultTabController(
                    length: HomeController.to.packageList.length,
                    child: Obx(() {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HomeController.to.packageList.isEmpty
                              ? SizedBox.shrink()
                              : TabBar(
                                  overlayColor: WidgetStateColor.transparent,
                                  onTap: (value) {
                                    // HomeController.to.selectPackage(value);
                                    HomeController.to.update();
                                    debugPrint(HomeController.to.packageList
                                        .toString());
                                  },
                                  tabs: [
                                    ...List.generate(
                                      HomeController.to.packageList.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FittedBox(
                                          child: Text(
                                            HomeController.to.packageList[index]
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
                            children: HomeController.to.packageList.isNotEmpty
                                ? List.generate(
                                    HomeController.to.packageList.length,
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
                                                      controller: HomeController
                                                              .to
                                                              .priceControllers[
                                                          index],
                                                      onChanged: (value) {
                                                        HomeController.to
                                                                .packageList[index]
                                                            ['price'] = value;
                                                        HomeController
                                                            .to.packageList
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
                                                        HomeController.to
                                                                .packageList[index]
                                                            [
                                                            'duration'] = value;
                                                        HomeController
                                                            .to.packageList
                                                            .refresh();
                                                      },
                                                      controller: HomeController
                                                              .to
                                                              .durationControllers[
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
                                                  HomeController.to.packageList[
                                                              index][
                                                          'package_description'] =
                                                      value;
                                                  HomeController.to.packageList
                                                      .refresh();
                                                },
                                                controller: HomeController.to
                                                        .descriptionControllers[
                                                    index],
                                              ),
                                            ],
                                          ),
                                          HomeController
                                                  .to
                                                  .packageList[index]
                                                      ['service_list']
                                                  .isEmpty
                                              ? SizedBox.shrink()
                                              : Column(
                                                  children: List.generate(
                                                    HomeController
                                                        .to
                                                        .packageList[index]
                                                            ['service_list']
                                                        .length,
                                                    (serviceIndex) {
                                                      // data[index]={serviceIndex:HomeController.to.packageList[index]['service_list'][serviceIndex]['selected']};
                                                      //
                                                      // print('YYYYYYYYYYYYYYY');
                                                      // print(data);
                                                      var serviceList =
                                                          HomeController.to
                                                                      .packageList[
                                                                  index]
                                                              ['service_list'];
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              HomeController.to.packageList[index]
                                                                              [
                                                                              'service_list']
                                                                          [
                                                                          serviceIndex]
                                                                      [
                                                                      'service_name'] ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          Checkbox(
                                                            activeColor: AppColors
                                                                .kprimaryColor,
                                                            value: HomeController
                                                                            .to
                                                                            .packageList[
                                                                        index][
                                                                    'service_list']
                                                                [
                                                                serviceIndex]['status'],
                                                            //value: data[serviceIndex],
                                                            onChanged: (value) {
                                                              debugPrint(
                                                                  HomeController
                                                                      .to
                                                                      .packageList
                                                                      .toString());
                                                              debugPrint(
                                                                  serviceIndex
                                                                      .toString());
                                                              // Update the selected value for the specific service in the package
                                                              HomeController.to.packageList[index]
                                                                              [
                                                                              'service_list']
                                                                          [
                                                                          serviceIndex]
                                                                      [
                                                                      'status'] =
                                                                  value ??
                                                                      false;

                                                              // Refresh the package list to notify the UI of changes
                                                              HomeController.to
                                                                  .packageList
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
                                    Center(child: Text('No Packages Available'))
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
                                          if (HomeController
                                                      .to
                                                      .selectedServiceType
                                                      .value !=
                                                  null &&
                                              HomeController.to.selectedCategory
                                                      .value !=
                                                  null &&
                                              HomeController
                                                      .to
                                                      .selectedServiceType
                                                      .value !=
                                                  null &&
                                              HomeController.to.selectedDistrict
                                                      .value !=
                                                  null &&
                                              titleController.text.isNotEmpty &&
                                              descriptionController
                                                  .text.isNotEmpty &&
                                              addressController
                                                  .text.isNotEmpty &&
                                              HomeController
                                                  .to.packageList.isNotEmpty &&
                                              HomeController.to.priceControllers
                                                  .map(
                                                    (element) => element.text,
                                                  )
                                                  .where(
                                                    (element) =>
                                                        element.isNotEmpty,
                                                  )
                                                  .toList()
                                                  .isNotEmpty &&
                                              HomeController
                                                  .to.durationControllers
                                                  .map(
                                                    (element) => element.text,
                                                  )
                                                  .where(
                                                    (element) =>
                                                        element.isNotEmpty,
                                                  )
                                                  .toList()
                                                  .isNotEmpty &&
                                              HomeController.to.packageList
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
                                              await HomeController.to.editOffer(
                                                  widget.service!.offerId ?? '',
                                                  titleController.text,
                                                  descriptionController.text,
                                                  '',
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
                                              // Future.delayed(Description(milliseconds: 300),() => Get.back(),);
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
                                                      addressController.text);
                                              // await SellerProfileController.to
                                              //     .refreshAllData();
                                              clear();
                                            }

                                            // clear();
                                          } else {
                                            Get.snackbar(
                                                "Failed", "All field Required");
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
    for (var controller in HomeController.to.priceControllers) {
      controller.clear();
    }
    for (var controller in HomeController.to.descriptionControllers) {
      controller.clear();
    }
    for (var controller in HomeController.to.durationControllers) {
      controller.clear();
    }
    for (var element in HomeController.to.packageList) {
      element['service_list']..clear();
    }
    HomeController.to.yourServiceList.clear();
    // HomeController.to.packageList.map((e) => e['service_list'].clear(),);
    HomeController.to.selectedCategory.value = null;
    HomeController.to.selectedRateType.value = null;
    HomeController.to.selectedDistrict.value = null;
    HomeController.to.packageList.refresh();
    HomeController.to.selectedServiceType.value = null;

    addressController.clear();
    HomeController.to.quantityController.value.clear();
    HomeController.to.quantity.value = 1;
  }
  // @override
  // void dispose() {
  //   for (var controller in HomeController.to.priceControllers) {
  //     controller.dispose();
  //   }
  //   for (var controller in HomeController.to.descriptionControllers) {
  //     controller.dispose();
  //   }
  //   for (var controller in HomeController.to.durationControllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }
}
