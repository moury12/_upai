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
  String? userName;
  int? totalCompletedJob;
  dynamic avgRating;
  String? jobTitle;
  String? description;
  int? quantity;
  String? rateType;
  int? rate;
  String? district;
  String? address;
  List<BuyerReviewList>? buyerReviewList;

  OfferList({
    this.offerId,
    this.serviceCategoryType,
    this.dateTime,
    this.userId,
    this.userName,
    this.totalCompletedJob,
    this.avgRating,
    this.jobTitle,
    this.description,
    this.quantity,
    this.rateType,
    this.rate,
    this.district,
    this.address,
    this.buyerReviewList,
  });

  factory OfferList.fromJson(Map<String, dynamic> json) => OfferList(
    offerId: json["offer_id"],
    serviceCategoryType: json["service_category_type"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
    userId: json["user_id"],
    userName: json["user_name"],
    totalCompletedJob: json["total_completed_job"],
    avgRating: json["avg_rating"],
    jobTitle: json["job_title"],
    description: json["description"],
    quantity: json["quantity"],
    rateType: json["rate_type"],
    rate: json["rate"],
    district: json["district"],
    address: json["address"],
    buyerReviewList: json["buyer_review_list"] == null ? [] : List<BuyerReviewList>.from(json["buyer_review_list"]!.map((x) => BuyerReviewList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "offer_id": offerId,
    "service_category_type": serviceCategoryType,
    "date_time": dateTime?.toIso8601String(),
    "user_id": userId,
    "user_name": userName,
    "total_completed_job": totalCompletedJob,
    "avg_rating": avgRating,
    "job_title": jobTitle,
    "description": description,
    "quantity": quantity,
    "rate_type": rateType,
    "rate": rate,
    "district": district,
    "address": address,
    "buyer_review_list": buyerReviewList == null ? [] : List<dynamic>.from(buyerReviewList!.map((x) => x.toJson())),
  };
}

class BuyerReviewList {
  String? buyerId;
  String? buyerReview;
  dynamic buyerRating;
  String? buyerName;
  DateTime? reviewDate;

  BuyerReviewList({
    this.buyerId,
    this.buyerReview,
    this.buyerRating,
    this.buyerName,
    this.reviewDate,
  });

  factory BuyerReviewList.fromJson(Map<String, dynamic> json) => BuyerReviewList(
    buyerId: json["buyer_id"],
    buyerReview: json["buyer_review"],
    buyerRating: json["buyer_rating"],
    buyerName: json["buyer_name"],
    reviewDate: json["review_date"] == null ? null : DateTime.parse(json["review_date"]),
  );

  Map<String, dynamic> toJson() => {
    "buyer_id": buyerId,
    "buyer_review": buyerReview,
    "buyer_rating": buyerRating,
    "buyer_name": buyerName,
    "review_date": "${reviewDate!.year.toString().padLeft(4, '0')}-${reviewDate!.month.toString().padLeft(2, '0')}-${reviewDate!.day.toString().padLeft(2, '0')}",
  };
}
