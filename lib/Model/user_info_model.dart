// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  String? id;
  String? userId;
  String? userName;
  String? userEmail;
  String? image;
  bool? isOnline;
  String? lastActive;
  String? pushToken;

  UserInfoModel({
    this.id,
    this.userId,
    this.userName,
    this.userEmail,
    this.image,
    this.isOnline,
    this.lastActive,
    this.pushToken,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    id: json["id"] ?? '',
    userId: json["user_id"]?? '',
    userName: json["user_name"]?? 'User Name',
    userEmail: json["user_email"]?? 'example@gamil.com' ,
    image: json["image"]?? '',
    isOnline: json["is_online"]??false,
    lastActive: json["last_active"]?? '',
    pushToken: json["push_token"]?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "user_name": userName,
    "user_email": userEmail,
    "image": image,
    "is_online": isOnline,
    "last_active": lastActive,
    "push_token": pushToken,
  };
}
