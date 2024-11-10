import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/controllers/image_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/Service-details/service_details.dart';
import 'package:upai/widgets/custom_network_image.dart';
import 'package:upai/widgets/favourite_icon_button.dart';

class ServiceOfferWidget extends StatelessWidget {

  final OfferList? offerItem;
  final OfferList? favOfferItem;
  final Widget? button;
  final int index;
   const ServiceOfferWidget(
      {super.key,

      this.offerItem,
      this.button,
      required this.index,
      this.favOfferItem});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          ServiceDetails(
            offerDetails: offerItem,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.only(bottom: 8),
        //height: 150.w,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.strokeColor2, spreadRadius: 2, blurRadius: 2)
          ],
          borderRadius: BorderRadius.circular(defaultRadius),
        ),

        child: Row(
          //mainAxisSize: MainAxisSize.max,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child:  CustomNetworkImage(
                height: .25.sw,
                  imageUrl: offerItem!.imgUrl??'',
                )
            ),
            SizedBox(
              width: 12.w,
            ), 
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                       offerItem?.jobTitle ?? '',
                        style: TextStyle(
                            fontSize: default14FontSize, fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                      FavouriteIconButton(offerItem: offerItem!,)
                    ],
                  ),
                  // Text('Description:',
                  //     style:
                  //     TextStyle(fontSize: default14FontSize, fontWeight: FontWeight.w500)),
                  Text(
                    offerItem?.description ?? '',
                    style:
                        TextStyle(fontSize: default12FontSize, fontWeight: FontWeight.w400),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,size:15.sp ,),
                       Text(
                                  maxLines: 1,
                                 offerItem?.district ?? '',
                                  style: TextStyle(
                                      fontSize: default12FontSize,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                )

                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Icon(
                                CupertinoIcons.star_fill,
                                size: defaultIconSize,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                                 double.parse(
                                            offerItem?.avgRating ??
                                                '0.0')
                                        .toStringAsFixed(1),
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                    fontSize: default12FontSize,
                                    fontWeight: FontWeight.w500)),
                            Spacer(),
                            Text(
                              'From ',
                              style: TextStyle(
                                  fontSize: default10FontSize, fontWeight: FontWeight.w400),
                            ),
                            Text(
                                '৳${offerItem!.package == null || offerItem!.package!.isEmpty ? '0.0' : offerItem!.package![0].price ?? '0.0'}',
                                style: TextStyle(
                                    fontSize: default14FontSize,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
