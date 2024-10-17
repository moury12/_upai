// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:upai/Model/category_item_model.dart';
// import 'package:upai/Model/category_list_model.dart';
// import 'package:upai/TestData/category_data.dart';
// import 'package:upai/core/utils/app_colors.dart';
// import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';
//
// import '../../core/utils/custom_text_style.dart';
// import '../../widgets/category_item.dart';
//
// class ExploreScreen extends StatefulWidget {
//    ExploreScreen({super.key});
//
//   @override
//   State<ExploreScreen> createState() => _ExploreScreenState();
// }
//
// class _ExploreScreenState extends State<ExploreScreen> {
//   HomeController controller = Get.put(HomeController());
//
//   @override
//   Widget build(BuildContext context) {
//     CategoryListModel categoryItemModel = CategoryListModel();
//     var size = MediaQuery.sizeOf(context);
//     return Scaffold(
//       body:SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                   fillColor: AppColors.textFieldBackGround,
//                   filled: true,
//                   hintText: "Search service you're looking for...",
//                   hintStyle: TextStyle(fontSize: 14,color: Colors.grey.shade500),
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(6)
//
//                   )
//               ),
//             ),
//             const SizedBox(height: 20,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Browse Category",style: AppTextStyle.titleText),
//               Text("Browse All>",style: AppTextStyle.titleTextSmallUnderline),
//
//             ],
//           ),
//           const SizedBox(height: 10,),
//             Obx(
//                     () {
//                   return SizedBox(
//                       width: size.width,
//                       height: 200,
//                       child:HomeController.to.getCatList.isEmpty?const Center(child: CircularProgressIndicator()): ListView.builder(
//                         itemCount: HomeController.to.getCatList.length,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) {
//                           // categoryItemModel =
//                           //     CategoryListModel.fromJson(catList[index]);
//                           return
//                             CategotyItem(singleCat: HomeController.to.getCatList[index],);
//
//                         },)
//                   );
//                 }
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
