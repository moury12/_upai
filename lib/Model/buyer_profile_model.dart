import 'package:upai/Model/seller_profile_model.dart';

class BuyerProfileModel {
  String? status;
  List<RunningOrder>? buyerRunningOrder;

  BuyerProfileModel({this.status, this.buyerRunningOrder});

  BuyerProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['buyer_running_order'] != null) {
      buyerRunningOrder = <RunningOrder>[];
      json['buyer_running_order'].forEach((v) {
        buyerRunningOrder!.add(new RunningOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.buyerRunningOrder != null) {
      data['buyer_running_order'] =
          this.buyerRunningOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
//
// class BuyerRunningOrder {
//   String? jobId;
//   String? buyerId;
//   String? sellerId;
//   String? jobTitle;
//   String? description;
//   String? rateType;
//   int? rate;
//   int? quantity;
//   int? total;
//   String? status;
//   String? awardDate;
//
//   BuyerRunningOrder(
//       {this.jobId,
//         this.buyerId,
//         this.sellerId,
//         this.jobTitle,
//         this.description,
//         this.rateType,
//         this.rate,
//         this.quantity,
//         this.total,
//         this.status,
//         this.awardDate});
//
//   BuyerRunningOrder.fromJson(Map<String, dynamic> json) {
//     jobId = json['job_id'];
//     buyerId = json['buyer_id'];
//     sellerId = json['seller_id'];
//     jobTitle = json['job_title'];
//     description = json['description'];
//     rateType = json['rate_type'];
//     rate = json['rate'];
//     quantity = json['quantity'];
//     total = json['total'];
//     status = json['status'];
//     awardDate = json['award_date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['job_id'] = this.jobId;
//     data['buyer_id'] = this.buyerId;
//     data['seller_id'] = this.sellerId;
//     data['job_title'] = this.jobTitle;
//     data['description'] = this.description;
//     data['rate_type'] = this.rateType;
//     data['rate'] = this.rate;
//     data['quantity'] = this.quantity;
//     data['total'] = this.total;
//     data['status'] = this.status;
//     data['award_date'] = this.awardDate;
//     return data;
//   }
// }