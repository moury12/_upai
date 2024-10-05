// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String? notificationId;
  String? notificationTitle;
  String? notificationMsg;
  String? offerId;
  String? jobId;
  String? buyerId;
  String? buyerName;
  String? sellerId;
  String? sellerName;
  String? jobTitle;
  String? description;
  String? price;
  String? package;
  String? status;
  String? createdTime;

  NotificationModel({
    this.notificationId,
    this.notificationTitle,
    this.notificationMsg,
    this.offerId,
    this.jobId,
    this.buyerId,
    this.buyerName,
    this.sellerId,
    this.sellerName,
    this.jobTitle,
    this.description,
    this.price,
    this.package,
    this.status,
    this.createdTime,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    notificationId: json["notification_id"]??"",
    notificationTitle: json["notification_title"]??"",
    notificationMsg: json["notification_msg"]??"",
    offerId: json["offer_id"]??"",
    jobId: json["job_id"]??"",
    buyerId: json["buyer_id"]??"",
    buyerName: json["buyer_name"]??"",
    sellerId: json["seller_id"]??"",
    sellerName: json["seller_name"]??"",
    jobTitle: json["job_title"]??"",
    description: json["description"]??"",
    price: json["price"]??"",
    package: json["package_name"]??"",
    status: json["status"]??"",
    createdTime: json["created_time"]??"",
  );

  Map<String, dynamic> toJson() => {
    "notification_id": notificationId,
    "notification_title": notificationTitle,
    "notification_msg": notificationMsg,
    "offer_id": offerId,
    "job_id": jobId,
    "buyer_id": buyerId,
    "buyer_name": buyerName,
    "seller_id": sellerId,
    "seller_name": sellerName,
    "job_title": jobTitle,
    "description": description,
    "price": price,
    "package_name": package,
    "status": status,
    "created_time": createdTime,
  };
}
