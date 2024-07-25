// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
  String? status;
  String? message;
  List<CategoryList>? categoryList;

  CategoryListModel({
    this.status,
    this.message,
    this.categoryList,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
    status: json["status"],
    message: json["message"],
    categoryList: json["categoryList"] == null ? [] : List<CategoryList>.from(json["categoryList"]!.map((x) => CategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "categoryList": categoryList == null ? [] : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
  };
}

class CategoryList {
  String? categoryId;
  String? categoryName;
  String? description;

  CategoryList({
    this.categoryId,
    this.categoryName,
    this.description,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "description": description,
  };
}
