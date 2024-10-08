// To parse this JSON data, do
//
//     final buyerProfileModel = buyerProfileModelFromJson(jsonString);

import 'dart:convert';

BuyerProfileModel buyerProfileModelFromJson(String str) => BuyerProfileModel.fromJson(json.decode(str));

String buyerProfileModelToJson(BuyerProfileModel data) => json.encode(data.toJson());

class BuyerProfileModel {
  String? status;
  List<BuyerRunningOrder>? buyerRunningOrder;

  BuyerProfileModel({
    this.status,
    this.buyerRunningOrder,
  });

  factory BuyerProfileModel.fromJson(Map<String, dynamic> json) => BuyerProfileModel(
    status: json["status"],
    buyerRunningOrder: json["buyer_running_order"] == null ? [] : List<BuyerRunningOrder>.from(json["buyer_running_order"]!.map((x) => BuyerRunningOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "buyer_running_order": buyerRunningOrder == null ? [] : List<dynamic>.from(buyerRunningOrder!.map((x) => x.toJson())),
  };
}

class BuyerRunningOrder {
  String? jobId;
  String? offerId;
  String? serviceCategoryType;
  String? buyerId;
  String? sellerId;
  String? jobTitle;
  String? description;
  String? duration;
  String? packageName;
  String? serviceType;
  // int? rate;
  // int? quantity;
  int? price;
  String? status;
  DateTime? awardDate;

  BuyerRunningOrder({
    this.jobId,
    this.offerId,
    this.serviceCategoryType,
    this.buyerId,
    this.sellerId,
    this.jobTitle,
    this.description,
    this.duration,
    this.packageName,
    this.serviceType,
    // this.rateType,
    // this.rate,
    // this.quantity,
    this.price,
    this.status,
    this.awardDate,
  });

  factory BuyerRunningOrder.fromJson(Map<String, dynamic> json) => BuyerRunningOrder(
    jobId: json["job_id"],
    offerId: json["offer_id"],
    serviceCategoryType: json["service_category_type"],
    buyerId: json["buyer_id"],
    sellerId: json["seller_id"],
    jobTitle: json["job_title"],
    description: json["description"],
    duration: json["duration"],
    packageName: json["package_name"],
    serviceType: json["service_type"],
    // rate: json["rate"],
    // quantity: json["quantity"],
    price: json["price"],
    status: json["status"],
    awardDate: json["award_date"] == null ? null : DateTime.parse(json["award_date"]),
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "offer_id": offerId,
    "service_category_type": serviceCategoryType,
    "buyer_id": buyerId,
    "seller_id": sellerId,
    "job_title": jobTitle,
    "description": description,
    "duration": duration,
    "service_type": serviceType,
    "package_name": packageName,
    "total": price,
    "status": status,
    "award_date": "${awardDate!.year.toString().padLeft(4, '0')}-${awardDate!.month.toString().padLeft(2, '0')}-${awardDate!.day.toString().padLeft(2, '0')}",
  };
}
