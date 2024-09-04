import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';

import 'package:upai/core/utils/image_path.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/helper_function/helper_function.dart';

class MyServiceWidget extends StatelessWidget {
  final MyService? service;
  final OfferList? offerItem;
  final Widget? button;
  const MyServiceWidget({super.key, this.service, this.offerItem, this.button});

  @override
  Widget build(BuildContext context) {
    // Determine if we're using service or offerList
    bool isService = service != null;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          // width: 200,
          padding: const EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [BoxShadow(color: AppColors.kprimaryColor.withOpacity(0.3), spreadRadius: 2, blurRadius: 2)],
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 4,
                  child: FutureBuilder(
                    future: FirebaseAPIs.fetchOfferImageUrl(isService ? service!.offerId.toString() : offerItem!.offerId.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting && snapshot.connectionState == ConnectionState.none) {
                        return Image.asset(
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.none,
                          ImageConstant.dummy,
                          // height: 80,
                        );
                      } else if (snapshot.hasData) {
                        return Image.network(width: double.infinity, fit: BoxFit.cover, snapshot.data.toString());
                      } else {
                        return FutureBuilder(
                          future: FirebaseAPIs.fetchDefaultOfferImageUrl(isService ? service!.serviceCategoryType.toString() : offerItem!.serviceCategoryType.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting && snapshot.connectionState == ConnectionState.none) {
                              return Image.asset(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.none,
                                ImageConstant.dummy,
                                // height: 80,
                              );
                            } else if (snapshot.hasData) {
                              return Image.network(width: double.infinity, fit: BoxFit.cover, snapshot.data.toString());
                            } else {
                              return Image.asset(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.none,
                                ImageConstant.dummy,
                                // height: 80,
                              );
                            }
                          },
                        );
                      }
                    },
                  )),
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // SizedBox(
                      //   height: 2,
                      // ),
                      // FittedBox(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         'Offer ID: ${isService ? service!.offerId : offerList?.offerId ?? ' '}',
                      //         style: TextStyle(
                      //             fontSize: 10, fontWeight: FontWeight.w600),
                      //       ),
                      //       SizedBox(
                      //         width: MediaQuery.of(context).size.width / 5,
                      //       ),
                      //       Text(
                      //         '${DateFormat('dd-MM-yyyy').format(DateTime.parse(isService ? service!.dateTime.toString() : offerList?.dateTime.toString() ?? ''))}',
                      //         style: TextStyle(
                      //             fontSize: 10, fontWeight: FontWeight.w600),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        isService ? service!.jobTitle ?? '' : offerItem?.jobTitle ?? '',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Expanded(
                          //   child:
                          // ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                // overflowAlignment: OverflowBarAlignment.end,
                                // alignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    CupertinoIcons.cart,
                                    size: 15,
                                    color: AppColors.kprimaryColor,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Flexible(
                                    child: Text(
                                      isService ? service!.quantity.toString() : offerItem?.quantity.toString() ?? '0',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                /*${isService ? service!.rateType ?? ' ' : offerList?.rateType ?? ' '}(*/
                                '৳ ${isService ? service!.rate : offerItem?.rate ?? '0'}',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //       child: Text(
                      //         maxLines: 1,
                      //         overflow: TextOverflow.ellipsis,
                      //         isService
                      //             ? service!.serviceCategoryType ?? ''
                      //             : offerList?.serviceCategoryType ?? '',
                      //         style: TextStyle(
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.w600,
                      //             color: Colors.grey.shade600),
                      //       ),
                      //     ),
                      //
                      //   ],
                      // ),
                      /*button == null
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            isService
                                ? service!.description ?? ''
                                : offerList?.description ?? '',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                        )
                      : */
                    ],
                  )),
              button != null ? Expanded(flex: 2, child: button!) : SizedBox.shrink(),
            ],
          ),
        ),
        if (offerItem?.district != null && offerItem!.district!.isNotEmpty && offerItem!.district != "All Districts" || service?.district != null && service!.district!.isNotEmpty && service!.district != "All Districts" /*||offerList?.district.isNotEmpty*/)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(color: AppColors.kprimaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topLeft: Radius.circular(15))),
              child: Text(
                maxLines: 1,
                isService ? service!.district ?? '' : offerItem?.district ?? '',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          )
      ],
    );
  }
}

class SellerStatusWidget extends StatelessWidget {
  const SellerStatusWidget({
    super.key,
    this.seller,
    this.title,
    this.value,
    this.color,
    this.icon,
  });

  final SellerProfileModel? seller;
  final String? title;
  final String? value;
  final Color? color;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: color!.withOpacity(.1), borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: color ?? Colors.lightBlue, shape: BoxShape.circle),

                    child: Icon(
                      icon ?? Icons.attach_money,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox.shrink(),
                ),
                Expanded(
                    flex: 10,
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      title ?? 'Earning',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value ?? '0',
              style: TextStyle(fontSize: getResponsiveFontSize(context, 18), fontWeight: FontWeight.w800),
            ),
          )
        ],
      ),
    );
  }
}
