import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/presentation/ChatScreen/Model/message_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreenController extends GetxController{
  List<Message> messageList = [];

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
  Future<void> makePhoneCall(String phoneNumber) async {
    print("calling $phoneNumber");
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if(await canLaunchUrl(launchUri))
      {
        await launchUrl(launchUri);
      }
    else
      {
        print("error");
      }

  }

}