import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/controllers/image_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/widgets/custom_network_image.dart';
class MyServiceWidget extends StatelessWidget {
  final MyService? service;
  final OfferList? offerItem;
  final Widget? button;
   const MyServiceWidget({super.key, this.service, this.offerItem, this.button});


  @override
  Widget build(BuildContext context) {

    bool isService = service != null;
    return Container(
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

        children: [

          Expanded(
              flex: 4,
              child:
             CustomNetworkImage(

                  imageUrl:isService ? service!.imgUrl ?? '' :  offerItem!.imgUrl??''
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
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  (offerItem?.district != null && offerItem!.district!.isNotEmpty
                      && offerItem!.district != "All Districts"
                      || service?.district != null && service!.district!.isNotEmpty
                          && service!.district != "All Districts" )?  Text(
                    maxLines: 1,
                    isService ? service!.district ?? '' : offerItem?.district ?? '',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                  ):const SizedBox.shrink(),
                  Row(
                    children: [
                     Expanded(
                       child: Row(children: [
                         Text(
                           'From ',
                           style: TextStyle(
                               fontSize: 11, fontWeight: FontWeight.w400),
                         ),
                         Text(
                             '৳ ${isService ?service!.package!.isEmpty?'0': service!.package![0].price ?? '0' :offerItem!.package!.isEmpty ? '0': offerItem?.package![0].price ?? '0'}',
                             style: TextStyle(
                                 fontSize: 14,
                                 fontWeight: FontWeight.w700)),
                       ],),
                     ),
                      offerItem!=null?Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Icon(
                            CupertinoIcons.star_fill,
                            size: 15,
                            color: AppColors.kprimaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                            isService
                                ? ""
                                : double.parse(
                                offerItem?.avgRating ??
                                    '0.0')
                                .toStringAsFixed(1),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ],):const SizedBox.shrink()
                    ],
                  ),

                ],
              )),
          button != null ? Expanded(flex: 2, child: button!) : const SizedBox.shrink(),
        ],
      ),
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
      padding: const EdgeInsets.all(8),
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
                      size: MediaQuery.of(context).size.width/20,
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox.shrink(),
                ),
                Expanded(
                    flex: 10,
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      title ?? 'Earning',
                      style: const TextStyle(fontWeight: FontWeight.w600),
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
