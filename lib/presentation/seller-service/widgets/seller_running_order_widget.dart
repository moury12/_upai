import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/Model/notification_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/controllers/image_controller.dart';
import 'package:upai/controllers/order_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';
import 'package:upai/widgets/custom_button.dart';
import 'package:upai/widgets/custom_network_image.dart';
import '../../../data/repository/repository_details.dart';

class SellerRunningOrderWidget extends StatefulWidget {
  final bool? isBuyer;
  final Function()? jobStatus;
  SellerRunningOrderWidget({
    super.key,
    required this.sellerRunningOrder,
    this.jobStatus,
    this.isBuyer = false,
  });

  final SellerRunningOrder sellerRunningOrder;

  @override
  State<SellerRunningOrderWidget> createState() =>
      _SellerRunningOrderWidgetState();
}

class _SellerRunningOrderWidgetState extends State<SellerRunningOrderWidget> {
  @override
  void initState() {
    Get.put(OrderController());

    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isBuyer == true
          ? null
          : () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius)),
                    ),
                    backgroundColor: AppColors.strokeColor2,
                    title: Icon(
                      Icons.task_alt_outlined,
                      size: 40.sp,
                    ),
                    alignment: Alignment.center,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'Is your service ready to deliver?',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        defaultSizeBoxHeight,
                        Row(
                          children: [
                            Expanded(
                                child: CustomButton(
                              text: 'Yes',
                              onTap: () async {
                                Navigator.pop(context);
                                NotificationModel newNotificationData =
                                    NotificationModel();
                                newNotificationData.jobId =
                                    widget.sellerRunningOrder.jobId;
                                newNotificationData.buyerId =
                                    widget.sellerRunningOrder.buyerId;
                                newNotificationData.sellerId =
                                    widget.sellerRunningOrder.sellerId;
                                newNotificationData.price =
                                    widget.sellerRunningOrder.price.toString();
                                newNotificationData.jobTitle = widget
                                    .sellerRunningOrder.jobTitle
                                    .toString();
                                newNotificationData.status = "DELIVERED";
                                newNotificationData.createdTime = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                newNotificationData.description = widget
                                    .sellerRunningOrder.description
                                    .toString();
                                newNotificationData.notificationTitle =
                                    "Service Completed";
                                newNotificationData.notificationMsg =
                                    "${widget.sellerRunningOrder.jobTitle} service completed confirm and give a review to the seller";
                                await RepositoryData.jobStatus(
                                    body: {
                                      "job_id": widget.sellerRunningOrder.jobId,
                                      "status": "DELIVERED",
                                      "award_date": widget
                                          .sellerRunningOrder.awardDate
                                          .toString(),
                                      // "completion_date": DateTime.now().toString()
                                    },
                                    isDialogScreen: false,
                                    context: context,
                                    msg: newNotificationData.notificationMsg
                                        .toString(),
                                    title: newNotificationData.notificationTitle
                                        .toString(),
                                    notification: newNotificationData,
                                    idStatusUpdate: newNotificationData.sellerId
                                        .toString());
                                await SellerProfileController.to
                                    .refreshAllData();
                              },
                            )),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: CustomButton(
                                text: 'No',
                                color: AppColors.cancelButtonColor,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                  );
                },
              );
            },
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            padding: EdgeInsets.all(12.sp), // Dynamic padding based on screen size
            margin: EdgeInsets.only(bottom: 8.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.strokeColor2,
                  spreadRadius: 2,
                  blurRadius: 5,
                )
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: CustomNetworkImage(
                    imageUrl: widget.sellerRunningOrder.imgUrl ?? '',
                    // Ensures the image fills available space
                  ),
                ),
                SizedBox(width: 12.sp),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.sellerRunningOrder.jobTitle ?? 'job title',
                              style: TextStyle(
                                fontSize: 14.sp, // Responsive font size
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "৳ ${widget.sellerRunningOrder.price ?? '0.00'}",
                            style: TextStyle(
                              fontSize: 16.sp, // Responsive font size
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.sellerRunningOrder.description ?? '',
                        style: TextStyle(
                          fontSize: 12.sp, // Responsive font size
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  size: 14.sp, // Responsive icon size
                                ),
                                SizedBox(width: 2.sp),
                                Text(
                                  '${widget.sellerRunningOrder.duration ?? ''}',
                                  style: TextStyle(
                                    fontSize: 12.sp, // Responsive font size
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.lightBlue.withOpacity(.5),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 4.sp,
                                horizontal: 8.sp,
                              ),
                              child: FittedBox(
                                child: Text(
                                  widget.sellerRunningOrder.status ?? '',
                                  style: TextStyle(
                                    fontSize: 12.sp, // Responsive font size
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
