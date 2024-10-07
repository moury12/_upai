import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';
import 'package:upai/presentation/ServiceDetails/service_details_controller.dart';

class ServiceOfferWidget extends StatefulWidget {
  final MyService? service;
  final OfferList? offerItem;
  final OfferList? favOfferItem;
  final Widget? button;
  final int index;
  const ServiceOfferWidget(
      {super.key,
      this.service,
      this.offerItem,
      this.button,
      required this.index,
      this.favOfferItem});

  @override
  State<ServiceOfferWidget> createState() => _ServiceOfferWidgetState();
}

class _ServiceOfferWidgetState extends State<ServiceOfferWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 30.0, end: 35.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if we're using service or offerList
    bool isService = widget.service != null;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 8),
          // height: 150,
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

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FutureBuilder(
                      future: FirebaseAPIs.fetchOfferImageUrl(isService
                          ? widget.service!.offerId.toString()
                          : widget.offerItem!.offerId.toString()),
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
                          return Image.network(loadingBuilder:
                                  (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image has finished loading
                            }
                            return SizedBox(
                              height: 120,
                              width: double.infinity,
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
                              height: 120,
                              width: double.infinity,
                              // height: getResponsiveFontSize(context, 120),
                              fit: BoxFit.cover,
                              snapshot.data.toString());
                        } else {
                          return FutureBuilder(
                            future: FirebaseAPIs.fetchDefaultOfferImageUrl(
                                isService
                                    ? widget.service!.serviceCategoryType
                                        .toString()
                                    : widget.offerItem!.serviceCategoryType
                                        .toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Image.network(loadingBuilder:
                                        (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child; // Image has finished loading
                                  }
                                  return SizedBox(
                                    height: 120,
                                    width: double.infinity,
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
                                    height: 120,
                                    width: double.infinity,
                                    // height: getResponsiveFontSize(context, 120),
                                    fit: BoxFit.cover,
                                    snapshot.data.toString());
                              } else {
                                return Image.asset(
                                  ImageConstant.dummy,
                                  // height: getResponsiveFontSize(context, 120),
                                  height: 120,
                                  width: double.infinity,
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
                child: Container(
                  height: 140,
                  child: Column(
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
                            isService
                                ? widget.service!.jobTitle ?? ''
                                : widget.offerItem?.jobTitle ?? '',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: IconButton(
                                onPressed: () async {
                                  await _controller.forward();

                                  // Pause for a moment and then zoom out
                                  // await Future.delayed(Duration(milliseconds: 100));
                                  await _controller.reverse();

                                  if (!widget.offerItem!.isFav!) {
                                    widget.offerItem!.isFav = true;
                                    saveOfferToHive(widget.offerItem!);

                                  } else {
                                    widget.offerItem!.isFav = false;
                                    deleteFavOffers(
                                        widget.offerItem!.offerId.toString());
                                    // HomeController.to.favOfferList.refresh();
                                    // HomeController.to.getOfferList.refresh();

                                  }
                                  debugPrint(widget.offerItem!.isFav.toString());
                                  setState(() {});
                                },
                                icon: AnimatedBuilder(
                                    animation: _animation,
                                    builder: (context, child) {
                                      return Icon(
                                        widget.offerItem!.isFav!
                                            ? CupertinoIcons.heart_fill
                                            : CupertinoIcons.heart,
                                        color: AppColors.kprimaryColor,
                                        size: _animation.value,
                                      );
                                    })),
                          )
                        ],
                      ),
                      // Text('Description:',
                      //     style:
                      //     TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      Text(
                        isService
                            ? widget.service!.description ?? ''
                            : widget.offerItem?.description ?? '',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Spacer(),

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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                Spacer(),
                                Text(
                                  'From ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                    '৳ ${ widget.offerItem!.package == null||widget.offerItem!.package!.isEmpty  ? '0.0' : widget.offerItem!.package![0].price ?? '0.0'}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        isService
            ? widget.service!.district!.isEmpty
                ? SizedBox.shrink()
                : Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: AppColors.kprimaryColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(15))),
                      child: Text(
                        maxLines: 1,
                        isService
                            ? widget.service!.district ?? ''
                            : widget.offerItem?.district ?? '',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  )
            : widget.offerItem!.district!.isEmpty
                ? SizedBox.shrink()
                : Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: AppColors.kprimaryColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(15))),
                      child: Text(
                        maxLines: 1,
                        isService
                            ? widget.service!.district ?? ''
                            : widget.offerItem?.district ?? '',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  )
      ],
    );
  }
}
