import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/presentation/ChatScreen/Model/message_model.dart';

class ChatScreenController extends GetxController{
  List<Message> messageList = [];
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  TextEditingController messageController = TextEditingController();
  String? messageId;
  String? chatRoomId;
  bool showEmoji = false;
  int lineCount=2;

  @override
  void onClose() {
    messageController.dispose();
    // TODO: implement onClose
    super.onClose();
  }

}