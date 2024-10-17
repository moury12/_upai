import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:upai/controllers/order_controller.dart';

import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/data/api/firebase_apis.dart';

import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/ServiceDetails/service_details.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';
import 'package:upai/widgets/custom_text_field.dart';

import '../../../Model/notification_model.dart';
import '../../../Model/user_info_model.dart';
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
        child: AlertDialog(
            scrollable: true,
            backgroundColor: AppColors.strokeColor2,
            titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: const Text(
              'Confirm Order',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: widget.notificationModel.status == "ACCEPTED"
                      ? const Center(
                          child: Text('You Have Already Confirmed This Order'),
                        )
                      : widget.notificationModel.status == "REJECTED"
                          ? const Center(
                              child: Text('You Have Already Rejected This Order'),
                            )
                          : widget.notificationModel.status == "PENDING"
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Divider(
                                      height: 1,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    // OfferDialogWidget(
                                    //
                                    //   label: 'Category:',
                                    //   text: widget.notificationModel. ??
                                    //       'No category',
                                    // ),
                                    OfferDialogWidget(
                                      label: 'Offer ID:',
                                      text: widget.notificationModel.offerId ?? 'No ID',
                                    ),
                                    OfferDialogWidget(
                                      label: 'Offer Title:',
                                      text: widget.notificationModel.jobTitle ?? 'No Title',
                                    ),
                                    OfferDialogWidget(
                                      label: 'Buyer ID:',
                                      text: widget.notificationModel.buyerId ?? 'Unknown',
                                    ),

                                    OfferDialogWidget(
                                      label: 'Buyer Name:',
                                      text: widget.notificationModel.buyerName ?? 'Unknown',
                                    ),
                                    OfferDialogWidget(
                                      label: 'Package Name:',
                                      text: widget.notificationModel.package ?? '',
                                    ),

                                    const Divider(
                                      height: 12,
                                    ),


                                    Text(
                                      textAlign: TextAlign.center,
                                      'Total amount: ${widget.notificationModel.price} ৳',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(alignment: Alignment.center, backgroundColor: AppColors.kprimaryColor, foregroundColor: Colors.white),
                                              onPressed: () async {
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
                                              },
                                              child: const Text(
                                                "Accept",
                                                textAlign: TextAlign.center,
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(alignment: Alignment.center, backgroundColor: AppColors.cancelButtonColor, foregroundColor: Colors.white),
                                              onPressed: () async {
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
                                              },
                                              child: const Text(
                                                "Reject",
                                                textAlign: TextAlign.center,
                                              )),
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
