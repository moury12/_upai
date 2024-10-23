import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/controllers/image_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/widgets/custom_network_image.dart';
class MyServiceWidget extends StatefulWidget {
  final MyService? service;
  final OfferList? offerItem;
  final Widget? button;
  const MyServiceWidget({super.key, this.service, this.offerItem, this.button});

  @override
  State<MyServiceWidget> createState() => _MyServiceWidgetState();
}

class _MyServiceWidgetState extends State<MyServiceWidget> {
  late ImageController imageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageController = ImageController();
    _fetchImages();
  }
  void _fetchImages() async {
    bool isService = widget.service != null;

    // Use the helper function and pass the ImageController
    await fetchImages(
      isService ? widget.service!.offerId.toString() : widget.offerItem!.offerId.toString(),
      isService ? widget.service!.serviceCategoryType.toString() : widget.offerItem!.serviceCategoryType.toString(),
      imageController,
    );
  }
  @override
  Widget build(BuildContext context) {

    bool isService = widget.service != null;
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
              Obx(() {
                return CustomNetworkImage(

                  imageUrl: imageController.offerImageUrl.value != null
                      ? imageController.offerImageUrl.value!
                      : imageController.defaultOfferImageUrl.value ?? '',
                );
              })
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
                    isService ? widget.service!.jobTitle ?? '' : widget.offerItem?.jobTitle ?? '',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  (widget.offerItem?.district != null && widget.offerItem!.district!.isNotEmpty
                      && widget.offerItem!.district != "All Districts"
                      || widget.service?.district != null && widget.service!.district!.isNotEmpty
                          && widget.service!.district != "All Districts" )?  Text(
                    maxLines: 1,
                    isService ? widget.service!.district ?? '' : widget.offerItem?.district ?? '',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                  ):SizedBox.shrink(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,

                          'From ৳ ${isService ?widget.service!.package!.isEmpty?'0': widget.service!.package![0].price ?? '0' :widget.offerItem!.package!.isEmpty ? '0': widget.offerItem?.package![0].price ?? '0'}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,),
                        ),
                      ),
                      widget.offerItem!=null?Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Icon(
                            CupertinoIcons.star_fill,
                            size: 15,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                            isService
                                ? ""
                                : double.parse(
                                widget.offerItem?.avgRating ??
                                    '0.0')
                                .toStringAsFixed(1),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ],):SizedBox.shrink()
                    ],
                  ),

                ],
              )),
          widget.button != null ? Expanded(flex: 2, child: widget.button!) : SizedBox.shrink(),
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
                      size: MediaQuery.of(context).size.width/20,
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
