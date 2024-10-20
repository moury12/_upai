import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';
import 'package:upai/presentation/create-offer/controller/create_offer_controller.dart';
import 'package:upai/presentation/create-offer/widget/tab_content_view.dart';
import 'package:upai/widgets/custom_text_field.dart';

class PackageCreateWidget extends StatelessWidget {
  const PackageCreateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: AppColors.kprimaryColor, width: 1.5)),
      child: DefaultTabController(
        length: CreateOfferController.to.packageList.length,
        child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CreateOfferController.to.packageList.isEmpty
                  ? const SizedBox.shrink()
                  : TabBar(
                overlayColor: WidgetStateColor.transparent,
                onTap: (value) {
                  // HomeController.to.selectPackage(value);
                  HomeController.to.update();
                  debugPrint(CreateOfferController
                      .to.packageList
                      .toString());
                },
                tabs: [
                  ...List.generate(
                    CreateOfferController
                        .to.packageList.length,
                        (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          CreateOfferController
                              .to.packageList[index]
                          ['package_name'],
                        ),
                      ),
                    ),
                  ),
                ],
                indicatorColor: AppColors.kprimaryColor,
                labelColor: AppColors.kprimaryColor,
              ),
              TabContentView(
                children: CreateOfferController
                    .to.packageList.isNotEmpty
                    ? List.generate(
                  CreateOfferController.to.packageList.length,
                      (index) => SingleChildScrollView(
                    child: Column(
                      children: [
                        defaultSizeBoxHeight,
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                      fontWeight:
                                      FontWeight.w700,
                                      fontSize: 12,
                                      color: AppColors
                                          .kprimaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    validatorText:
                                    "Please Enter Price",
                                    hintText:
                                    "Please Enter Price",
                                    inputType:
                                    TextInputType.number,
                                    controller:
                                    CreateOfferController
                                        .to
                                        .packagePriceControllers[
                                    index],
                                    onChanged: (value) {
                                      CreateOfferController.to
                                          .packageList[index]
                                      ['price'] = value;
                                      CreateOfferController
                                          .to.packageList
                                          .refresh();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            defaultSizeBoxWidth,
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Duration",
                                    style: TextStyle(
                                      fontWeight:
                                      FontWeight.w700,
                                      fontSize: 12,
                                      color: AppColors
                                          .kprimaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    validatorText:
                                    "Please Enter Duration",
                                    hintText:
                                    "Please Enter Duration",
                                    inputType:
                                    TextInputType.number,
                                    onChanged: (value) {
                                      CreateOfferController.to
                                          .packageList[index]
                                      [
                                      'duration'] = value;
                                      CreateOfferController
                                          .to.packageList
                                          .refresh();
                                    },
                                    controller:
                                    CreateOfferController
                                        .to
                                        .packageDurationControllers[
                                    index],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            defaultSizeBoxHeight,
                            Text(
                              "Package Description",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color:
                                AppColors.kprimaryColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              validatorText:
                              "Please Enter Description",
                              hintText:
                              "Please Enter Description",
                              maxLines: 3,
                              onChanged: (value) {
                                CreateOfferController.to
                                    .packageList[index][
                                'package_description'] =
                                    value;
                                CreateOfferController
                                    .to.packageList
                                    .refresh();
                              },
                              controller: CreateOfferController
                                  .to
                                  .packageDescriptionControllers[
                              index],
                            ),
                          ],
                        ),
                        CreateOfferController
                            .to
                            .packageList[index]
                        ['service_list']
                            .isEmpty
                            ? const SizedBox.shrink()
                            : Column(
                          children: List.generate(
                            CreateOfferController
                                .to
                                .packageList[index]
                            ['service_list']
                                .length,
                                (serviceIndex) {
                              // data[index]={serviceIndex:CreateOfferController.to.packageList[index]['service_list'][serviceIndex]['selected']};
                              //
                              // print('YYYYYYYYYYYYYYY');
                              // print(data);
                              return Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      CreateOfferController
                                          .to
                                          .packageList[index]['service_list']
                                      [
                                      serviceIndex]
                                      [
                                      'service_name'] ??
                                          '',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight
                                              .w600),
                                    ),
                                  ),
                                  Checkbox(
                                    activeColor: AppColors
                                        .kprimaryColor,
                                    value: CreateOfferController
                                        .to
                                        .packageList[
                                    index][
                                    'service_list']
                                    [
                                    serviceIndex]['status'],
                                    //value: data[serviceIndex],
                                    onChanged: (value) {
                                      debugPrint(
                                          CreateOfferController
                                              .to
                                              .packageList
                                              .toString());
                                      debugPrint(
                                          serviceIndex
                                              .toString());
                                      // Update the selected value for the specific service in the package
                                      CreateOfferController
                                          .to
                                          .packageList[index]['service_list']
                                      [
                                      serviceIndex]
                                      [
                                      'status'] =
                                          value ??
                                              false;

                                      // Refresh the package list to notify the UI of changes
                                      CreateOfferController
                                          .to
                                          .packageList
                                          .refresh();
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
                    : [
                  const Center(
                      child: Text('No Packages Available'))
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}