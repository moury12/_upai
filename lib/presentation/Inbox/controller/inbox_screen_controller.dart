
import 'dart:math';

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


}