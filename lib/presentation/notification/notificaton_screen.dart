import 'package:flutter/material.dart';
import 'package:upai/Model/notification_model.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';

import '../../data/api/firebase_apis.dart';
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
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 3),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(

                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                         Text("${NotificationController.to.notificationList[index].buyerMobile.toString()} request for confirm offer"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("${NotificationController.to
                                                  .notificationList[index]
                                                  .offerId.toString()}"),
                                              ElevatedButton(onPressed: (){}, child: Text("Tap here")),


                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
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
