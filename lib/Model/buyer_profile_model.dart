// To parse this JSON data, do
//
//     final buyerProfileModel = buyerProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:upai/Model/seller_profile_model.dart';

BuyerProfileModel buyerProfileModelFromJson(String str) =>
    BuyerProfileModel.fromJson(json.decode(str));

String buyerProfileModelToJson(BuyerProfileModel data) =>
    json.encode(data.toJson());

class BuyerProfileModel {
  String? status;
  List<SellerRunningOrder>? buyerRunningOrder;

  BuyerProfileModel({
    this.status,
    this.buyerRunningOrder,
  });

  factory BuyerProfileModel.fromJson(Map<String, dynamic> json) =>
      BuyerProfileModel(
        status: json["status"],
        buyerRunningOrder: json["buyer_running_order"] == null
            ? []
            : List<SellerRunningOrder>.from(json["buyer_running_order"]!
                .map((x) => SellerRunningOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "buyer_running_order": buyerRunningOrder == null
            ? []
            : List<dynamic>.from(buyerRunningOrder!.map((x) => x.toJson())),
      };
}
