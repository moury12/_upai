// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  String? cid;
  String? userId;
  String? name;
  String? mobile;
  String? email;
  String? image;
  bool? isOnline;
  String? lastActive;
  String? pushToken;
  String? token;
  String? userType;
  DateTime? lastMsgSent;
  UserInfoModel({
    this.cid,
    this.userId,
    this.name,
    this.mobile,
    this.email,
    this.image,
    this.isOnline,
    this.lastActive,
    this.pushToken,
    this.token,
    this.userType,
    this.lastMsgSent,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    cid: json["cid"]??'UPAI',
    userId: json["user_id"]??'',
    name: json["name"]??'Unknown User',
    mobile: json["mobile"]??'0100000000',
    email: json["email"]??'example@gmail.com',
    image: json["image"]??"https://firebasestorage.googleapis.com/v0/b/chatappprac-d7a2b.appspot.com/o/ProfileImages%2FdummyProfile%2F9685678.jpg?alt=media&token=af503c8a-fa2a-45d1-9af4-8a3c81f4f227",
    isOnline: json["is_online"]??false,
    lastActive: json["last_active"]??'',
    pushToken: json["push_token"]??'',
    token: json["token"]??'',
    userType: json["user_type"]??'Buyer',
    lastMsgSent: json["last_msg_sent"] == null ? null : DateTime.parse(json["last_msg_sent"]),

  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "user_id": userId,
    "name": name,
    "mobile": mobile,
    "email": email,
    "image": image,
    "is_online": isOnline,
    "last_active": lastActive,
    "push_token": pushToken,
    "token": token,
    "user_type":userType,
    "last_msg_sent": lastMsgSent?.toIso8601String(),
  };
}
