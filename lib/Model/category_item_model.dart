// To parse this JSON data, do
//
//     final categoryItemModel = categoryItemModelFromJson(jsonString);

import 'dart:convert';

CategoryItemModel categoryItemModelFromJson(String str) => CategoryItemModel.fromJson(json.decode(str));

String categoryItemModelToJson(CategoryItemModel data) => json.encode(data.toJson());

class CategoryItemModel {
  String? catType;
  String? imageUrl;

  CategoryItemModel({
    this.catType,
    this.imageUrl,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) => CategoryItemModel(
    catType: json["cat_type"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "cat_type": catType,
    "image_url": imageUrl,
  };
}
