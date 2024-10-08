// To parse this JSON data, do
//
//     final sellerProfileModel = sellerProfileModelFromJson(jsonString);

import 'dart:convert';

SellerProfileModel sellerProfileModelFromJson(String str) => SellerProfileModel.fromJson(json.decode(str));

String sellerProfileModelToJson(SellerProfileModel data) => json.encode(data.toJson());

class SellerProfileModel {
  String? status;
  SellerProfile? sellerProfile;
  List<SellerRunningOrder>? sellerRunningOrder;
  List<MyService>? myService;

  SellerProfileModel({
    this.status,
    this.sellerProfile,
    this.sellerRunningOrder,
    this.myService,
  });

  factory SellerProfileModel.fromJson(Map<String, dynamic> json) => SellerProfileModel(
    status: json["status"],
    sellerProfile: json["seller_profile"] == null ? null : SellerProfile.fromJson(json["seller_profile"]),
    sellerRunningOrder: json["running_order"] == null ? [] : List<SellerRunningOrder>.from(json["running_order"]!.map((x) => SellerRunningOrder.fromJson(x))),
    myService: json["my_service"] == null ? [] : List<MyService>.from(json["my_service"]!.map((x) => MyService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "seller_profile": sellerProfile?.toJson(),
    "running_order": sellerRunningOrder == null ? [] : List<dynamic>.from(sellerRunningOrder!.map((x) => x.toJson())),
    "my_service": myService == null ? [] : List<dynamic>.from(myService!.map((x) => x.toJson())),
  };
}

class MyService {
  String? offerId;
  String? serviceCategoryType;
  String? dateTime;
  String? userId;
  String? userName;
  String? jobTitle;
  String? description;
  String? district;
  String? address;
  List<Package>? package;

  MyService(
      {this.offerId,
        this.serviceCategoryType,
        this.dateTime,
        this.userId,
        this.userName,
        this.jobTitle,
        this.description,
        this.district,
        this.address,
        this.package});

  MyService.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    serviceCategoryType = json['service_category_type'];
    dateTime = json['date_time'];
    userId = json['user_id'];
    userName = json['user_name'];
    jobTitle = json['job_title'];
    description = json['description'];
    district = json['district'];
    address = json['address'];
    if (json['package'] != null) {
      package = <Package>[];
      json['package'].forEach((v) {
        package!.add(Package.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offer_id'] = offerId;
    data['service_category_type'] = serviceCategoryType;
    data['date_time'] = dateTime;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['job_title'] = jobTitle;
    data['description'] = description;
    data['district'] = district;
    data['address'] = address;
    if (package != null) {
      data['package'] = package!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Package {
  String? packageName;
  int? price;
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
    packageName = json['package_name'];
    price = json['price'];
    duration = json['duration'];
    packageDescription = json['package_description'];
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
    serviceName = json['service_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_name'] = serviceName;
    data['status'] = status;
    return data;
  }
}

class SellerRunningOrder {
  String? jobId;
  String? offerId;
  String? serviceCategoryType;
  String? buyerId;
  String? sellerId;
  String? jobTitle;
  String? description;
  String? packageName;
  // int? rate;
  // int? quantity;
  int? price;
  String? status;
  DateTime? awardDate;

  SellerRunningOrder({
    this.jobId,
    this.offerId,
    this.serviceCategoryType,
    this.buyerId,
    this.sellerId,
    this.jobTitle,
    this.description,
    this.packageName,
    // this.rate,
    // this.quantity,
    this.price,
    this.status,
    this.awardDate,
  });

  factory SellerRunningOrder.fromJson(Map<String, dynamic> json) => SellerRunningOrder(
    jobId: json["job_id"],
    offerId: json["offer_id"],
    serviceCategoryType: json["service_category_type"],
    buyerId: json["buyer_id"],
    sellerId: json["seller_id"],
    jobTitle: json["job_title"],
    description: json["description"],
    packageName: json["package_name"],
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
    "package_name": packageName,
    "duration": packageName,
    // "rate": rate,
    // "quantity": quantity,
    "price": price,
    "status": status,
    "award_date": "${awardDate!.year.toString().padLeft(4, '0')}-${awardDate!.month.toString().padLeft(2, '0')}-${awardDate!.day.toString().padLeft(2, '0')}",
  };
}
class SellerProfile {
  String? totalEarning;
  String? completedJob;
  double? review;

  SellerProfile({
    this.totalEarning,
    this.completedJob,
    this.review,
  });

  factory SellerProfile.fromJson(Map<String, dynamic> json) => SellerProfile(
    totalEarning: json["total_earning"]??"0",
    completedJob: json["completed_job"]??"0",
    review: json["review"]?.toDouble()??0.0,
  );

  Map<String, dynamic> toJson() => {
    "total_earning": totalEarning,
    "completed_job": completedJob,
    "review": review,
  };
}
