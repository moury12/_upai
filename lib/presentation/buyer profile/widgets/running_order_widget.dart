import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/notification_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/controllers/order_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/seller-service/seller_profile_controller.dart';

import '../../../data/repository/repository_details.dart';

class BuyerRunningOrderWidget extends StatefulWidget {
  final Function()? jobStatus;
  const BuyerRunningOrderWidget({
    super.key,
    required this.runningOrder,
    this.jobStatus,
  });

  final RunningOrder runningOrder;

  @override
  State<BuyerRunningOrderWidget> createState() => _BuyerRunningOrderWidgetState();
}

class _BuyerRunningOrderWidgetState extends State<BuyerRunningOrderWidget> {
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
            if(widget.runningOrder.status=='DELIVERED')
              {
                return AlertDialog(
                  backgroundColor: AppColors.strokeColor2,
                  title: const Icon(
                    Icons.task_alt_outlined,
                    size: 40,
                  ),
                  alignment: Alignment.center,
                  content: Column(mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'Is your service delivered?',
                        style: TextStyle(
                            fontSize:18,
                            fontWeight: FontWeight.w600),
                      ),SizedBox(height: 10,),Row(children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen,
                                  padding: EdgeInsets.symmetric(vertical: 12),

                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                Navigator.pop(context);
                                NotificationModel newNotificationData = NotificationModel();
                                newNotificationData.jobId=widget.runningOrder.jobId;
                                newNotificationData.buyerId=widget.runningOrder.buyerId;
                                newNotificationData.sellerId=widget.runningOrder.sellerId;
                                newNotificationData.quantity=widget.runningOrder.quantity.toString();
                                newNotificationData.rateType=widget.runningOrder.rateType;
                                newNotificationData.rate=widget.runningOrder.rate;
                                newNotificationData.total=widget.runningOrder.total.toString();
                                newNotificationData.jobTitle=widget.runningOrder.jobTitle.toString();
                                newNotificationData.status="COMPLETED";
                                newNotificationData.createdTime=DateTime.now().toString();
                                newNotificationData.description=widget.runningOrder.description.toString();
                                newNotificationData.notificationTitle="${widget.runningOrder.jobTitle} Job Completed";
                                newNotificationData.notificationMsg="Congratulations you have completed the service.Thank you for using Upai";
                                await RepositoryData.jobStatus(body: {
                                  "job_id": widget.runningOrder.jobId,
                                  "status": "COMPLETED",
                                  "award_date": widget.runningOrder.awardDate,
                                  "completion_date": DateTime.now().toString()

                                },isDialogScreen: false,context: context,msg: newNotificationData.notificationMsg.toString(),title: newNotificationData.notificationTitle.toString(),notification: newNotificationData,idStatusUpdate: newNotificationData.sellerId.toString());

                                await SellerProfileController.to.refreshAllData();
                              },
                              child: const Text('Yes')),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No')),
                        )
                      ],)
                    ],
                  ),
                  actionsAlignment: MainAxisAlignment.center,

                );
              }
            else
              {
                return SizedBox(height: 0,);
              }

          },
        );
      },
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.asset(
                ImageConstant.runningOrderImage,
                height: getResponsiveFontSize(context, 120),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        widget.runningOrder.jobTitle ?? 'job title',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Text("৳ ${widget.runningOrder.total ?? '0.00'}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  Text('Description:',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  Text(
                    widget.runningOrder.description ?? '',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                      '${widget.runningOrder.rateType ?? ' '}(${widget.runningOrder.rate})',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.cart,
                              size: 14,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text('${widget.runningOrder.quantity ?? ''}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.lightBlue.withOpacity(.5)),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Text(
                              textAlign: TextAlign.center,
                              '${widget.runningOrder.status ?? ''}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
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
    );
  }
}
