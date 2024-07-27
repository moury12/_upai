// To parse this JSON data, do
//
//     final offerListModel = offerListModelFromJson(jsonString);

import 'dart:convert';

OfferListModel offerListModelFromJson(String str) => OfferListModel.fromJson(json.decode(str));

String offerListModelToJson(OfferListModel data) => json.encode(data.toJson());

class OfferListModel {
  String? status;
  String? message;
  List<OfferList>? offerList;

  OfferListModel({
    this.status,
    this.message,
    this.offerList,
  });

  factory OfferListModel.fromJson(Map<String, dynamic> json) => OfferListModel(
    status: json["status"],
    message: json["message"],
    offerList: json["offerList"] == null ? [] : List<OfferList>.from(json["offerList"]!.map((x) => OfferList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "offerList": offerList == null ? [] : List<dynamic>.from(offerList!.map((x) => x.toJson())),
  };
}

class OfferList {
  String? offerId;
  String? serviceCategoryType;
  DateTime? dateTime;
  String? userId;
  String? jobTitle;
  String? description;
  int? quantity;
  String? rateType;
  int? rate;

  OfferList({
    this.offerId,
    this.serviceCategoryType,
    this.dateTime,
    this.userId,
    this.jobTitle,
    this.description,
    this.quantity,
    this.rateType,
    this.rate,
  });

  factory OfferList.fromJson(Map<String, dynamic> json) => OfferList(
    offerId: json["offer_id"],
    serviceCategoryType: json["service_category_type"]??'Default',
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
    userId: json["user_id"],
    jobTitle: json["job_title"],
    description: json["description"],
    quantity: json["quantity"],
    rateType: json["rate_type"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "offer_id": offerId,
    "service_category_type": serviceCategoryType,
    "date_time": dateTime?.toIso8601String(),
    "user_id": userId,
    "job_title": jobTitle,
    "description": description,
    "quantity": quantity,
    "rate_type": rateType,
    "rate": rate,
  };
}
