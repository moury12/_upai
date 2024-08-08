import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/widgets/category_item.dart';
import 'package:upai/widgets/custom_text_field.dart';

import 'controller/home_screen_controller.dart';

class CategoryListScreen extends StatefulWidget {
  static const String routeName = '/category-list';
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    Get.put(HomeController());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: AppColors.strokeColor2,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.strokeColor2,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Category List",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: Column(
        children: [    Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 12),
          child: CustomTextField(
            controller:HomeController.to.searchCatController.value ,
            onChanged: (value) {
              HomeController.to.filterCategory(value!);
            },
            onPressed: () {
              HomeController.to.searchCatController.value.clear();
              HomeController.to.filterCategory('');
            },
            hintText: "Search category..",
            suffixIcon: IconButton(icon: Icon(Icons.cancel,color: Colors.black,),onPressed: () {
              HomeController.to.searchCatController.value.clear();
            },),
          ),
        ),
          Obx(() {
            if(HomeController.to.filteredCategoryList.isNotEmpty){
            return Expanded(
              child: GridView.builder(
                itemCount:HomeController.to.filteredCategoryList.length ,
                gridDelegate:
                    SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200),
                itemBuilder: (context, index) {
                  return CategotyItem(
                    singleCat:
                    HomeController.to.filteredCategoryList[index],
                  );
                },
              ),
            );}
            else{
              return Center(child:Text('Category List empty...'));
            }
          }),
        ],
      ),
    );
  }
}
