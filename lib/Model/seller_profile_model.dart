// To parse this JSON data, do
//
//     final sellerProfileModel = sellerProfileModelFromJson(jsonString);

import 'dart:convert';

SellerProfileModel sellerProfileModelFromJson(String str) => SellerProfileModel.fromJson(json.decode(str));

String sellerProfileModelToJson(SellerProfileModel data) => json.encode(data.toJson());

class SellerProfileModel {
  String? status;
  SellerProfile? sellerProfile;
  List<RunningOrder>? runningOrder;
  List<MyService>? myService;

  SellerProfileModel({
    this.status,
    this.sellerProfile,
    this.runningOrder,
    this.myService,
  });

  factory SellerProfileModel.fromJson(Map<String, dynamic> json) => SellerProfileModel(
    status: json["status"],
    sellerProfile: json["seller_profile"] == null ? null : SellerProfile.fromJson(json["seller_profile"]),
    runningOrder: json["running_order"] == null ? [] : List<RunningOrder>.from(json["running_order"]!.map((x) => RunningOrder.fromJson(x))),
    myService: json["my_service"] == null ? [] : List<MyService>.from(json["my_service"]!.map((x) => MyService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "seller_profile": sellerProfile?.toJson(),
    "running_order": runningOrder == null ? [] : List<dynamic>.from(runningOrder!.map((x) => x.toJson())),
    "my_service": myService == null ? [] : List<dynamic>.from(myService!.map((x) => x.toJson())),
  };
}

class MyService {
  String? offerId;
  String? serviceCategoryType;
  DateTime? dateTime;
  String? userId;
  String? userName;
  String? jobTitle;
  String? description;
  int? quantity;
  String? rateType;
  int? rate;
  String? district;
  String? address;

  MyService({
    this.offerId,
    this.serviceCategoryType,
    this.dateTime,
    this.userId,
    this.userName,
    this.jobTitle,
    this.description,
    this.quantity,
    this.rateType,
    this.rate,
    this.district,
    this.address,
  });

  factory MyService.fromJson(Map<String, dynamic> json) => MyService(
    offerId: json["offer_id"],
    serviceCategoryType: json["service_category_type"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
    userId: json["user_id"],
    userName: json["user_name"],
    jobTitle: json["job_title"],
    description: json["description"],
    quantity: json["quantity"],
    rateType: json["rate_type"],
    rate: json["rate"],
    district: json["district"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "offer_id": offerId,
    "service_category_type": serviceCategoryType,
    "date_time": dateTime?.toIso8601String(),
    "user_id": userId,
    "user_name": userName,
    "job_title": jobTitle,
    "description": description,
    "quantity": quantity,
    "rate_type": rateType,
    "rate": rate,
    "district": district,
    "address": address,
  };
}

class RunningOrder {
  String? jobId;
  String? buyerId;
  String? sellerId;
  String? jobTitle;
  String? description;
  String? rateType;
  int? rate;
  int? quantity;
  int? total;
  String? status;
  String? awardDate;

  RunningOrder({
    this.jobId,
    this.buyerId,
    this.sellerId,
    this.jobTitle,
    this.description,
    this.rateType,
    this.rate,
    this.quantity,
    this.total,
    this.status,
    this.awardDate,
  });

  factory RunningOrder.fromJson(Map<String, dynamic> json) => RunningOrder(
    jobId: json["job_id"],
    buyerId: json["buyer_id"],
    sellerId: json["seller_id"],
    jobTitle: json["job_title"],
    description: json["description"],
    rateType: json["rate_type"],
    rate: json["rate"],
    quantity: json["quantity"],
    total: json["total"],
    status: json["status"],
    awardDate: json["award_date"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "buyer_id": buyerId,
    "seller_id": sellerId,
    "job_title": jobTitle,
    "description": description,
    "rate_type": rateType,
    "rate": rate,
    "quantity": quantity,
    "total": total,
    "status": status,
    "award_date": awardDate,
  };
}

class SellerProfile {
  String? totalEarning;
  String? completedJob;
  String? review;

  SellerProfile({
    this.totalEarning,
    this.completedJob,
    this.review,
  });

  factory SellerProfile.fromJson(Map<String, dynamic> json) => SellerProfile(
    totalEarning: json["total_earning"],
    completedJob: json["completed_job"],
    review: json["review"],
  );

  Map<String, dynamic> toJson() => {
    "total_earning": totalEarning,
    "completed_job": completedJob,
    "review": review,
  };
}
