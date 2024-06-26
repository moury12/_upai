import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';

import '../../core/utils/custom_text_style.dart';
import '../../widgets/category_item.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  fillColor: AppColors.textFieldBackGround,
                  filled: true,
                  hintText: "Search service you're looking for...",
                  hintStyle: TextStyle(fontSize: 14,color: Colors.grey.shade500),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(6)

                  )
              ),
            ),
            const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Browse Category",style: AppTextStyle.titleText),
              Text("Browse All>",style: AppTextStyle.titleTextSmallUnderline),
        
            ],
          ),
          const SizedBox(height: 10,),
        
          SizedBox(
            width: size.width,
            height: 100,
            child: ListView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategotyItem();
        
              },),
          ),]),),
      ),
    );
  }
}
