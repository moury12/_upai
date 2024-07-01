import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController{
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  TextEditingController messageController = TextEditingController();
  String? messageId;
  String? chatRoomId;
  bool showEmoji = false;

}