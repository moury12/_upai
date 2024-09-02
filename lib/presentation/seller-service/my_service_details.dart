import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/TestData/servicedItemData.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/create%20offer/create_offer_screen.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';
import 'package:upai/presentation/seller-service/widgets/my_service_widget.dart';

import '../../data/api/firebase_apis.dart';

class MyServiceDetails extends StatelessWidget {
  // final MyService service;
  const MyServiceDetails({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.strokeColor2,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () {
              Get.back();
            },
          ),
          surfaceTintColor: Colors.transparent,
          title: const Text(
            'My Service details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: AppColors.strokeColor2,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FutureBuilder(
                future: FirebaseAPIs.fetchOfferImageUrl(SellerProfileController.to.service.value.offerId.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Image.network(

                        height: 200,
                        width: double.infinity,
                        // height: double.infinity,
                        // width: double.infinity,
                        fit: BoxFit.cover,
                        snapshot.data.toString());
                  }
                  else {
                    return FutureBuilder(
                      future: FirebaseAPIs.fetchDefaultOfferImageUrl(SellerProfileController.to.service.value.serviceCategoryType.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if(snapshot.connectionState==ConnectionState.waiting || snapshot.connectionState==ConnectionState.none)
                            {
                              return Image.asset(
                                height: 200,
                                ImageConstant.dummy,
                                // height: double.infinity,
                                // fit: BoxFit.cover,
                              );
                            }
                          else
                            {
                              return Image.network(
                                  height: 200,

                                  // height: double.infinity,
                                  // width: double.infinity,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  snapshot.data.toString());
                            }

                        }
                        else {
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


                  // Image.asset(
                  //   ImageConstant.productImage,
                  //   height: 200,
                  // )),
              const SizedBox(
                height: 20,
              ),
              Container(
                // height: double.maxFinite,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(50),)),
                child: Obx(
                  () {
                    return Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SellerProfileController.to.service.value.jobTitle ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),

                        GridView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.5,
                                  crossAxisSpacing: 12),
                          shrinkWrap: true,
                          primary: false,
                          children: [
                            SellerStatusWidget(
                              title: 'Quantity',
                              color: Colors.deepPurpleAccent,
                              icon: CupertinoIcons.cart,
                              value: SellerProfileController.to.service.value.quantity.toString(),
                            ),
                            SellerStatusWidget(
                              title: 'Rate',
                              color: Colors.teal,
                              icon: Icons.monetization_on_sharp,
                              value: '${SellerProfileController.to.service.value.rate.toString()}৳',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Rate Type: ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${SellerProfileController.to.service.value.rateType}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Category Type: ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${SellerProfileController.to.service.value.serviceCategoryType}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Text(
                          'Description: ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${SellerProfileController.to.service.value.description}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 8,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(CreateOfferScreen(
                                      service: SellerProfileController.to.service.value,
                                      isEdit: true,
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white),
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontSize:
                                            14,
                                        fontWeight: FontWeight.w600),
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
                                          title: const Icon(
                                            CupertinoIcons.delete,
                                            size: 40,
                                          ),
                                          content: Text(
                                            'Are you sure to delete this service?',
                                            style: TextStyle(
                                                fontSize: getResponsiveFontSize(
                                                    context, 12),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.pink,
                                                    foregroundColor:
                                                        Colors.white),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                SellerProfileController.to.deleteOffer(SellerProfileController.to.service.value.offerId??'');

                                                SellerProfileController.to.myService.refresh();

                                                  Get.back();
                                                },
                                                child: const Text('Yes')),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black,
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 12),
                                                    foregroundColor:
                                                        Colors.white),
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

                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Colors.pink,padding:
                                  EdgeInsets.symmetric(vertical: 12),
                                      foregroundColor: Colors.white),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        fontSize:
                                            14,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    );
                  }
                ),
              )
            ],
          ),
        ));
  }
}
