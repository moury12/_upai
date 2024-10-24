import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/user_info_model.dart';
class InboxScreenController extends GetxController{
  // List<UserInfoModel> myChatList = [];
  bool isSearching=false;
  bool isActionOnChanged=false;
  TextEditingController searchByNameTE = TextEditingController();
  // final _chars =
  //     'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  // final Random _rnd = Random();
  List<UserInfoModel> chatList = [];
  final  List<UserInfoModel> searchList = [];
  @override
  void dispose() {
    searchByNameTE.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // Future<void> sortList(UserInfoModel userInfo) async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseAPIs
  //       .getUserLastMessage(userInfo);
  //   // var data = FirebaseAPIs.getUserLastMessage(userInfo).toString();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     print("KJDFJKLSDJFLKF");
  //     QueryDocumentSnapshot<Map<String, dynamic>> lastDoc = querySnapshot.docs
  //         .first;
  //     print("aaaaaaaaaaaaaaaaaaa");
  //     Map<String, dynamic> data = lastDoc.data();
  //     // Message msgData = messageFromJson(lastDoc.data().toString());
  //     print("CCCCCCCCCCCCCCCCCCCCCCCC");
  //     print(data["msg"].toString());
  //     // UserLastMessageModel userBylastMessage = UserLastMessageModel(userId: msgData.fromId.toString(),  lastMessageContent: msgData.msg.toString(), lastMessageTime: DateTime.fromMillisecondsSinceEpoch(int.parse(msgData.sent.toString())));
  //     UserLastMessageModel userLastMessageModel = UserLastMessageModel();
  //     userLastMessageModel.lastMessageTime =
  //         DateTime.fromMillisecondsSinceEpoch(
  //             int.parse(data["sent"].toString()));
  //     userLastMessageModel.userId = data["from_id"].toString();
  //     userLastMessageModel.lastMessageContent = data["msg"].toString();
  //     // UserLastMessageModel(userId: data["from_id"]??"",lastMessageContent: data["msg"]??"",lastMessageTime:DateTime.fromMillisecondsSinceEpoch(int.parse(data["sent"].toString())));
  //     userInfo.lastMessage = userLastMessageModel;
  //     print(userInfo.lastMessage!.lastMessageTime.toString());
  //       chatList.remove(userInfo);
  //     chatList.add(userInfo);
  //     // chatList.add(userInfo);
  //     // print(InboxScreenController().chatList.length);
  //     // InboxScreenController().update();
  //
  //   }
  //   else {
  //     print("data nai");
  //
  //   }
  // }

  }