

import 'package:get/get.dart';
import 'package:upai/Model/notification_model.dart';

class NotificationController extends GetxController{
  static NotificationController get to => Get.find();

  List<NotificationModel> notificationList = [];
}