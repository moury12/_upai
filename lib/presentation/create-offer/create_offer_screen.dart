import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:upai/presentation/deafult_screen.dart';
import 'package:upai/presentation/default_controller.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
import 'package:upai/presentation/seller-service/seller_running_order_list_screen.dart';
import 'package:upai/widgets/custom_appbar.dart';
import 'package:upai/widgets/custom_button.dart';
import 'package:upai/widgets/custom_network_image.dart';
import 'package:upai/widgets/custom_text_field.dart';
import '../home/widgets/search_able_dropdown.dart';
import 'widget/custom_drop_down.dart';
import 'widget/package_create_widget.dart';

class CreateOfferScreen extends StatefulWidget {
  static const String routeName = '/create-offer';

  const CreateOfferScreen({
    super.key,
  });

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  final box = Hive.box('userInfo');

  // var serviceArgument =Get.arguments()['service'];
  bool isEditArgument = false;
  Map<String, dynamic>? arguments = Get.arguments;
  bool hasPackagePriceEmpty = CreateOfferController.to.packageList
      .any((element) => element['price'].isEmpty);
  bool hasPackageNameEmpty = CreateOfferController.to.packageList
      .any((element) => element['duration'].isEmpty);
  @override
  void initState() {
    if (arguments != null) {
      CreateOfferController.to.editOfferData(arguments!['service']);
      isEditArgument = arguments!['isEdit'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (CreateOfferController.to.nextProcess.value) {
          CreateOfferController.to.nextProcess.value = false;
          return false; // Prevent pop
        }
        // Allow pop if nextProcess is false
        CreateOfferController.to.image.value = null;
        return true; // Allow pop
      },
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
            title: isEditArgument ? 'edit_offer'.tr : "create_new_offer".tr/*,icon: IconButton(onPressed: () {
              print(CreateOfferController.to.packageList.toString());
            }, icon: Icon(Icons.add))*/,),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(35))),
          child: SingleChildScrollView(
            child: Obx(() {
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
                              controller: CreateOfferController
                                  .to.titleController.value,
                              // onChanged: (value) => controller.emailController.text.trim() = value!,
                            ),
                            sizeBoxHeight6,
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
                            sizeBoxHeight6,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "offer_image_optional".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: default12FontSize,
                                          color: AppColors.kPrimaryColor),
                                    ),
                                    sizeBoxHeight6,
                                    InkWell(
                                      onTap: () {
                                        CreateOfferController.to
                                            .showPickerDialog(context);
                                      },
                                      child: Obx(() {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: SizedBox(
                                              height: 120.w,
                                              width: 130.w,
                                              child: CreateOfferController
                                                          .to.image.value !=
                                                      null
                                                  ? Image.file(
                                                      File(CreateOfferController
                                                          .to
                                                          .image
                                                          .value!
                                                          .path),
                                                      //height: 150.w,
                                                      // width: 150.w,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : isEditArgument == true
                                                      ? const CustomNetworkImage(
                                                          imgPreview: true,
                                                          //height: 150.w,
                                                          imageUrl: '',
                                                        )
                                                      : Image.asset(
                                                          ImageConstant
                                                              .uploadImage,
                                                          color: Colors.grey,
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
                                            fontSize: default12FontSize,
                                            color: AppColors.kPrimaryColor,
                                          ),
                                        ),
                                        spaceWidth6,
                                        Text(
                                          '*',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: default10FontSize,
                                              color: Colors.red),
                                        )
                                      ],
                                    ),
                                    sizeBoxHeight6,
                                    Obx(() {
                                      return CustomDropDown<String>(
                                        label: "select_service_type".tr,
                                        isEditArgument: isEditArgument,
                                        menuList: serviceType,
                                        value: CreateOfferController
                                            .to.selectedServiceType.value,
                                        onChanged: (val) {
                                          CreateOfferController.to
                                              .selectedServiceType.value = val;
                                        },
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                            sizeBoxHeight6,
                            RequiredTitleWidget(
                              name: "category".tr,
                            ),
                            sizeBoxHeight6,
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
                            sizeBoxHeight6,
                            const RequiredTitleWidget(
                              name: "Package level",
                            ),
                            sizeBoxHeight6,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  return CustomDropDown<dynamic>(
                                    label: "select_a_package_level".tr,
                                    // isEditArgument: isEditArgument,
                                    menuList: CreateOfferController
                                        .to.packageLevelList,
                                    value: CreateOfferController
                                        .to.selectedLevel.value,
                                    onChanged: isEditArgument
                                        ? null
                                        : (value) {
                                            CreateOfferController
                                                .to.selectedLevel.value = value;
                                          },
                                  );
                                }),
                                defaultSizeBoxWidth,
                                Expanded(
                                  child: CustomButton(
                                    isLoading: CreateOfferController
                                        .to.isLoading.value,
                                    text: 'next'.tr,
                                    onTap: () {
                                      if (CreateOfferController.to
                                                  .selectedServiceType.value !=
                                              null &&
                                          CreateOfferController.to.selectedCategory
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
                                                  .to.selectedLevel.value !=
                                              null) {
                                        CreateOfferController
                                            .to.nextProcess.value = true;
                                        if (!isEditArgument) {
                                          CreateOfferController.to
                                              .initializeControllers(
                                                  CreateOfferController
                                                      .to.selectedLevel.value!);
                                          CreateOfferController.to
                                              .populatePackageList(
                                                  CreateOfferController
                                                          .to
                                                          .selectedLevel
                                                          .value ??
                                                      3);
                                        } else {
                                          CreateOfferController.to
                                              .populateControllers(
                                                  arguments!['service']);
                                        }
                                      } else {
                                        showCustomSnackbar(
                                          title: "Failed",
                                          type: SnackBarType.failed,
                                          message:
                                              "Please fill up required fields",
                                        );
                                      }
                                      // CreateOfferController.to.update();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            sizeBoxHeight6,
                            const PackageCreateWidget(),
                            sizeBoxHeight6,
                            Row(
                              children: [
                                Text(
                                  "district".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: default12FontSize,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                                spaceWidth6,
                                Text(
                                  '*',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: default10FontSize,
                                      color: Colors.red),
                                )
                              ],
                            ),
                            sizeBoxHeight6,
                            Obx(() {
                              if (HomeController.to.districtList.isEmpty) {
                                HomeController.to.districtList.refresh();

                                return CircularProgressIndicator(
                                  color: AppColors.kPrimaryColor,
                                );
                              } else {
                                return const SearchableDropDown(
                                  fromHome: false,
                                );
                              }
                            }),
                            sizeBoxHeight6,
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
                                  Expanded(child: Obx(() {
                                    return CustomButton(
                                      disableColor: AppColors.kPrimaryColor,
                                      isLoading: CreateOfferController
                                          .to.isLoading.value,
                                      text: isEditArgument
                                          ? 'update_offer'.tr
                                          : 'create_offer'.tr,
                                      onTap: () async {

                                        {
                                          // print(CreateOfferController.to.packageList
                                          //     .any((element) => element['price'].isEmpty).toString());
                                          if (CreateOfferController.to.selectedServiceType.value == null ||
                                              CreateOfferController.to.selectedCategory.value ==
                                                  null ||
                                              CreateOfferController.to.selectedDistrict.value ==
                                                  null ||
                                              CreateOfferController
                                                  .to
                                                  .titleController
                                                  .value
                                                  .text
                                                  .isEmpty ||
                                              CreateOfferController
                                                  .to
                                                  .descriptionController
                                                  .value
                                                  .text
                                                  .isEmpty ||
                                              CreateOfferController.to.selectedLevel.value ==
                                                  null ||
                                              CreateOfferController
                                                  .to
                                                  .addressController
                                                  .value
                                                  .text
                                                  .isEmpty ||
                                              CreateOfferController
                                                  .to.packageList.isEmpty ||
                                              CreateOfferController
                                                  .to.packageList
                                                  .any((element) =>
                                                      element['price']
                                                          .toString()
                                                          .isEmpty) ||
                                              CreateOfferController
                                                  .to.packageList
                                                  .any((element) =>
                                                      element['duration']
                                                          .isEmpty) ||
                                              box.isEmpty) {
                                            showCustomSnackbar(
                                              title: "Failed",
                                              type: SnackBarType.failed,
                                              message:
                                                  "Please fill up required fields",
                                            );
                                          } else {
                                        String? downloadUrl;

                                        if (CreateOfferController
                                            .to.image.value !=
                                        null) {
                                        downloadUrl =
                                        await CreateOfferController
                                            .to
                                            .uploadImage(DateTime
                                            .now()
                                            .microsecondsSinceEpoch
                                            .toString());
                                        print(downloadUrl);
                                        CreateOfferController
                                            .to.image.value = null;
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
                                              if (isEditArgument==true) {
                                                await CreateOfferController.to
                                                    .editOffer(
                                                        arguments![
                                                                    'service']!
                                                                .offerId ??
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
                                                            .text,downloadUrl);
                                                final ctrl = Get.put(DefaultController());
                                                ctrl.selectedIndex.value=1;
                                                Get.off(DefaultScreen());

                                                showCustomSnackbar(
                                                    title: 'Success',
                                                    message:
                                                        "Updated Successfully",
                                                    type: SnackBarType.success);
                                              } else {

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
                                                    imgUrl: downloadUrl ?? '');

                                                clearAllField();
                                              }
                                            }
                                          }
                                        }

                                    );
                                  })),
                                ],
                              ),
                            )
                          ],
                        )
                ],
              );
            }),
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
    CreateOfferController.to.selectedLevel.value = null;
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
            fontSize: default12FontSize,
            color: AppColors.kPrimaryColor,
          ),
        ),
        spaceWidth6,
        Text(
          '*',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: default10FontSize,
              color: Colors.red),
        )
      ],
    );
  }
}
