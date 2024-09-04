import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/Inbox/controller/inbox_screen_controller.dart';
import 'package:upai/presentation/Inbox/Widgets/inboxchatcard.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  //final ctrl = Get.put(InboxScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InboxScreenController>(builder: (ctrl) {
      return InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: PopScope(
          canPop: !ctrl.isSearching,
          onPopInvoked: (_) async {
            if (ctrl.isSearching) {
              ctrl.isSearching = false;
              ctrl.searchByNameTE.text = "";
              ctrl.update();
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                      child: TextField(
                        controller: ctrl.searchByNameTE,
                        onSubmitted: (value) {
                          FirebaseAPIs.addChatUser(value.toString());
                        },
                        onChanged: (value) {
                          ctrl.isActionOnChanged = true;
                          if (value == "") {
                            ctrl.isSearching = false;
                          } else {
                            ctrl.isSearching = true;
                            ctrl.searchList.clear();
                            for (var i in ctrl.chatList) {
                              if (i.userId!.toLowerCase().contains(value.toLowerCase()) || i.name!.toLowerCase().contains(value.toLowerCase())) {
                                ctrl.searchList.add(i);
                              }
                            }
                          }
                          ctrl.update();
                        },
                        decoration:
                        InputDecoration(fillColor: AppColors.textFieldBackGround, filled: true, hintText: "Search By Name|User ID", hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500), border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(6))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseAPIs.getMyUsersId(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.kprimaryColor,
                                  ));
                            case ConnectionState.active:
                            case ConnectionState.done:
                              return StreamBuilder(
                                stream: FirebaseAPIs.getAllUsers(snapshot.data?.docs.map((e) => e.id).toList() ?? []),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                      return const Text("");
                                    case ConnectionState.active:
                                    case ConnectionState.done:
                                      final data = snapshot.data!.docs;
                                      print("length of getAllUsers data${data.length}");
                                      if (data.isNotEmpty) {
                                        ctrl.chatList.clear();
                                        for (var i in data) {
                                          ctrl.chatList.add(UserInfoModel.fromJson(i.data()));
                                        }
                                        List<UserInfoModel> finalList = ctrl.isSearching ? ctrl.searchList : ctrl.chatList;
                                        print("xxxxxxxxxxxxxxxxxxxxx");
                                        log(jsonEncode(finalList));

                                        return ListView.builder(
                                          itemCount: finalList.length,
                                          itemBuilder: (context, index) {
                                            int reversedIndex = finalList.length - 1 - index;
                                            if (finalList.isNotEmpty) {
                                              return InkWell(
                                                  onTap: () {
                                                    Get.toNamed("/chatscreen", arguments: finalList[index]);
                                                  },
                                                  child: InboxCardWidget(
                                                    receiverUserInfo: finalList[index],
                                                  ));
                                            } else {
                                              return const Text("No Chat Available");
                                            }
                                          },
                                        );
                                      } else {
                                        return const Center(child: Text("No Chat Available"));
                                      }
                                  }
                                },
                              );

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
          ),
        ),
      );
    });
  }
}