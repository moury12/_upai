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
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    cid: json["cid"]??'UPAI',
    userId: json["user_id"]??'',
    name: json["name"]??'Unknown User',
    mobile: json["mobile"]??'0100000000',
    email: json["email"]??'example@gmail.com',
    image: json["image"]??'https://img.freepik.com/free-photo/young-man-with-glasses-bow-tie-3d-rendering_1142-43322.jpg?t=st=1720243349~exp=1720246949~hmac=313470ceb91cfcf0621b84a20f2738fbbd35f6c71907fcaefb6b0fd0b321c374&w=740',
    isOnline: json["is_online"]??false,
    lastActive: json["last_active"]??'',
    pushToken: json["push_token"]??'',
    token: json["token"]??'',
    userType: json["user_type"]??'Buyer',

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
  };
}
