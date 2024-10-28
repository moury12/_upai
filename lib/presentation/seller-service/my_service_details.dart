import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/my_date_util.dart';
import 'package:upai/helper_function/helper_function.dart';
 import 'package:upai/presentation/Service-details/service_details.dart';
import 'package:upai/presentation/create-offer/create_offer_screen.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';
import 'package:upai/widgets/custom_network_image.dart';

import '../create-offer/widget/tab_content_view.dart';

class MyServiceDetails extends StatelessWidget {
  // final MyService service;
  const MyServiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var seller = SellerProfileController.to.service.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        surfaceTintColor: Colors.white,
        title:  Text(
          'my_service_details'.tr,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: AppColors.colorWhite,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomNetworkImage(
              imgPreview: true,
              height: 250,
              imageUrl: seller.imgUrl ?? '',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    seller.jobTitle.toString().toUpperCase(),
                    style: AppTextStyle.bodyLarge700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Posted on ${MyDateUtil.formatDate(seller.dateTime ?? '')}"),
                        ],
                      ),

                      DetailItem(
                        title: "Category:",
                        body: seller.serviceCategoryType.toString(),
                      ),

                      DetailItem(
                        title: "District:",
                        body: " ${seller.district.toString()}",
                      ),
                      DetailItem(
                        title: "Address:",
                        body: seller.address.toString(),
                      ),

                      Text(
                        "Description",
                        style: AppTextStyle.bodyMediumBlackBold,
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      ReadMoreText(
                        seller.description.toString(),
                        style: AppTextStyle.bodySmallGrey400,
                        textAlign: TextAlign.start,
                        trimMode: TrimMode.Line,
                        trimLines: 5,
                        //colorClickableText: Colors.pink,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: ' Show less',
                        moreStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                        lessStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                      ),
                      // defaultSizeBoxHeight,
                      seller.package!.isNotEmpty
                          ? DefaultTabController(
                              length: seller.package!.length,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TabBar(
                                      indicatorColor: AppColors.kprimaryColor,
                                      labelColor: AppColors.kprimaryColor,
                                      overlayColor:
                                          WidgetStateColor.transparent,
                                      tabs: List.generate(
                                        seller.package!.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(seller.package![index]
                                                  .duration ??
                                              ''),
                                        ),
                                      )),
                                  defaultSizeBoxHeight,
                                  TabContentView(
                                      children: List.generate(
                                    seller.package!.length,
                                    (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        seller.package![index]
                                                .packageDescription!.isEmpty
                                            ? const SizedBox.shrink()
                                            : Text(
                                                "Description",
                                                style: AppTextStyle
                                                    .bodyMediumBlackBold,
                                              ),
                                        seller.package![index]
                                                .packageDescription!.isEmpty
                                            ? const SizedBox.shrink()
                                            : Text(
                                                seller.package![index]
                                                        .packageDescription ??
                                                    '',
                                                style: AppTextStyle
                                                    .bodySmallGrey400,
                                              ),
                                        seller.package![index]
                                                .packageDescription!.isEmpty
                                            ? const SizedBox.shrink()
                                            : defaultSizeBoxHeight,
                                        PackageDetails(
                                          title: "Price",
                                          lable:
                                              "৳ ${seller.package![index].price ?? ''}",
                                        ),
                                        // PackageDetails(
                                        //   title: "Duration",
                                        //   lable:
                                        //       "${seller.package![index].duration} Days",
                                        // ),
                                        // PackageDetails(
                                        //   title: "Revisions",
                                        //   lable: "4 Days",
                                        // ),
                                        // seller.package![index].serviceList!
                                        //         .isEmpty
                                        //     ? const SizedBox.shrink()
                                        //     : Column(
                                        //         children: List.generate(
                                        //           seller.package![index]
                                        //               .serviceList!.length,
                                        //           (serviceIndex) =>
                                        //               PackageDetails(
                                        //             title:
                                        //                 "${seller.package![index].serviceList![serviceIndex].serviceName}",
                                        //             ticMark: Icon(
                                        //               seller
                                        //                               .package![
                                        //                                   index]
                                        //                               .serviceList![
                                        //                                   serviceIndex]
                                        //                               .status!
                                        //                               .toLowerCase() ==
                                        //                           'true' ||
                                        //                       seller
                                        //                               .package![
                                        //                                   index]
                                        //                               .serviceList![
                                        //                                   serviceIndex]
                                        //                               .status!
                                        //                               .toLowerCase() ==
                                        //                           'yes'
                                        //                   ? CupertinoIcons
                                        //                       .checkmark
                                        //                   : CupertinoIcons
                                        //                       .clear,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(CreateOfferScreen.routeName, arguments: {
                      "service": SellerProfileController.to.service.value,
                      "isEdit": true,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColors.kprimaryColor,
                      foregroundColor: Colors.white),
                  child: const Text(
                    'Edit',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  )),
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppColors.strokeColor2,
                          title: const Icon(
                            CupertinoIcons.delete,
                            color: AppColors.cancelButtonColor,
                            size: 40,
                          ),
                          content: Text(
                            'Are you sure to delete this service?',
                            style: TextStyle(
                                fontSize: getResponsiveFontSize(context, 12),
                                fontWeight: FontWeight.w500),
                          ),
                          actions: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.cancelButtonColor,
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                  SellerProfileController.to.deleteOffer(
                                      SellerProfileController
                                              .to.service.value.offerId ??
                                          '');

                                  SellerProfileController.to.myService
                                      .refresh();
                                  deleteFavOffers(SellerProfileController
                                          .to.service.value.offerId ??
                                      '');
                                  HomeController.to.favOfferList.refresh();
                                  Get.back();
                                },
                                child: const Text('Yes')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.kprimaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'))
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColors.cancelButtonColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      foregroundColor: Colors.white),
                  child: const Text(
                    'Delete',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
