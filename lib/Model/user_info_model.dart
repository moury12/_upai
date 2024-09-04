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
  UserLastMessageModel? lastMessage;

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
    this.lastMessage,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    cid: json["cid"] ?? 'UPAI',
    userId: json["user_id"] ?? '',
    name: json["name"] ?? 'Unknown User',
    mobile: json["mobile"] ?? '0100000000',
    email: json["email"] ?? 'example@gmail.com',
    image: json["image"] ?? 'https://img.freepik.com/free-photo/young-man-with-glasses-bow-tie-3d-rendering_1142-43322.jpg?t=st=1720243349~exp=1720246949~hmac=313470ceb91cfcf0621b84a20f2738fbbd35f6c71907fcaefb6b0fd0b321c374&w=740',
    isOnline: json["is_online"] ?? false,
    lastActive: json["last_active"] ?? '',
    pushToken: json["push_token"] ?? '',
    token: json["token"] ?? '',
    userType: json["user_type"] ?? 'Buyer',
    lastMessage: json["last_message"] != null
        ? UserLastMessageModel.fromJson(json["last_message"])
        : null,
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
    "user_type": userType,
    "last_message": lastMessage?.toJson(),
  };
}
class UserLastMessageModel {
   String? userId;
   String? lastMessageContent;
   DateTime? lastMessageTime;

  UserLastMessageModel({
    this.userId,
    this.lastMessageContent,
    this.lastMessageTime,
  });

  factory UserLastMessageModel.fromJson(Map<String, dynamic> json) =>
      UserLastMessageModel(
        userId: json["user_id"] ??"",
        lastMessageContent: json["last_message_content"]??"",
        lastMessageTime: json["last_message_time"] != null
            ? DateTime.parse(json["last_message_time"] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "last_message_content": lastMessageContent,
    "last_message_time": lastMessageTime?.toIso8601String(),
  };
}

//
// class UserLastMessageModel {
//   final String userId;
//   final String lastMessageContent;
//   final DateTime lastMessageTime;
//
//   UserLastMessageModel({
//     required this.userId,
//     required this.lastMessageContent,
//     required this.lastMessageTime,
//   });
//
//   factory UserLastMessageModel.fromJson(Map<String, dynamic> json) =>
//       UserLastMessageModel(
//         userId: json["user_id"],
//         lastMessageContent: json["last_message_content"],
//         lastMessageTime: DateTime.parse(json["last_message_time"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//     "user_id": userId,
//     "last_message_content": lastMessageContent,
//     "last_message_time": lastMessageTime.toIso8601String(),
//   };
// }