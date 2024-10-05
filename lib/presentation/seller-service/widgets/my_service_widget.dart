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
          height: 200,
          width: 200,
          padding: const EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 2, blurRadius: 5)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 4,
                  child:
                  FutureBuilder(
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
                        return Image.network(
                            width: double.infinity,
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
                              return Image.network(
                                  width: double.infinity,
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
                  )
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        isService ? service!.jobTitle ?? '' : offerItem?.jobTitle ?? '',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),

                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,

                        /*${isService ? service!.rateType ?? ' ' : offerList?.rateType ?? ' '}(*/
                        'From ৳ ${isService ?service!.package!.isEmpty?'0': service!.package![0].price ?? '0' :offerItem!.package!.isEmpty ? '0': offerItem?.package![0].price ?? '0'}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,),
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
