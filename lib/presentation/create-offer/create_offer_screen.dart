import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/controllers/image_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/global_variable.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/create-offer/controller/create_offer_controller.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
import 'package:upai/widgets/custom_network_image.dart';
import 'package:upai/widgets/custom_text_field.dart';
import '../home/widgets/custom_button_widget.dart';
import '../home/widgets/search_able_dropdown.dart';
import 'widget/custom_drop_down.dart';
import 'widget/package_create_widget.dart';

class CreateOfferScreen extends StatefulWidget {
  static const String routeName = '/create-offer';
  final MyService? service;

  const CreateOfferScreen({
    super.key,
    this.service,
  });

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  final box = Hive.box('userInfo');

  // var serviceArgument =Get.arguments()['service'];
  bool isEditArgument = false;
  Map<String, dynamic>? arguments = Get.arguments;
  @override
  void initState() {
    if (arguments != null) {
      CreateOfferController.to.editOfferData(arguments!['service']);
      isEditArgument = arguments!['isEdit'];

      debugPrint('000000000000000000');
      debugPrint(arguments!['service'].offerId.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Get.arguments()');
    debugPrint(arguments.toString());
    CreateOfferController.to.isLoading.value = false;
    CreateOfferController.to.isUploading.value = false;
    return WillPopScope(

      onWillPop: () async {
        // Check if nextProcess is true
        if (CreateOfferController.to.nextProcess.value) {
          // If true, reset nextProcess to false and prevent pop
          CreateOfferController.to.nextProcess.value = false;
          return false; // Prevent pop
        }
        // Allow pop if nextProcess is false
        CreateOfferController.to.image.value = null;
        return true; // Allow pop
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: AppColors.kprimaryColor,
          actions: [IconButton(onPressed: () {
           debugPrint(CreateOfferController.to.packageList.toString()) ;
          }, icon: const Icon(Icons.add))],
          title: Text(isEditArgument ? 'edit_offer' : "create_new_offer".tr,
              style: TextStyle(
                  color: AppColors.kprimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
        body: Container(
           constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: AppColors.strokeColor2,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(35))),
          child: SingleChildScrollView(
            child: Obx(
          () {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !CreateOfferController.to.nextProcess.value
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                label: "title".tr,
                                isRequired: true,
                                validatorText: "please_enter_job_title".tr,

                                hintText: "please_enter_job_title".tr,
                                controller:
                                    CreateOfferController.to.titleController.value,
                                // onChanged: (value) => controller.emailController.text.trim() = value!,
                              ),
                              defaultSizeBoxHeight,
                              CustomTextField(
                                label: "description".tr,
                                isRequired: true,
                                validatorText: "please_enter_job_description".tr,
                                hintText: "please_enter_job_description".tr,
                                controller: CreateOfferController
                                    .to.descriptionController.value,
                                maxLines: 3,
                                // onChanged: (value) => controller.emailController.text.trim() = value!,
                              ),
                              defaultSizeBoxHeight,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "offer_image_optional".tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: AppColors.kprimaryColor),
                                      ),
                                      defaultSizeBoxHeight,
                                      InkWell(
                                        onTap: () {
                                          CreateOfferController.to
                                              .showPickerDialog(context);
                                        },
                                        child: Obx(() {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: SizedBox(
                                                height: 120,
                                                width: 130,
                                                child: CreateOfferController
                                                            .to.image.value !=
                                                        null
                                                    ? Image.file(
                                                        File(CreateOfferController
                                                            .to.image.value!.path),
                                                        // height: 150,
                                                        // width: 150,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : isEditArgument == true
                                                        ? const CustomNetworkImage(
                                                            imgPreview: true,
                                                            // height: 150,
                                                            imageUrl: '',
                                                          )
                                                        : Image.asset(
                                                            ImageConstant
                                                                .uploadImage,
                                                            color: AppColors
                                                                .kprimaryColor,
                                                            fit: BoxFit.cover,
                                                          )),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  spaceWidth6,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "category_type".tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              color: AppColors.kprimaryColor,
                                            ),
                                          ),
                                          spaceWidth6,
                                          const Text(
                                            '*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 10,
                                                color: Colors.red),
                                          )
                                        ],
                                      ),
                                      defaultSizeBoxHeight,
                                      Obx(() {
                                        return CustomDropDown<String>(
                                          label: "select_service_type".tr,
                                          isEditArgument: isEditArgument,
                                          menuList: serviceType,
                                          value: CreateOfferController
                                              .to.selectedServiceType.value,
                                          onChanged: (val) {
                                            CreateOfferController
                                                .to.selectedServiceType.value = val;
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                              defaultSizeBoxHeight,
                               RequiredTitleWidget(
                                name: "category".tr,
                              ),
                              defaultSizeBoxHeight,
                              Obx(() {
                                return CustomDropDown<dynamic>(
                                  label: "service_category".tr,
                                  isEditArgument: isEditArgument,
                                  menuList: HomeController.to.getCatList
                                      .map(
                                        (element) => element.categoryName,
                                      )
                                      .toList(),
                                  value: CreateOfferController
                                      .to.selectedCategory.value,
                                  onChanged: (value) {
                                    CreateOfferController
                                        .to.selectedCategory.value = value;
                                  },
                                );
                              }),
                              defaultSizeBoxHeight,
                              const RequiredTitleWidget(
                                name: "Package level",
                              ),
                              defaultSizeBoxHeight,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() {
                                    return CustomDropDown<dynamic>(
                                      label: "select_a_package_level".tr,
                                      // isEditArgument: isEditArgument,
                                      menuList:
                                          CreateOfferController.to.packageLevelList,
                                      value: CreateOfferController
                                          .to.selectedLevel.value,
                                      onChanged: (value) {
                                        CreateOfferController
                                            .to.selectedLevel.value = value;
                                      },
                                    );
                                  }),
                                  CustomButton(
                                    title: 'next'.tr,
                                    onTap: () {
                                      CreateOfferController.to.nextProcess.value =
                                          true;
                                      CreateOfferController.to.populatePackageList( CreateOfferController.to.selectedLevel.value??3);
                                      // CreateOfferController.to.update();
                                    },
                                  )
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              defaultSizeBoxHeight,
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.end,
                              //   children: [
                              //     Expanded(
                              //       child: CustomTextField(
                              //         label: "Services",
                              //         isRequired: true,
                              //         validatorText: "Please Enter service",
                              //
                              //         hintText: "Enter service",
                              //         controller:
                              //             CreateOfferController.to.serviceController.value,
                              //         // onChanged: (value) => controller.emailController.text.trim() = value!,
                              //       ),
                              //     ),
                              //     defaultSizeBoxWidth,
                              //     CustomButton(
                              //         onTap: () {
                              //           if (CreateOfferController
                              //               .to.serviceController.value.text.isNotEmpty) {
                              //             CreateOfferController.to.yourServiceList.add({
                              //               "service_name": CreateOfferController
                              //                   .to.serviceController.value.text,
                              //               "status": false
                              //             });
                              //             for (var package
                              //                 in CreateOfferController.to.packageList) {
                              //               package['service_list'] = List.from(
                              //                   CreateOfferController.to.yourServiceList
                              //                       .map((service) {
                              //                 return {
                              //                   "service_name": service['service_name'],
                              //                   "status":
                              //                       false // Each service starts as unselected for each package
                              //                 };
                              //               }).toList());
                              //             }
                              //             CreateOfferController.to.packageList.refresh();
                              //             CreateOfferController.to.serviceController.value
                              //                 .clear();
                              //             debugPrint(CreateOfferController.to.yourServiceList
                              //                 .toString());
                              //           } else {
                              //             showCustomSnackbar(
                              //                 title: 'Failed',
                              //                 message: "Please Enter valid service",
                              //                 type: SnackBarType.failed);
                              //           }
                              //         },
                              //         title: 'Add')
                              //   ],
                              // ),
                              // Obx(() {
                              //   return Wrap(
                              //     children: List.generate(
                              //       CreateOfferController.to.yourServiceList.length,
                              //       (index) => Container(
                              //         padding: const EdgeInsets.only(left: 8),
                              //         margin: const EdgeInsets.symmetric(
                              //             vertical: 8, horizontal: 4),
                              //         decoration: BoxDecoration(
                              //           color: AppColors.kprimaryColor,
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //         child: Row(
                              //           mainAxisSize: MainAxisSize.min,
                              //           children: [
                              //             Flexible(
                              //               child: Text(
                              //                 CreateOfferController.to.yourServiceList[index]
                              //                     ['service_name'],
                              //                 style: const TextStyle(color: Colors.white),
                              //               ),
                              //             ),
                              //             IconButton(
                              //                 onPressed: () {
                              //                   CreateOfferController.to.yourServiceList
                              //                       .removeAt(index);
                              //                   for (var element
                              //                       in CreateOfferController.to.packageList) {
                              //                     element['service_list'].removeAt(index);
                              //                   }
                              //                   CreateOfferController.to.packageList
                              //                       .refresh();
                              //                 },
                              //                 icon: const Icon(
                              //                   CupertinoIcons.multiply_circle,
                              //                   color: Colors.white,
                              //                 ))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   );
                              // }),
                              // defaultSizeBoxHeight,
                              const PackageCreateWidget(),
                              defaultSizeBoxHeight,
                              Row(
                                children: [
                                  Text(
                                    "district".tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: AppColors.kprimaryColor,
                                    ),
                                  ),
                                  spaceWidth6,
                                  const Text(
                                    '*',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: Colors.red),
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
                              CustomTextField(
                                label: "address".tr,
                                isRequired: true,
                                validatorText: "please_enter_address".tr,

                                hintText: "please_enter_address".tr,
                                controller: CreateOfferController
                                    .to.addressController.value,
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
                                        return CreateOfferController
                                                .to.isUploading.value
                                            ? Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      SizedBox(
                                                        height: 50,
                                                        width: 50,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: AppColors
                                                              .kprimaryColor,
                                                          strokeWidth: 6,
                                                        ),
                                                      ),
                                                      Text(
                                                        ' ${(CreateOfferController.to.uploadProgress.value * 100).toStringAsFixed(0)}%',
                                                        style:
                                                            AppTextStyle.titleText,
                                                      ),
                                                    ]),
                                              )
                                            : CreateOfferController
                                                    .to.isLoading.value
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                    color: AppColors.kprimaryColor,
                                                  ))
                                                : CustomButton(
                                                    title: widget.service != null
                                                        ? 'update_offer'.tr
                                                        : 'create_offer'.tr,
                                                    onTap: () async {
                                                      {
                                                        CreateOfferController.to
                                                            .isLoading.value = true;
                                                        if (CreateOfferController.to.selectedServiceType.value !=
                                                                null &&
                                                            CreateOfferController.to.selectedCategory.value !=
                                                                null &&
                                                            CreateOfferController
                                                                    .to
                                                                    .selectedDistrict
                                                                    .value !=
                                                                null &&
                                                            CreateOfferController
                                                                .to
                                                                .titleController
                                                                .value
                                                                .text
                                                                .isNotEmpty &&
                                                            CreateOfferController
                                                                .to
                                                                .descriptionController
                                                                .value
                                                                .text
                                                                .isNotEmpty &&
                                                            CreateOfferController
                                                                .to
                                                                .addressController
                                                                .value
                                                                .text
                                                                .isNotEmpty &&
                                                            CreateOfferController
                                                                .to
                                                                .packageList
                                                                .isNotEmpty &&
                                                            CreateOfferController.to
                                                                .packagePriceControllers
                                                                .map(
                                                                  (element) =>
                                                                      element.text,
                                                                )
                                                                .where(
                                                                  (element) => element
                                                                      .isNotEmpty,
                                                                )
                                                                .toList()
                                                                .isNotEmpty &&
                                                            CreateOfferController.to
                                                                .packageNameControllers
                                                                .map(
                                                                  (element) =>
                                                                      element.text,
                                                                )
                                                                .where(
                                                                  (element) => element
                                                                      .isNotEmpty,
                                                                )
                                                                .toList()
                                                                .isNotEmpty &&
                                                            CreateOfferController
                                                                .to.packageList
                                                                .map(
                                                                  (element) => element[
                                                                      'service_list'],
                                                                )
                                                                .where(
                                                                  (element) => element
                                                                      .isNotEmpty,
                                                                )
                                                                .toList()
                                                                .isNotEmpty &&
                                                            box.isNotEmpty) {
                                                          if (widget.service !=
                                                              null) {
                                                            await CreateOfferController.to.editOffer(
                                                                widget.service!.offerId ??
                                                                    '',
                                                                CreateOfferController
                                                                    .to
                                                                    .titleController
                                                                    .value
                                                                    .text,
                                                                CreateOfferController
                                                                    .to
                                                                    .descriptionController
                                                                    .value
                                                                    .text,
                                                                '',
                                                                CreateOfferController
                                                                    .to
                                                                    .addressController
                                                                    .value
                                                                    .text);

                                                            Get.back();

                                                            showCustomSnackbar(
                                                                title: 'Success',
                                                                message:
                                                                    "Updated Successfully",
                                                                type: SnackBarType
                                                                    .success);
                                                          } else {
                                                            String? downloadUrl;

                                                            if (CreateOfferController
                                                                    .to
                                                                    .image
                                                                    .value !=
                                                                null) {
                                                              downloadUrl = await CreateOfferController
                                                                  .to
                                                                  .uploadImage(DateTime
                                                                          .now()
                                                                      .microsecondsSinceEpoch
                                                                      .toString());
                                                              CreateOfferController
                                                                  .to
                                                                  .image
                                                                  .value = null;
                                                            } else {
                                                              String?
                                                                  categoryImgDownloadUrl =
                                                                  await ImageController()
                                                                      .fetchDefaultOfferImageUrl(
                                                                          CreateOfferController
                                                                              .to
                                                                              .selectedCategory
                                                                              .value
                                                                              .toString());
                                                              downloadUrl =
                                                                  categoryImgDownloadUrl;
                                                            }
                                                            await CreateOfferController.to.createOffer(
                                                                jobTitle:
                                                                    CreateOfferController
                                                                        .to
                                                                        .titleController
                                                                        .value
                                                                        .text,
                                                                description:
                                                                    CreateOfferController
                                                                        .to
                                                                        .descriptionController
                                                                        .value
                                                                        .text,
                                                                address:
                                                                    CreateOfferController
                                                                        .to
                                                                        .addressController
                                                                        .value
                                                                        .text,
                                                                imgUrl:
                                                                    downloadUrl ??
                                                                        '');

                                                            clearAllField();
                                                          }
                                                        } else {
                                                          showCustomSnackbar(
                                                            title: "Failed",
                                                            type:
                                                                SnackBarType.failed,
                                                            message:
                                                                "Please fill up required fields",
                                                          );
                                                        }
                                                        CreateOfferController
                                                            .to
                                                            .isLoading
                                                            .value = false;
                                                      }
                                                    },
                                                  );
                                      }),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                  ],
                );
              }
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
    for (var controller
        in CreateOfferController.to.packageDescriptionControllers) {
      controller.clear();
    }
    for (var controller in CreateOfferController.to.packageNameControllers) {
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

class RequiredTitleWidget extends StatelessWidget {
  final String name;
  const RequiredTitleWidget({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: AppColors.kprimaryColor,
          ),
        ),
        spaceWidth6,
        const Text(
          '*',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 10, color: Colors.red),
        )
      ],
    );
  }
}
