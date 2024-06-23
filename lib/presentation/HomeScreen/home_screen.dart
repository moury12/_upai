import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/widgets/category_item.dart';
import 'package:upai/widgets/chat_item_widget.dart';
import 'package:upai/widgets/custom_bottom_navbar.dart';
import 'package:upai/widgets/item_service.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return  Scaffold(

backgroundColor: Colors.white,
        body:SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

               Container(
                 color:   const Color(0xffF2F2F2),
                 child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                   child: Column(
                     children: [
                       const SizedBox(height: 20,),
                       TextField(
                         decoration: InputDecoration(
                             fillColor: Colors.white,
                             filled: true,
                             hintText: "Search service you're looking for...",
                             hintStyle: TextStyle(fontSize: 14,color: Colors.grey.shade500),
                             border: OutlineInputBorder(
                                 borderSide: BorderSide.none,
                                 borderRadius: BorderRadius.circular(8)
            
                             )
                         ),
                       ),
                       const SizedBox(height: 20,),
                       Container(
                         width: size.width,
                         height: 40,
                         clipBehavior: Clip.antiAlias,
                         decoration: ShapeDecoration(
                           color: AppColors.BTNbackgroudgrey,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                         ),
                         child: const Row(
                           mainAxisSize: MainAxisSize.min,
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text(
                               'Search Service',
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 11,
                                 fontFamily: 'Inter',
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                           ],
                         ),
                       ),
                       const SizedBox(height: 10,),
                     ],
                   ),
                 ),
               ),
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Browse Category",style: AppTextStyle.titleText),
                        Text("Browse All>",
          
                            style: AppTextStyle.titleTextSmall),
            
                      ],
                    ),
                    SizedBox(height: 10,),
          
                    Container(
                      width: size.width,
                      height: 100,
                      child: ListView.builder(
                        itemCount: 7,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategotyItem();
          
                        },),
                    ),
                    const SizedBox(height: 10,),
                    Text("Explore Top Services",style: AppTextStyle.titleText),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: size.width,
                      height: 180,
                      child:ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                        return ItemService();
                      },),
                    ),

          
                  ],
                ),
              ),
          
              ],
            ),
          ),
        ),
    );
  }
}
