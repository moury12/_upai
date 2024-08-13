import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/widgets/custom_text_field.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({super.key});

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  final box = Hive.box('userInfo');
  @override
  void initState() {
    Get.put(HomeController(), permanent: true);
    HomeController.to.getCategoryList();
    // TODO: implement initState
    super.initState();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  List<String> timeUnits = ['Hour', 'Task', 'Per Day'];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topSectionHeight = screenHeight * 0.3; // 20% for the top section
    double bottomSectionHeight = screenHeight * 0.7;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Create New Offer",
          style: AppTextStyle.appBarTitle,
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
            color: AppColors.strokeColor2,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(35))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Job Title",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                validatorText: "Please Enter Job Title",

                hintText: "Please Enter Job Title",
                controller: titleController,
                // onChanged: (value) => controller.emailController.text.trim() = value!,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Job Description",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                validatorText: "Please Enter Job Description",
                hintText: "Please Enter Job Description",
                controller: descriptionController,
                maxLines: 3,
                // onChanged: (value) => controller.emailController.text.trim() = value!,
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12)),
                child: Obx(() {
                  return DropdownButton<CategoryList>(
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
                    onChanged: (value) {
                      HomeController.to.selectedCategory.value = value!;
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12)),
                child: Obx(() {
                  return DropdownButton<String>(
                    underline: const SizedBox.shrink(),
                    value: HomeController.to.selectedTimeUnit.value,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    hint: const Text(
                      "Select a Rate type  ",
                    ),
                    items: ['Hour', 'Task', 'Per Day'].map((unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (value) {
                      HomeController.to.selectedTimeUnit.value = value;
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Rate",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.black),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {

                                    if (HomeController.to.quantityController
                                        .value.text.isEmpty) {
                                      HomeController.to.quantity.value = 0;
                                    }
                                    HomeController.to.decreaseQuantity();
                                  },
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                    textInputFormatter: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, /*FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9][0-9][0-9]?$')),*/
                                    ],
                                    validatorText: "Please Enter quantity",
                                    hintText: "Please Enter quantity",
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
                              Container(
                                margin: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (HomeController.to.quantityController
                                        .value.text.isEmpty) {
                                      HomeController.to.quantity.value = 0;
                                    }
                                    HomeController.to.increaseQuantity();
                                  },
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
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12)),
                          onPressed: () {
                            if (HomeController.to.selectedTimeUnit.value != null &&
                                HomeController.to.selectedCategory.value !=
                                    null &&
                                titleController.text.isNotEmpty &&
                                descriptionController.text.isNotEmpty &&
                                rateController.text.isNotEmpty &&
                                HomeController.to.quantityController.value.text
                                    .isNotEmpty &&
                                box.isNotEmpty) {
                              HomeController.to.createOffer(
                                  titleController.text,
                                  descriptionController.text,
                                  rateController.text);
                            } else {
                              Get.snackbar('Error', "All field Required");
                            }
                          },
                          child: const Text('Create Offer')),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
