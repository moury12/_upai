import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/widgets/cat_two.dart';
import 'package:upai/widgets/category_item.dart';
import 'package:upai/widgets/custom_text_field.dart';

import '../../core/utils/custom_text_style.dart';
import 'controller/home_screen_controller.dart';
import 'widgets/shimmer_for_home.dart';

class CategoryListScreen extends StatefulWidget {
  static const String routeName = '/category-list';
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        HomeController.to.searchCatController.value.clear();
        HomeController.to.filterCategory('');
      },
      child: Scaffold(
        backgroundColor: AppColors.strokeColor2,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
              HomeController.to.searchCatController.value.clear();
              HomeController.to.filterCategory('');
            },
          ),
          title: Text(
            "Category List",
            style: AppTextStyle.bodyTitle700,
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 12),
              child: CustomTextField(
                controller: HomeController.to.searchCatController.value,
                onChanged: (value) {
                  HomeController.to.filterCategory(value!);
                },
                onPressed: () {
                  HomeController.to.searchCatController.value.clear();
                  HomeController.to.filterCategory('');
                },
                hintText: "Search category..",
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: AppColors.kprimaryColor,
                  ),
                  onPressed: () {
                    HomeController.to.searchCatController.value.clear();
                    HomeController.to.filterCategory('');
                  },
                ),
              ),
            ),
            Obx(() {
              if (HomeController.to.filteredCategoryList.isNotEmpty) {
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12).copyWith(top: 0, right: 4),
                    itemCount: HomeController.to.filteredCategoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return CategotyItemtwo(
                        singleCat: HomeController.to.filteredCategoryList[index],
                        maxline: 5,
                      );
                    },
                  ),
                );
              } else {
                return Expanded(child: ShimmerCategoryDetailsList());
              }
            }),
          ],
        ),
      ),
    );
  }
}
