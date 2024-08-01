import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/widgets/category_item.dart';
import 'package:upai/widgets/custom_text_field.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({super.key});

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  @override
  void initState() {
    Get.put(HomeController());
    HomeController.to.getCategoryList();
    // TODO: implement initState
    super.initState();
  }

  List<String> timeUnits = ['Hour', 'Task', 'Per Day'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.strokeColor2,
      appBar: AppBar(
        title: Text("Create New Offer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (HomeController.to.getCatList.isEmpty) {
                return CircularProgressIndicator();
              } else {
                return DropdownButton<CategoryList>(
                  value: HomeController.to.selectedCategory.value,
                  hint: Text("Select a category"),
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
              }
            }),
            Obx(() {
              return DropdownButton<String>(
                value: HomeController.to.selectedTimeUnit.value,
                hint: Text("Select a time unit"),
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
            Text("Job Title"),
            CustomTextField(
              validatorText: "Please Enter Job Title",
              prefixIcon: Icons.lock,
              hintText: "Job Title",
              // onChanged: (value) => controller.emailController.text.trim() = value!,
            ),
            Text("Job Description"),
            CustomTextField(
              validatorText: "Please Enter Job Description",
              prefixIcon: Icons.description,
              hintText: "Job Description",

              // onChanged: (value) => controller.emailController.text.trim() = value!,
            ),
            Text("Rate"),
            CustomTextField(
              validatorText: "Please Enter Rate",
              prefixIcon: Icons.rate_review_outlined,
              hintText: "Rate",

              // onChanged: (value) => controller.emailController.text.trim() = value!,
            ),
      Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                HomeController.to.decreaseQuantity();
              },
            ),
            Text(
              '${HomeController.to.quantity.value}',
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                HomeController.to.increaseQuantity();
              },
            ),
          ],
        );
      })
          ],
        ),
      ),
    );
  }
}
