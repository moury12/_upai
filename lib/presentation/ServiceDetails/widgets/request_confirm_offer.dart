import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:upai/core/utils/app_colors.dart';

import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/ServiceDetails/service_details.dart';
import 'package:upai/widgets/custom_text_field.dart';

class ConfrimOfferWidget extends StatelessWidget {
  ConfrimOfferWidget({
    super.key,
    required this.widget,
    required this.rateController,
  });

  final ServiceDetails widget;
  final TextEditingController rateController;

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.offerDetails.rateType);
    final List<String> rateTypes = ['hour', 'task', 'per Day', 'piece'];

    return PopScope(
      onPopInvoked: (didPop) {
        HomeController.to.selectedTimeUnit.value = null;
        HomeController.to.change.value = false;
        HomeController.to.changeQuantity.value = false;
        rateController.text = widget.offerDetails.rate.toString();
        HomeController.to.quantityControllerForConfromOrder.value.clear();
        HomeController.to.changeQuantity.value =false;
        HomeController.to.quantity.value=widget.offerDetails.quantity!.toInt();
      },
      child: AlertDialog(
        scrollable: true,
        backgroundColor: AppColors.strokeColor2,
        titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: const Text(
          'Request Confirm Offer',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              height: 1,
            ),
            const SizedBox(
              height: 12,
            ),
            OfferDialogWidget(
              label: 'Category:',
              text: widget.offerDetails.serviceCategoryType ?? 'No category',
            ),
            OfferDialogWidget(
              label: 'Job Title:',
              text: widget.offerDetails.jobTitle ?? 'No category',
            ),
            OfferDialogWidget(
              label: 'Job Description:',
              text: widget.offerDetails.description ?? 'No category',
            ),
            const Divider(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12)),
              child: Obx(() {
                if (rateTypes.contains(widget.offerDetails.rateType) &&
                    !HomeController.to.change.value) {
                  HomeController.to.selectedTimeUnit.value =
                      widget.offerDetails.rateType;
                }
                debugPrint(HomeController.to.selectedTimeUnit.value);
                debugPrint(HomeController.to.change.value.toString());
                return DropdownButton<String>(
                  underline: const SizedBox.shrink(),
                  value: HomeController.to.selectedTimeUnit.value,
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  hint: const Text(
                    "Select a Rate type  ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  items: rateTypes.map((unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(
                        unit,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    HomeController.to.change.value = true;
                    HomeController.to.selectedTimeUnit.value = null;
                    HomeController.to.selectedTimeUnit.value = value;
                  },
                );
              }),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    validatorText: "Please Enter Rate",
                    hintText: "Please Enter Rate",
                    inputType: TextInputType.number,
                    controller: rateController,
                    inputFontSize: 12,

                    // onChanged: (value) => controller.emailController.text.trim() = value!,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Obx(() {
                    if(HomeController.to.quantityControllerForConfromOrder.value.text.isEmpty&&!HomeController.to.changeQuantity.value){
                      HomeController.to.quantityControllerForConfromOrder.value.text =widget.offerDetails.quantity.toString();
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (HomeController
                                .to.quantityControllerForConfromOrder.value.text.isEmpty) {
                              HomeController.to.quantity.value = 0;
                            }
                            HomeController.to.decreaseQuantity();
                          },
                          child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              )),
                        ),
                        Expanded(
                          child: CustomTextField(
                              validatorText: "Please Enter quantity",
                              hintText: "Please Enter quantity",
                              textAlign: TextAlign.center,
                              inputType: TextInputType.number,
                              inputFontSize: 12,
                              controller:
                                  HomeController.to.quantityControllerForConfromOrder.value,
                              onChanged: (value) {
                                int? newValue = int.tryParse(value!);
                                if (newValue != null && newValue > 0) {
                                  HomeController.to.quantity.value = newValue;
                                }
                              }
                              // onChanged: (value) => controller.emailController.text.trim() = value!,
                              ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (HomeController
                                .to.quantityControllerForConfromOrder.value.text.isEmpty) {
                              HomeController.to.quantity.value = 0;
                            }
                            HomeController.to.increaseQuantity();
                          },
                          child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
            const Divider(
              height: 16,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                  HomeController.to.changeQuantity.value = false;
                  HomeController.to.quantityControllerForConfromOrder.value.clear();
                  HomeController.to.changeQuantity.value =false;
                  HomeController.to.quantity.value=widget.offerDetails.quantity!.toInt();
                  HomeController.to.selectedTimeUnit.value = null;
                  HomeController.to.change.value = false;
                  rateController.text = widget.offerDetails.rate.toString();
                },
                child: const Text("Confirm Order")),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
