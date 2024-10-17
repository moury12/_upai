import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/core/utils/my_date_util.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';
import 'package:upai/presentation/create%20offer/create_offer_screen.dart';
import 'package:upai/presentation/create%20offer/widget/tab_content_view.dart';
import 'package:upai/presentation/full_screen_image.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';

import '../../data/api/firebase_apis.dart';
import '../ServiceDetails/service_details.dart';

class MyServiceDetails extends StatelessWidget {
  // final MyService service;
  const MyServiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    String image =
        "https://lh5.googleusercontent.com/proxy/t08n2HuxPfw8OpbutGWjekHAgxfPFv-pZZ5_-uTfhEGK8B5Lp-VN4VjrdxKtr8acgJA93S14m9NdELzjafFfy13b68pQ7zzDiAmn4Xg8LvsTw1jogn_7wStYeOx7ojx5h63Gliw";
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
        title: const Text(
          'My Service details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: AppColors.colorWhite,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Obx(() {
              return GestureDetector(
                onTap: () {
                  Get.to(FullScreenImage(imageUrl: image));
                },
                child: FutureBuilder(
                  future: FirebaseAPIs.fetchOfferImageUrl(
                      SellerProfileController.to.service.value.offerId
                          .toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.none) {
                      return Image.asset(
                        height: 200,
                        ImageConstant.dummy,
                        // height: double.infinity,
                        // fit: BoxFit.cover,
                      );
                    } else if (snapshot.hasData) {
                      image = snapshot.data.toString();
                      return Image.network(
                        height: 200,
                        width: double.infinity,
                        // height: double.infinity,
                        // width: double.infinity,
                        fit: BoxFit.cover,
                        snapshot.data.toString(),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child; // Image has finished loading
                          }
                          return SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.kprimaryColor,
                                // value: loadingProgress.expectedTotalBytes != null
                                //     ? loadingProgress.cumulativeBytesLoaded /
                                //     (loadingProgress.expectedTotalBytes ?? 1)
                                //     : null,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return FutureBuilder(
                        future: FirebaseAPIs.fetchDefaultOfferImageUrl(
                            SellerProfileController
                                .to.service.value.serviceCategoryType
                                .toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.connectionState ==
                                  ConnectionState.none) {
                            return Image.asset(
                              height: 200,
                              ImageConstant.dummy,
                              // height: double.infinity,
                              // fit: BoxFit.cover,
                            );
                          } else if (snapshot.hasData) {
                            image = snapshot.data.toString();
                            return Image.network(
                              height: 200,
                              // height: double.infinity,
                              // width: double.infinity,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              snapshot.data.toString(),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Image has finished loading
                                }
                                return SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.kprimaryColor,
                                      // value: loadingProgress.expectedTotalBytes != null
                                      //     ? loadingProgress.cumulativeBytesLoaded /
                                      //     (loadingProgress.expectedTotalBytes ?? 1)
                                      //     : null,
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Image.asset(
                              height: 200,
                              ImageConstant.dummy,
                              // height: double.infinity,
                              // width: double.infinity,
                              // fit: BoxFit.cover,
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              );
            }),

            // Image.asset(
            //   ImageConstant.productImage,
            //   height: 200,
            // )),

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
                        body: "${seller.address.toString()}",
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
                                                  .packageName ??
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
                                            ? SizedBox.shrink()
                                            : Text(
                                                "Description",
                                                style: AppTextStyle
                                                    .bodyMediumBlackBold,
                                              ),
                                        seller.package![index]
                                                .packageDescription!.isEmpty
                                            ? SizedBox.shrink()
                                            : Text(
                                                seller.package![index]
                                                        .packageDescription ??
                                                    '',
                                                style: AppTextStyle
                                                    .bodySmallGrey400,
                                              ),
                                        seller.package![index]
                                                .packageDescription!.isEmpty
                                            ? SizedBox.shrink()
                                            : defaultSizeBoxHeight,
                                        PackageDetails(
                                          title: "Price",
                                          lable:
                                              "৳ ${seller.package![index].price ?? ''}",
                                        ),
                                        PackageDetails(
                                          title: "Duration",
                                          lable:
                                              "${seller.package![index].duration} Days",
                                        ),
                                        // PackageDetails(
                                        //   title: "Revisions",
                                        //   lable: "4 Days",
                                        // ),
                                        seller.package![index].serviceList!
                                                .isEmpty
                                            ? SizedBox.shrink()
                                            : Column(
                                                children: List.generate(
                                                  seller.package![index]
                                                      .serviceList!.length,
                                                  (serviceIndex) =>
                                                      PackageDetails(
                                                    title:
                                                        "${seller.package![index].serviceList![serviceIndex].serviceName}",
                                                    ticMark: Icon(
                                                      seller
                                                                      .package![
                                                                          index]
                                                                      .serviceList![
                                                                          serviceIndex]
                                                                      .status!
                                                                      .toLowerCase() ==
                                                                  'true' ||
                                                              seller
                                                                      .package![
                                                                          index]
                                                                      .serviceList![
                                                                          serviceIndex]
                                                                      .status!
                                                                      .toLowerCase() ==
                                                                  'yes'
                                                          ? CupertinoIcons
                                                              .checkmark
                                                          : CupertinoIcons
                                                              .clear,
                                                    ),
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {

                    Get.toNamed(CreateOfferScreen.routeName,arguments: {
                      "service": SellerProfileController.to.service.value,
                      "isEdit": true,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColors.kprimaryColor,
                      foregroundColor: Colors.white),
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  )),
            ),
            SizedBox(
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
                          title: Icon(
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
                                    padding: EdgeInsets.symmetric(vertical: 12),
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
                      padding: EdgeInsets.symmetric(vertical: 12),
                      foregroundColor: Colors.white),
                  child: Text(
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
