// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'package:get/get.dart';
// import 'package:upai/controllers/order_controller.dart';
//
// import 'package:upai/core/utils/app_colors.dart';
// import 'package:upai/data/api/firebase_apis.dart';
//
//  // import 'package:upai/presentation/Profile/profile_screen_controller.dart';
// import 'package:upai/presentation/ServiceDetails/service_details.dart';
// import 'package:upai/widgets/custom_text_field.dart';
//
// import '../../../Model/user_info_model.dart';
//
// class ConfirmOfferRequestWidget extends StatefulWidget {
//   final ServiceDetails service;
//   const ConfirmOfferRequestWidget({
//     super.key,
//     required this.service,
//   });
//
//   @override
//   State<ConfirmOfferRequestWidget> createState() => _ConfirmOfferRequestWidgetState();
// }
//
// class _ConfirmOfferRequestWidgetState extends State<ConfirmOfferRequestWidget> {
//   ProfileScreenController? ctrl;
//   @override
//   void initState() {
//     ctrl = Get.put(ProfileScreenController());
//
//     HomeController.to.quantityControllerForConfromOrder.value.text = widget.service.offerDetails!.quantity.toString();
//     HomeController.to.quantityForConform.value = widget.service.offerDetails!.quantity!.toInt();
//     HomeController.to.rateController.value.text = widget.service.offerDetails!.rate.toString();
//     HomeController.to.selectedRateType.value = widget.service.offerDetails!.rateType!.toLowerCase();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint(widget.service.offerDetails!.rateType);
//     final List<String> rateTypes = ['hour', 'task', 'per day', 'piece', 'package'];
//
//     return PopScope(
//       onPopInvoked: (didPop) {
//         // HomeController.to.selectedRateType.value = null;
//         // HomeController.to.change.value = false;
//         // HomeController.to.changeQuantity.value = false;
//         // HomeController.to.rateController.value.text =
//         //     widget.offerDetails!.rate.toString();
//         // HomeController.to.quantityControllerForConfromOrder.value.text =
//         //     widget.offerDetails!.quantity.toString();
//         // HomeController.to.changeQuantity.value = false;
//         // HomeController.to.quantity.value =
//         //     widget.offerDetails!.quantity!.toInt();
//       },
//       child: AlertDialog( shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
    ),
//         scrollable: true,
//         backgroundColor: AppColors.strokeColor2,
//         titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//         title: ctrl!.userInfo.value.userId == widget.service.offerDetails!.userId
//             ? null
//             : const Text(
//                 'Request Confirm Offer',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//         content: ctrl!.userInfo.value.userId == widget.service.offerDetails!.userId
//             ? const Padding(
//                 padding: EdgeInsets.all(12),
//                 child: Center(
//                   child: Text('This is your own service'),
//                 ),
//               )
//             : Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Divider(
//                     height: 1,
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   OfferDialogWidget(
//                     label: 'Category:',
//                     text: widget.service.offerDetails!.serviceCategoryType ?? 'No category',
//                   ),
//                   OfferDialogWidget(
//                     label: 'Job Title:',
//                     text: widget.service.offerDetails!.jobTitle ?? 'No category',
//                   ),
//                   OfferDialogWidget(
//                     label: 'Job Description:',
//                     text: widget.service.offerDetails!.description ?? 'No category',
//                   ),
//                   const Divider(
//                     height: 12,
//                   ),
//                   const Text(
//                     'Rate type',
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                   ),
//                   Container(
//                    // padding: const EdgeInsets.symmetric(horizontal: 12),
//                     margin: const EdgeInsets.all(12),
//                    // decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(12)),
//                     child: Obx(() {
//                       if (rateTypes.contains(widget.service.offerDetails!.rateType!.toLowerCase()) && !HomeController.to.change.value) {
//                         HomeController.to.selectedRateType.value = widget.service.offerDetails!.rateType!.toLowerCase();
//                       }
//                       debugPrint('selectedRateType ${HomeController.to.selectedRateType.value}');
//                       debugPrint(HomeController.to.change.value.toString());
//
//                       return CustomTextField(
//                         isEnable: false,
//                         textAlign: TextAlign.center,
//                         inputType: TextInputType.number,
//                         controller: TextEditingController()..text=HomeController.to.selectedRateType.value.toString(),
//                         inputFontSize: 12,
//                         // onChanged: (value) => controller.emailController.text.trim() = value!,
//                       );
//                     }),
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           children: [
//                             const Text(
//                               'Rate',
//                               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
//                             ),
//                             Obx(() {
//                               // HomeController.to.rateController.value.text =
//                               //     widget.offerDetails!.rate.toString();
//
//                               return CustomTextField(
//                                 isEnable: false,
//                                 validatorText: "Please Enter Rate",
//                                 textAlign: TextAlign.center,
//                                 hintText: "Please Enter Rate",
//                                 inputType: TextInputType.number,
//                                 controller: HomeController.to.rateController.value,
//                                 inputFontSize: 12,
//                                 onChanged: (value) {},
//                                 // onChanged: (value) => controller.emailController.text.trim() = value!,
//                               );
//                             }),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 6,
//                       ),
//                       Expanded(
//                         child: Obx(() {
//                           // if (HomeController.to.quantityControllerForConfromOrder
//                           //         .value.text.isEmpty &&
//                           //     !HomeController.to.changeQuantity.value) {
//                           //   HomeController.to.quantityControllerForConfromOrder.value
//                           //       .text = widget.offerDetails!.quantity.toString();
//                           // }
//                           return Column(
//                             children: [
//                               Text(
//                                 'quantity',
//                                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Expanded(
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         if (HomeController.to.quantityControllerForConfromOrder.value.text.isEmpty) {
//                                           HomeController.to.quantityForConform.value = 0;
//                                         }
//                                         HomeController.to.decreaseQuantityForConfrom();
//                                       },
//                                       child: FittedBox(
//                                         child: Container(
//                                             margin: const EdgeInsets.all(8),
//                                             padding: const EdgeInsets.all(8),
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: AppColors.kprimaryColor,
//                                             ),
//                                             child: Icon(
//                                               Icons.remove,
//                                               color: Colors.white,
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: CustomTextField(
//                                         padding: EdgeInsets.zero,
//                                         validatorText: "Please Enter quantity",
//                                         hintText: "Please Enter quantity",
//                                         textAlign: TextAlign.center,
//                                         textInputFormatter: [
//                                           FilteringTextInputFormatter.digitsOnly, /*FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9][0-9][0-9]?$')),*/
//                                         ],
//                                         inputType: TextInputType.number,
//                                         inputFontSize: 12,
//                                         controller: HomeController.to.quantityControllerForConfromOrder.value,
//                                         onChanged: (value) {
//                                           int? newValue = int.tryParse(value!);
//                                           if (newValue != null && newValue > 0) {
//                                             HomeController.to.quantity.value = newValue;
//                                           }
//                                         }
//                                         // onChanged: (value) => controller.emailController.text.trim() = value!,
//                                         ),
//                                   ),
//                                   Expanded(
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         if (HomeController.to.quantityControllerForConfromOrder.value.text.isEmpty) {
//                                           HomeController.to.quantityForConform.value = 0;
//                                         }
//                                         HomeController.to.increaseQuantityForConfrom();
//                                       },
//                                       child: FittedBox(
//                                         child: Container(
//                                             margin: const EdgeInsets.all(8),
//                                             padding: const EdgeInsets.all(8),
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: AppColors.kprimaryColor,
//                                             ),
//                                             child: Icon(
//                                               Icons.add,
//                                               color: Colors.white,
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           );
//                         }),
//                       ),
//                     ],
//                   ),
//                   const Divider(
//                     height: 16,
//                   ),
//                   Obx(() {
//                     return Text(
//                       textAlign: TextAlign.center,
//                       'Total amount: ${HomeController.to.totalAmount.value} ৳',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
//                     );
//                   }),
//                   SizedBox(
//                     height: 10,
//                   ),

//                   const SizedBox(
//                     height: 16,
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }
