// To parse this JSON data, do
//
//     final itemServiceModel = itemServiceModelFromJson(jsonString);

import 'dart:convert';

ItemServiceModel itemServiceModelFromJson(String str) => ItemServiceModel.fromJson(json.decode(str));

String itemServiceModelToJson(ItemServiceModel data) => json.encode(data.toJson());
class ItemServiceModel {
  String? title;
  String? userName;
  String? imageUrl;
  double? price;
  ItemServiceModel({
    this.title,
    this.userName,
    this.imageUrl,
    this.price,
  });
  factory ItemServiceModel.fromJson(Map<String, dynamic> json) => ItemServiceModel(
    title: json["title"],
    userName: json["user_name"],
    imageUrl: json["image_url"],
    price: json["price"].toDouble(),
  );
  Map<String, dynamic> toJson() => {
    "title": title,
    "user_name": userName,
    "image_url": imageUrl,
    "price": price,
  };
}
