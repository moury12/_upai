// To parse this JSON data, do
//
//     final offerListModel = offerListModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:upai/Boxes/boxes.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';

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
  String? dateTime;
  String? userId;
  String? userName;
  String? totalCompletedJob;
  String? avgRating;
  String? jobTitle;
  String? description;
  String? district;
  String? address;
  String? serviceType;
  bool? isFav; // This should be non-nullable but initialized properly.
  List<Package>? package;
  List<BuyerReviewList>? buyerReviewList;

  // Constructor to initialize isFav
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
    this.district,
    this.address,
    this.serviceType,
    this.package,
    this.buyerReviewList,
    this.isFav, // Use a default parameter for the constructor
  }) /*: isFav = isFav.obs*/; // Initialize isFav as an RxBool

  // Factory constructor to create an OfferList from JSON
  factory OfferList.fromJson(Map<String, dynamic> json) {
    // Parse all fields
    return OfferList(
      offerId: json['offer_id']?.toString() == 'null' ? '' : json['offer_id'].toString(),
      serviceCategoryType: json['service_category_type']?.toString() == 'null' ? '' : json['service_category_type'].toString(),
      dateTime: json['date_time']?.toString() == 'null' ? '' : json['date_time'].toString(),
      userId: json['user_id']?.toString() == 'null' ? '' : json['user_id'].toString(),
      userName: json['user_name']?.toString() == 'null' ? '' : json['user_name'].toString(),
      totalCompletedJob: json['total_completed_job']?.toString() == 'null' ? '' : json['total_completed_job'].toString(),
      avgRating: json['avg_rating']?.toString() == 'null' ? '' : json['avg_rating'].toString(),
      jobTitle: json['job_title']?.toString() == 'null' ? '' : json['job_title'].toString(),
      description: json['description']?.toString() == 'null' ? '' : json['description'].toString(),
      district: json['district']?.toString() == 'null' ? '' : json['district'].toString(),
      address: json['address']?.toString() == 'null' ? '' : json['address'].toString(),
      serviceType: json['service_type']?.toString() == 'null' ? '' : json['service_type'].toString(),
      isFav: Boxes.getFavBox().containsKey(json['offer_id']), // Default to false, as unfavored
      // Handle package parsing
        package: json['package'] != null
            ? (json['package'] as List).map((v) => Package.fromJson(v)).toList()
            : null,
        // Handle buyer review list parsing
      buyerReviewList: json['buyer_review_list'] != null
            ? (json['buyer_review_list'] as List).map((v) => BuyerReviewList.fromJson(v)).toList()
            : null,

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offer_id'] = offerId;
    data['service_category_type'] = serviceCategoryType;
    data['date_time'] = dateTime;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['total_completed_job'] = totalCompletedJob;
    data['avg_rating'] = avgRating;
    data['job_title'] = jobTitle;
    data['description'] = description;
    data['district'] = district;
    data['address'] = address;
    data['service_type'] = serviceType;
    data['is_fav'] = isFav;
    if (package != null) {
      data['package'] = package!.map((v) => v.toJson()).toList();
    }
    if (buyerReviewList != null) {
      data['buyer_review_list'] = buyerReviewList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Package {
  String? packageName;
  String? price;
  String? duration;
  String? packageDescription;
  List<ServiceList>? serviceList;

  Package(
      {this.packageName,
        this.price,
        this.duration,
        this.packageDescription,
        this.serviceList});

  Package.fromJson(Map<String, dynamic> json) {
    packageName = json['package_name'].toString()=='null'?'':json['package_name'].toString();
    price = json['price'].toString()=='null'?'':json['price'].toString();
    duration = json['duration'].toString()=='null'?'':json['duration'].toString();
    packageDescription = json['package_description'].toString()=='null'?'':json['package_description'].toString();
    if (json['service_list'] != null) {
      serviceList = <ServiceList>[];
      json['service_list'].forEach((v) {
        serviceList!.add(ServiceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_name'] = packageName;
    data['price'] = price;
    data['duration'] = duration;
    data['package_description'] = packageDescription;
    if (serviceList != null) {
      data['service_list'] = serviceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceList {
  String? serviceName;
  String? status;

  ServiceList({this.serviceName, this.status});

  ServiceList.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'].toString()=='null'?'':json['service_name'].toString();
    status = json['status'].toString()=='null'?'':json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_name'] = serviceName;
    data['status'] = status;
    return data;
  }
}

class BuyerReviewList {
  String? buyerId;
  String? buyerReview;
  String? buyerRating;
  String? buyerName;
  String? reviewDate;

  BuyerReviewList(
      {this.buyerId,
        this.buyerReview,
        this.buyerRating,
        this.buyerName,
        this.reviewDate});

  BuyerReviewList.fromJson(Map<String, dynamic> json) {
    buyerId = json['buyer_id'].toString()=='null'?'':json['buyer_id'].toString();
    buyerReview = json['buyer_review'].toString()=='null'?'':json['buyer_review'].toString();
    buyerRating = json['buyer_rating'].toString()=='null'?'':json['buyer_rating'].toString();
    buyerName = json['buyer_name'].toString()=='null'?'':json['buyer_name'].toString();
    reviewDate = json['review_date'].toString()=='null'?'':json['review_date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['buyer_id'] = buyerId;
    data['buyer_review'] = buyerReview;
    data['buyer_rating'] = buyerRating;
    data['buyer_name'] = buyerName;
    data['review_date'] = reviewDate;
    return data;
  }
}

