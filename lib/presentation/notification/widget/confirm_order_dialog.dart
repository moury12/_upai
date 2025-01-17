import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/presentation/Service-details/service_details.dart';
import 'package:upai/widgets/custom_button.dart';
import '../../../Model/notification_model.dart';
import '../../../data/repository/repository_details.dart';

class ConfirmOrderWidget extends StatefulWidget {
  final NotificationModel notificationModel;
  const ConfirmOrderWidget({
    super.key,
    required this.notificationModel,
  });
  @override
  State<ConfirmOrderWidget> createState() => _ConfirmOrderWidgetState();
}

class _ConfirmOrderWidgetState extends State<ConfirmOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (didPop) {},
        child: AlertDialog( shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
    ),
            scrollable: true,
            backgroundColor: AppColors.strokeColor2,
             titlePadding:  EdgeInsets.only(top: 12.sp,bottom: 0),

            // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title:  Text(
              'confirm_order'.tr,
              style: TextStyle(
                fontSize: defaultTitleFontSize,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: widget.notificationModel.status == "ACCEPTED"
                      ?  Center(
                          child: Text('You Have Already Confirmed This Order',style: AppTextStyle.bodySmallblack(context),),
                        )
                      : widget.notificationModel.status == "REJECTED"
                          ?  Center(
                              child: Text('You Have Already Rejected This Order',style: AppTextStyle.bodySmallblack(context)),
                            )
                          : widget.notificationModel.status == "PENDING"
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Divider(
                                      height: 1,
                                    ),
                                     SizedBox(
                                      height:12.w,
                                    ),
                                    // OfferDialogWidget(
                                    //
                                    //   label: 'Category:',
                                    //   text: widget.notificationModel. ??
                                    //       'No category',
                                    // ),
                                    OfferDialogWidget(
                                      label: '${'offer_id'.tr}:',
                                      text: widget.notificationModel.offerId ?? 'No ID',
                                    ),
                                    OfferDialogWidget(
                                      label: '${'offer_title'.tr}:',
                                      text: widget.notificationModel.jobTitle ?? 'No Title',
                                    ),
                                    OfferDialogWidget(
                                      label:'${'buyer_id'.tr}:',
                                      text: widget.notificationModel.buyerId ?? 'Unknown',
                                    ),

                                    OfferDialogWidget(
                                      label: '${'buyer_name'.tr}:',
                                      text: widget.notificationModel.buyerName ?? 'Unknown',
                                    ),
                                    OfferDialogWidget(
                                      label:'${'package_name'.tr}:',
                                      text: widget.notificationModel.package ?? '',
                                    ),

                                     Divider(
                                      height:12.w,
                                    ),


                                    Text(
                                      textAlign: TextAlign.center,
                                      '${'total_amount'.tr}: ${widget.notificationModel.price} ৳',
                                      style: TextStyle(fontSize: defaultTitleFontSize, fontWeight: FontWeight.w600, color: Colors.black),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child:CustomButton(text: "accept".tr,onTap:  () async {
                                            NotificationModel newNotificationData = widget.notificationModel;
                                            newNotificationData.status = "ACCEPTED";
                                            newNotificationData.notificationTitle = "Order Request Confirmed";
                                            newNotificationData.createdTime = DateTime.now().millisecondsSinceEpoch.toString();
                                            newNotificationData.notificationMsg = '${widget.notificationModel.sellerName} has accepted your order request visit My Running Order screen for more details';
                                            await RepositoryData.jobStatus(
                                                title: newNotificationData.notificationTitle.toString(),
                                                msg: newNotificationData.notificationMsg,
                                                notification: newNotificationData,
                                                context: context,
                                                isDialogScreen: true,
                                                body: {
                                                  "job_id": widget.notificationModel.jobId,
                                                  "status": "ACCEPTED",
                                                  "award_date": DateTime.now().toString(),
                                                  "completion_date": "",
                                                },
                                                idStatusUpdate: newNotificationData.sellerId.toString());
                                          },)
                                        ),
                                       defaultSizeBoxWidth,
                                        Expanded(
                                          child: CustomButton(text: "reject".tr,onTap: () async {
                                            NotificationModel newNotificationData = widget.notificationModel;
                                            newNotificationData.status = "REJECTED";
                                            newNotificationData.notificationTitle = "Order Request Rejected";
                                            newNotificationData.notificationMsg = '${widget.notificationModel.sellerName} has rejected ${widget.notificationModel.jobTitle}  order request.';
                                            newNotificationData.createdTime = DateTime.now().millisecondsSinceEpoch.toString();
                                            await RepositoryData.jobStatus(
                                                title: newNotificationData.notificationTitle.toString(),
                                                msg: newNotificationData.notificationMsg,
                                                notification: newNotificationData,
                                                context: context,
                                                isDialogScreen: true,
                                                body: {"job_id": widget.notificationModel.jobId, "status": "REJECTED", "award_date": DateTime.now().toString(), "completion_date": "", "notification_id": widget.notificationModel.notificationId},
                                                idStatusUpdate: newNotificationData.sellerId.toString());
                                          },color: AppColors.cancelButtonColor,),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    )
                                  ],
                                )
                              : const Center(child: Text("Action Already Done")),
                  // ):
                  //
                ),
              ],
            )));
  }
}
