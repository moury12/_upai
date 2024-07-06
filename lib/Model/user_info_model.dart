// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

import 'package:upai/core/utils/image_path.dart';

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
    image: json["image"]??'https://img.freepik.com/free-photo/young-man-with-glasses-bow-tie-3d-rendering_1142-43322.jpg?t=st=1720243349~exp=1720246949~hmac=313470ceb91cfcf0621b84a20f2738fbbd35f6c71907fcaefb6b0fd0b321c374&w=740',
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
