// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String? offerId;
  String? buyerMobile;
  String? sellerMobile;
  String? jobTitle;
  String? description;
  String? rateType;
  String? rate;
  String? quantity;
  String? total;
  String? status;
  String? read;

  NotificationModel({
    this.offerId,
    this.buyerMobile,
    this.sellerMobile,
    this.jobTitle,
    this.description,
    this.rateType,
    this.rate,
    this.quantity,
    this.total,
    this.status,
    this.read,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    offerId: json["offer_id"],
    buyerMobile: json["buyer_mobile"],
    sellerMobile: json["seller_mobile"],
    jobTitle: json["job_title"],
    description: json["description"],
    rateType: json["rate_type"],
    rate: json["rate"],
    quantity: json["quantity"],
    total: json["total"],
    status: json["status"],
    read: json["read"]??"",
  );

  Map<String, dynamic> toJson() => {
    "offer_id": offerId,
    "buyer_mobile": buyerMobile,
    "seller_mobile": sellerMobile,
    "job_title": jobTitle,
    "description": description,
    "rate_type": rateType,
    "rate": rate,
    "quantity": quantity,
    "total": total,
    "status": status,
    "read": read,
  };
}
