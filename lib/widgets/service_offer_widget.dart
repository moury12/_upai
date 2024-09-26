import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/helper_function/helper_function.dart';
class ServiceOfferWidget extends StatelessWidget {
  final MyService? service;
  final OfferList? offerItem;
  final Widget? button;
  const ServiceOfferWidget({super.key, this.service, this.offerItem, this.button});

  @override
  Widget build(BuildContext context) {
    // Determine if we're using service or offerList
    bool isService = service != null;
    return 
        Column(
          children: [
            Container(

                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 8),
                //width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,

                  boxShadow: [
                    BoxShadow(
                        color: AppColors.strokeColor2, spreadRadius: 2, blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),

                  child: Row(
                    //mainAxisSize: MainAxisSize.max,

                    crossAxisAlignment: CrossAxisAlignment.center  ,
                    children: [
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: FutureBuilder(
                            future: FirebaseAPIs.fetchOfferImageUrl(isService ? service!.offerId.toString() : offerItem!.offerId.toString()),
                            builder: (context, snapshot) {
                              // if(snapshot.connectionState==ConnectionState.waiting||snapshot.connectionState==ConnectionState.none)
                              //   {
                              //     return Image.asset(
                              //       ImageConstant.dummy,
                              //       height: getResponsiveFontSize(context, 120),
                              //       fit: BoxFit.none,
                              //     );
                              //   }
                              if (snapshot.hasData) {
                                return Image.network(
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
                                    height: getResponsiveFontSize(context, 120),
                                    fit: BoxFit.cover, snapshot.data.toString());
                              }
                              else {
                                return FutureBuilder(
                                  future: FirebaseAPIs.fetchDefaultOfferImageUrl(isService ? service!.serviceCategoryType.toString() : offerItem!.serviceCategoryType.toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Image.network(
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
                                          height: getResponsiveFontSize(context, 120),
                                          fit: BoxFit.cover, snapshot.data.toString());
                                    }
                                    else {
                                      return Image.asset(
                                        ImageConstant.dummy,
                                        height: getResponsiveFontSize(context, 120),
                                        fit: BoxFit.none,
                                      );
                                    }
                                  },
                                );
                              }
                            },
                          )
                          ////

                          // Image.asset(
                          //   ImageConstant.runningOrderImage,
                          //   height: getResponsiveFontSize(context, 120),
                          //   fit: BoxFit.fill,
                          // ),

                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),

                      Expanded(
                        flex: 6,
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,


                          //
                          // crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            /*Row( mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Job id: ${runningOrder.jobId ?? 'job id'}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),Text(
                                    '${runningOrder.awardDate ?? ''}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),*/

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                      isService ? service!.jobTitle ?? '' : offerItem?.jobTitle ?? '',
                                      style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                Text( '৳ ${isService ? service!.rate : offerItem?.rate ?? '0'}',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w700)),
                              ],
                            ),
                            // Text('Description:',
                            //     style:
                            //     TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            Text(
                              isService ? service!.description ?? '' : offerItem?.description ?? '',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                               SizedBox(height: 10,),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:2.0),
                                        child: Icon(
                                          CupertinoIcons.star_fill,
                                          size: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text( isService ? "": offerItem?.avgRating.toStringAsFixed(1)?? 0.0,
                                        textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.lightBlue.withOpacity(.5)),
                                    padding:
                                    EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    child: Icon(CupertinoIcons.heart_fill,color: Colors.white,)
                                    // Text(
                                    //     textAlign: TextAlign.center,
                                    //     '${widget.sellerRunningOrder.status ?? ''}',
                                    //     style: TextStyle(
                                    //         fontSize: 12, fontWeight: FontWeight.w500)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
          ],
        );
  }
}
