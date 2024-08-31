import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/notification_model.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/core/utils/my_date_util.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';
import 'package:upai/presentation/notification/widget/confirm_order_dialog.dart';
import 'package:upai/widgets/custom_button.dart';

import '../../data/api/firebase_apis.dart';
import '../../review/review_screen.dart';
import 'controller/notification_controller.dart';

class NotificatonScreen extends StatefulWidget {
  const NotificatonScreen({super.key});

  @override
  State<NotificatonScreen> createState() => _NotificatonScreenState();
}

class _NotificatonScreenState extends State<NotificatonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseAPIs.getMyNotificationList(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data!.docs;
                        print("Number of Notification ${data.length}");
                        if (data.isNotEmpty) {
                          NotificationController.to.notificationList.clear();
                          for (var i in data) {
                            NotificationController.to.notificationList
                                .add(NotificationModel.fromJson(i.data()));
                          }
                          return ListView.builder(
                            itemCount: NotificationController
                                .to.notificationList.length,
                            itemBuilder: (context, index) {
                              int reversedIndex = NotificationController
                                      .to.notificationList.length -
                                  1 -
                                  index;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade200, width: 3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if(NotificationController.to.notificationList[reversedIndex].status=="DELIVERED" &&ProfileScreenController.to.userInfo.value.userId!=NotificationController.to.notificationList[reversedIndex].sellerId)
                                            {
                                              showDialog(
                                                context: context,
                                                builder: (context) => ReviewScreen(
                                                    notificationModel:
                                                    NotificationController.to
                                                        .notificationList[
                                                    reversedIndex]),
                                              );
                                            }

                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Icon(
                                                  Icons.notifications_on,
                                                  size: 35),
                                            ),
                                            Expanded(
                                                flex: 6,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        NotificationController
                                                            .to
                                                            .notificationList[
                                                                reversedIndex]
                                                            .notificationTitle
                                                            .toString(),
                                                        style: AppTextStyle
                                                            .bodyMediumBlack400,
                                                      ),
                                                      Text(
                                                          NotificationController
                                                              .to
                                                              .notificationList[
                                                                  reversedIndex]
                                                              .notificationMsg
                                                              .toString()),

                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Text(MyDateUtil.getLastMessageTime(context: context,time: NotificationController
                                                          .to
                                                          .notificationList[
                                                      reversedIndex]
                                                          .createdTime
                                                          .toString(),
                                                              )
                                                          .toString()),
                                                    ),
                                                    Text(
                                                        "৳${NotificationController.to.notificationList[reversedIndex].total.toString()}",
                                                        style: AppTextStyle
                                                            .bodyMediumBlackSemiBold),
                                                    Text(
                                                        "🛒${NotificationController.to.notificationList[reversedIndex].quantity.toString()}",
                                                        style: AppTextStyle
                                                            .bodyMediumSemiBlackBold),
                                                  ],
                                                ))
                                            // Column(
                                            //   mainAxisAlignment: MainAxisAlignment.center,
                                            //   children: [
                                            //     // Padding(
                                            //     //   padding: const EdgeInsets.only(right: 16,top: 16),
                                            //     //   child: Align(
                                            //     //     alignment:Alignment.bottomRight,
                                            //     //       child: Text(MyDateUtil.formatDate(NotificationController.to.notificationList[reversedIndex].createdTime.toString()).toString())),
                                            //     // ),
                                            //     ListTile(
                                            //       leading: Icon(Icons.notifications_on, size: 35),
                                            //       title: Text(NotificationController.to.notificationList[reversedIndex].notificationTitle.toString()),
                                            //       subtitle: Column(
                                            //         children: [
                                            //           Text(NotificationController.to.notificationList[reversedIndex].notificationMsg.toString()),
                                            //         ],
                                            //       ),
                                            //       trailing: Column(
                                            //         mainAxisSize: MainAxisSize.max,
                                            //         mainAxisAlignment: MainAxisAlignment.center,
                                            //         children: [
                                            //           Expanded(child: Text(MyDateUtil.formatDate(NotificationController.to.notificationList[reversedIndex].createdTime.toString()).toString())),
                                            //           Expanded(child: Text("৳${NotificationController.to.notificationList[reversedIndex].total.toString()}", style: AppTextStyle.bodyMediumBlackSemiBold)),
                                            //           Expanded(child: Text("🛒${NotificationController.to.notificationList[reversedIndex].quantity.toString()}", style: AppTextStyle.bodyMediumSemiBlackBold)),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //     ProfileScreenController.to.userInfo.value.userId==NotificationController.to.notificationList[reversedIndex].buyerId?SizedBox():
                                            //     SizedBox(
                                            //       height: 40,
                                            //       width: 150,
                                            //       child: CustomButton(onTap: () {
                                            //         showDialog(context: context, builder: (context) => ConfirmOrderWidget(notificationModel: NotificationController.to.notificationList[reversedIndex],),);
                                            //       }, text: "Tap Here"),
                                            //     ),
                                            //     SizedBox(height: 10),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                      ProfileScreenController
                                          .to
                                          .userInfo
                                          .value
                                          .userId ==
                                          NotificationController
                                              .to
                                              .notificationList[
                                          reversedIndex]
                                              .buyerId
                                          ? SizedBox()
                                          : SizedBox(
                                        height: 40,
                                        width: 150,
                                        child: CustomButton(
                                            onTap: () {
                                              showDialog(
                                                context:
                                                context,
                                                builder:
                                                    (context) =>
                                                    ConfirmOrderWidget(
                                                      notificationModel: NotificationController
                                                          .to
                                                          .notificationList[reversedIndex],
                                                    ),
                                              );
                                            },
                                            text: "Tap Here"),
                                      ),
                                      SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  width: 80,
                                  height: 80,
                                  ImageConstant.notification),
                              SizedBox(
                                height: 10,
                              ),
                              Text("No Notification Yet",
                                  style: AppTextStyle.bodyMedium400),
                            ],
                          );
                        }

                      // StreamBuilder(stream: FirebaseAPIs.getAllUsers( snapshot.data?.docs.map((e) => e.id).toList() ?? []),
                      // builder: (context, snapshot) {
                      //   switch(snapshot.connectionState){
                      //     case ConnectionState.waiting:
                      //     case ConnectionState.none:
                      //       return const Text("");
                      //     case ConnectionState.active:
                      //     case ConnectionState.done:
                      //       final data = snapshot.data!.docs;
                      //
                      //       if (data.isNotEmpty) {
                      //         ctrl.chatList.clear();
                      //         for (var i in data) {
                      //           ctrl.chatList.add(
                      //               UserInfoModel.fromJson(i.data()));
                      //         }
                      //         return ListView.builder(
                      //
                      //           itemCount: ctrl.isSearching ? ctrl.searchList
                      //               .length : ctrl.chatList.length,
                      //           itemBuilder: (context, index) {
                      //             if (ctrl.isSearching?ctrl.searchList.isNotEmpty:ctrl.chatList.isNotEmpty) {
                      //               return InkWell(
                      //                   onTap: () {
                      //                     Get.toNamed("/chatscreen",arguments: ctrl.isSearching?ctrl.searchList[index]:ctrl.chatList[index]);
                      //                   },
                      //                   child: InboxCardWidget(
                      //                     receiverUserInfo: ctrl.isSearching
                      //                         ? ctrl.searchList[index]
                      //                         : ctrl.chatList[index],));
                      //             }
                      //             else {
                      //               return const Text("No Chat Available");
                      //             }
                      //           },
                      //         );
                      //       }
                      //       else {
                      //         return const Center(
                      //             child: Text("No Chat Available"));
                      //       }
                      //   }
                      //
                      //
                      // },);

                      //     final data = snapshot.data!.docs;
                      //     print(data.length);
                      //     if (data.isNotEmpty) {
                      //       ctrl.chatList.clear();
                      //       for (var i in data) {
                      //         ctrl.chatList.add(
                      //             UserInfoModel.fromJson(i.data()));
                      //       }
                      //       return ListView.builder(
                      //         itemCount: ctrl.isSearching ? ctrl.searchList
                      //             .length : ctrl.chatList.length,
                      //         itemBuilder: (context, index) {
                      //           if (ctrl.isSearching?ctrl.searchList.isNotEmpty:ctrl.chatList.isNotEmpty) {
                      //             return InkWell(
                      //                 onTap: () {
                      //                   Get.toNamed("/chatscreen",arguments: ctrl.isSearching?ctrl.searchList[index]:ctrl.chatList[index]);
                      //                 },
                      //                 child: ChatItemWidget(
                      //                   userInfoModel: ctrl.isSearching
                      //                       ? ctrl.searchList[index]
                      //                       : ctrl.chatList[index],));
                      //           }
                      //           else {
                      //             return const Text("No Chat Available");
                      //           }
                      //         },
                      //       );
                      //     }
                      //     else {
                      //       return const Center(
                      //           child: Text("No Chat Available"));
                      //     }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
