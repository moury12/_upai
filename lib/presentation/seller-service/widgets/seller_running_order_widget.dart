import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/notification_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/controllers/image_controller.dart';
import 'package:upai/controllers/order_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/seller-service/controller/seller_profile_controller.dart';
import 'package:upai/widgets/custom_network_image.dart';
import '../../../data/repository/repository_details.dart';

class SellerRunningOrderWidget extends StatefulWidget {
  final Function()? jobStatus;
  const SellerRunningOrderWidget({
    super.key,
    required this.sellerRunningOrder,
    this.jobStatus,
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
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog( shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
    ),
              backgroundColor: AppColors.strokeColor2,
              title: const Icon(
                Icons.task_alt_outlined,
                size: 40,
              ),
              alignment: Alignment.center,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    'Is your service ready to deliver?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.kprimaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                foregroundColor: Colors.white),
                            onPressed: () async {
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
                              newNotificationData.jobTitle =
                                  widget.sellerRunningOrder.jobTitle.toString();
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
                                  idStatusUpdate:
                                      newNotificationData.sellerId.toString());
                              await SellerProfileController.to.refreshAllData();
                            },
                            child: const Text('Yes')),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.cancelButtonColor,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                foregroundColor: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No')),
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
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        //width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.strokeColor2, spreadRadius: 2, blurRadius: 5)
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              width: 150,
              height: 150,
              imageUrl: widget.sellerRunningOrder.imgUrl ?? '',
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          widget.sellerRunningOrder.jobTitle ?? 'job title',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Text("৳ ${widget.sellerRunningOrder.price ?? '0.00'}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    // Text('Description:',
                    //     style:
                    //         TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    Text(
                      widget.sellerRunningOrder.description ?? '',
                      style:
                          const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Text(
                    //     '${widget.sellerRunningOrder.rateType ?? ' '}(${widget.sellerRunningOrder.rate})',
                    //     style:
                    //         TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.shopping_bag,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                  '${widget.sellerRunningOrder.packageName ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.lightBlue.withOpacity(.5)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: FittedBox(
                              child: Text(
                                  textAlign: TextAlign.center,
                                  widget.sellerRunningOrder.status?? '',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
