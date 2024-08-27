class SellerProfileModel {
  String? status;
  SellerProfile? sellerProfile;
  List<RunningOrder>? runningOrder;
  List<MyService>? myService;

  SellerProfileModel(
      {this.status, this.sellerProfile, this.runningOrder, this.myService});

  SellerProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sellerProfile = json['seller_profile'] != null
        ? SellerProfile.fromJson(json['seller_profile'])
        : null;
    if (json['running_order'] != null) {
      runningOrder = <RunningOrder>[];
      json['running_order'].forEach((v) {
        runningOrder!.add(RunningOrder.fromJson(v));
      });
    }
    if (json['my_service'] != null) {
      myService = <MyService>[];
      json['my_service'].forEach((v) {
        myService!.add(MyService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (sellerProfile != null) {
      data['seller_profile'] = sellerProfile!.toJson();
    }
    if (runningOrder != null) {
      data['running_order'] =
          runningOrder!.map((v) => v.toJson()).toList();
    }
    if (myService != null) {
      data['my_service'] = myService!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellerProfile {
  String? totalEarning;
  String? completedJob;
  String? review;

  SellerProfile({this.totalEarning, this.completedJob, this.review});

  SellerProfile.fromJson(Map<String, dynamic> json) {
    totalEarning = json['total_earning'];
    completedJob = json['completed_job'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_earning'] = totalEarning;
    data['completed_job'] = completedJob;
    data['review'] = review;
    return data;
  }
}

class RunningOrder {
  String? jobId;
  String? buyerId;
  String? sellerId;
  String? jobTitle;
  String? description;
  String? rateType;
  String? rate;
  int? quantity;
  int? total;
  String? status;
  String? awardDate;

  RunningOrder(
      {this.jobId,
        this.buyerId,
        this.sellerId,
        this.jobTitle,
        this.description,
        this.rateType,
        this.rate,
        this.quantity,
        this.total,
        this.status,
        this.awardDate});

  RunningOrder.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    buyerId = json['buyer_id'];
    sellerId = json['seller_id'];
    jobTitle = json['job_title'];
    description = json['description'];
    rateType = json['rate_type'];
    rate = json['rate'];
    quantity = json['quantity'];
    total = json['total'];
    status = json['status'];
    awardDate = json['award_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['buyer_id'] = buyerId;
    data['seller_id'] = sellerId;
    data['job_title'] = jobTitle;
    data['description'] = description;
    data['rate_type'] = rateType;
    data['rate'] = rate;
    data['quantity'] = quantity;
    data['total'] = total;
    data['status'] = status;
    data['award_date'] = awardDate;
    return data;
  }
}

class MyService {
  String? offerId;
  String? serviceCategoryType;
  String? dateTime;
  String? userId;
  String? userName;
  String? jobTitle;
  String? description;
  int? quantity;
  String? rateType;
  int? rate;
  String? district;
  String? address;

  MyService(
      {this.offerId,
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
        this.address});

  MyService.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    serviceCategoryType = json['service_category_type'];
    dateTime = json['date_time'];
    userId = json['user_id'];
    userName = json['user_name'];
    jobTitle = json['job_title'];
    description = json['description'];
    quantity = json['quantity'];
    rateType = json['rate_type'];
    rate = json['rate'];
    district = json['district'];
    address = json['address'];
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
    data['quantity'] = quantity;
    data['rate_type'] = rateType;
    data['rate'] = rate;
    data['district'] = district;
    data['address'] = address;
    return data;
  }
}
