import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/buyer_profile_model.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/notification_model.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/presentation/create-offer/controller/create_offer_controller.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
import '../../Boxes/boxes.dart';
import '../../Model/user_info_model.dart';
import '../../presentation/Profile/profile_screen_controller.dart';
import '../../presentation/seller-service/controller/seller_profile_controller.dart';
import '/data/api/api_client.dart';

import 'package:http/http.dart' as http;

class RepositoryData {
  List<CategoryList> catList = [];
  List<OfferList> offerList = [];

  final apiClient = ApiClient();
  final box = Hive.box('userInfo');
  // @override
  // Future<List<ProductDetailsModel>> returnData() async {
  //   var res = await rootBundle.loadString("assets/response.json");
  //   var data = productDetailsModelFromJson(res);
  //   print(data.length);
  //   return data;
  // }
Future<void> getDMPathData() async{
  Map<String,dynamic> dmPathData ={};
  String dmPathBaseUrl ="";
  String dmPathApi = 'https://w05.yeapps.com/dmpath/upai_dmpath/get_dmpath';
  try{
    final response = await http.get(Uri.parse(dmPathApi));
    if(response.statusCode ==200){
      dmPathData = jsonDecode(response.body);
      dmPathBaseUrl= dmPathData['base-url'];
      await Boxes.getDmPathBox().put('base_url', dmPathBaseUrl);

    }
  }catch(e){
    debugPrint('${e.toString()} in ${dmPathApi}');
    throw Exception(e);
  }

}
  Future<void> login(
      String CID, String userMobile, String password) async {
    String url = ApiClient().loginUrl;
log(url);
    try {

      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {"cid": "UPAI", "user_mobile": userMobile, "user_pass": password}),
      );

      final data = jsonDecode(response.body);
      print(password);
      if (data["status"].toString() == 'Success') {
        showCustomSnackbar(
            title: 'Success',
            message:"logged in successfully",
            type: SnackBarType.success);

        UserInfoModel userInfo = UserInfoModel();
        userInfo.cid = CID;
        userInfo.name = data['user_info']['name'].toString();
        userInfo.userId = data["user_info"]["user_id"];
        userInfo.email = data['user_info']['email'].toString();
        userInfo.mobile = data['user_info']['mobile'].toString();
        userInfo.token = data['token'].toString();

        await box.put('user', json.encode(userInfo.toJson()));

        print("value is  : ${box.get("user")}");
        print("&&&&&&&&&&&&&&&&&&&");
        print(box.values);
        //FirebaseAPIs.currentUser();
        FirebaseAPIs.user = userInfo.toJson();
        if (!await FirebaseAPIs.userExists()) {
          await FirebaseAPIs.createUser(userInfo.toJson());
          FirebaseAPIs.updateActiveStatus(true);


          Get.offAndToNamed("/defaultscreen");
        } else {
          FirebaseAPIs.updateActiveStatus(true);
          // FirebaseAPIs.getSelfInfo();
          Get.offAndToNamed("/defaultscreen");
        }
      } else {
        showCustomSnackbar(
            title: 'Failed',
            message: data["message"],
            type: SnackBarType.failed);
      }
      // var loginResponse = loginResponseModelFromJson(response.);
      print(response);
    } catch (e) {
      // handleError(e);
      print(e.toString());
      showCustomSnackbar(
          title: 'Failed',
          message:e.toString(),
          type: SnackBarType.failed);
      //throw Exception('Error in login: $e');
    }
  }



  static Future<SellerProfileModel> getSellerProfile(
      String token, String userId) async {
    SellerProfileModel sellerProfileModel = SellerProfileModel();
    try {
      final response = await http.get(
          Uri.parse('${ApiClient().sellerProfile}?user_id=$userId'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // debugPrint('seller profile $responseData');
      if (responseData['status'] != null &&
          responseData['status'] == "Success") {
        sellerProfileModel = SellerProfileModel.fromJson(responseData);
      } else {
        debugPrint('Failed to load data');
      }
      return sellerProfileModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<BuyerProfileModel> getBuyerProfile(
      String token, String userId) async {
    BuyerProfileModel buyerProfileModel = BuyerProfileModel();
    try {
      final response = await http.get(
          Uri.parse('${ApiClient().buyerProfile}?user_id=$userId'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      debugPrint('buyer profile $responseData');
      if (responseData['status'] != null &&
          responseData['status'] == "Success") {
        buyerProfileModel = BuyerProfileModel.fromJson(responseData);
      } else {
        debugPrint('failed');
      }
      return buyerProfileModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryList>> getCategoryList({
    required String token,
    required String userId,
  }) async {
    try {
      String url =
          "${ApiClient().getCategoryList}?cid=upai&user_mobile=$userId";
      if (kDebugMode) {
        print('++++++++++get category list url :----$url');
        print('Token : $token');
      }

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      // if (kDebugMode) {
      //   print('Response category data :----${response.body}');
      // }
      // var data = jsonDecode(response.body);
      final data = jsonDecode(response.body.toString());
      if (data['status'] == "Success") {
        // print("skjdfklsdjf");
        catList = categoryListModelFromJson(response.body).categoryList!;

        // var areaData = data["area-list"] as List;
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.green,content: Text("Successfull")));

        return catList;
      } else {
        return catList;
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.red,content: Text("Error:"+e.toString())));
      return catList;
    }
  }

  Future<List<OfferList>> getOfferList(
      {required String token,
      required String mobile,
      required int currentPage,
      required String catType,
      required String category,
      required String district,
      required String searchVal,
      required String sortBy,
      required bool isLoadMore})
  async {
    try {
      String url =
          "${ApiClient().getOfferList}?cid=upai&user_mobile=$mobile&cat_type=${catType}&category=${category}&district=${district}&offer=${searchVal}&sort_by=${sortBy}&page=${currentPage}";

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      Map<String, dynamic> data = jsonDecode(response.body.toString());
      List<dynamic> offerDataList = data['offerList'];
      debugPrint(url);
      // debugPrint(offerDataList.toString());
      if (data['status'] == "Success" && offerDataList.isNotEmpty) {
        offerList = offerDataList
            .map(
              (e) => OfferList.fromJson(e),
            )
            .toList();

        return offerList;
      } else {
        return offerList;
      }
    } catch (e) {
      return offerList;
    }
  }

  static Future<void> deleteOffer({dynamic body, required String token}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.delete(Uri.parse(ApiClient().deleteOffer),
        body: jsonEncode(body), headers: headers);
    final responseData = jsonDecode(response.body);
    debugPrint(' body $body');
    debugPrint('response body $responseData');
    if (responseData['status'] != null && responseData['status'] == 'Success') {
      showCustomSnackbar(
          title: 'Success',
          message: responseData['message'],
          type: SnackBarType.success);
    } else {
      showCustomSnackbar(
          title: 'Failed',
          message: responseData['message'],
          type: SnackBarType.failed);
    }
  }

  static Future<void> editOffer({dynamic body, required String token}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(Uri.parse(ApiClient().editOffer),
        body: jsonEncode(body), headers: headers);
    final responseData = jsonDecode(response.body);
    debugPrint(' body $body');
    debugPrint('response body $responseData');
    if (responseData['status'] != null && responseData['status'] == 'Success') {
      if (CreateOfferController.to.image.value != null) {
        await CreateOfferController.to.uploadImage(body["offer_id"].toString());
        print("image upload called");
      }

      // Get.back();
    } else {
      showCustomSnackbar(
          title: 'Failed',
          message: responseData['message'],
          type: SnackBarType.failed);
    }
  }

  static Future<void> updateProfile(
      {dynamic body, required String token}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(Uri.parse(ApiClient().userUpdate),
        body: jsonEncode(body), headers: headers);
    final responseData = jsonDecode(response.body);
    debugPrint(' body $body');
    debugPrint('response body $responseData');
    if (responseData['status'] != null && responseData['status'] == 'Success') {
      showCustomSnackbar(
          title: 'Success',
          message: responseData['message'],
          type: SnackBarType.success);
    } else {
      showCustomSnackbar(
          title: 'Failed',
          message: responseData['message'],
          type: SnackBarType.failed);
    }
  }

  static Future<void> createOffer({dynamic body, required String token}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(Uri.parse(ApiClient().createOffer),
        body: jsonEncode(body), headers: headers);
    final responseData = jsonDecode(response.body);
    debugPrint(' body ${jsonEncode(body)}');
    debugPrint('response body $responseData');
    if (responseData['status'] != null && responseData['status'] == 'Success') {
      showCustomSnackbar(
          title: 'Success',
          message: responseData['message'],
          type: SnackBarType.success);
    } else {
      showCustomSnackbar(
          title: 'Failed',
          message: responseData['message'],
          type: SnackBarType.failed);
    }
  }

  static Future<void> jobStatus(
      {context,
      required NotificationModel notification,
      required bool isDialogScreen,
      dynamic body,
      required String title,
      required msg,
      required String idStatusUpdate}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.put(Uri.parse(ApiClient().jobStatus),
        body: jsonEncode(body), headers: headers);
    final responseData = jsonDecode(response.body);
    debugPrint(' body $body');
    debugPrint('response body $responseData');

    if (responseData['status'] != null && responseData['status'] == 'Success') {
      showCustomSnackbar(
          title: 'Success',
          message: responseData['message'],
          type: SnackBarType.success);;
      ////
      UserInfoModel senderData = UserInfoModel();
      Map<String, dynamic>? userDetails;
      userDetails =
          await FirebaseAPIs().getSenderInfo(notification.buyerId.toString());
      if (userDetails!.isNotEmpty) {
        senderData.userId = userDetails["user_id"] ?? "";
        senderData.name = userDetails["name"] ?? "user";
        senderData.email = userDetails["email"];
        senderData.lastActive = userDetails["last_active"];
        senderData.image = userDetails["image"] ??
            "https://img.freepik.com/free-photo/young-man-with-glasses-bow-tie-3d-rendering_1142-43322.jpg?t=st=1720243349~exp=1720246949~hmac=313470ceb91cfcf0621b84a20f2738fbbd35f6c71907fcaefb6b0fd0b321c374&w=740";
        senderData.isOnline = userDetails["is_online"];
        senderData.userType = userDetails["user_type"];
        senderData.token = userDetails["token"];
        senderData.mobile = userDetails["mobile"];
        senderData.cid = userDetails["cid"];
        senderData.pushToken = userDetails["push_token"];
        // body["read"]="";
        Map<String, dynamic> orderNotificationData = {};
        orderNotificationData = notification.toJson();
        // orderNotificationData["job_id"] = notification.jobId;
        // orderNotificationData["buyer_name"] =notification.buyerName.toString();
        // orderNotificationData["buyer_id"] =notification.buyerId.toString();
        // orderNotificationData["seller_name"] = notification.sellerName.toString();
        // orderNotificationData["seller_id"] = notification.sellerName.toString();
        // orderNotificationData["notification_title"] = title;
        // orderNotificationData["msg"] = msg;
        FirebaseAPIs.sendNotificationData(
            orderNotificationData, senderData, title, msg);
      }
      ////
      await SellerProfileController.to.refreshAllData();
      await HomeController.to.refreshAllData();
      if (isDialogScreen) {
        FirebaseAPIs.updateJobStatus(
          idStatusUpdate,
          body["status"],
          notification.notificationId.toString(),
        );
        Navigator.pop(context);
      }
    } else {
      showCustomSnackbar(
          title: 'Failed',
          message: responseData['message'],
          type: SnackBarType.failed);
      if (isDialogScreen) {
        Navigator.pop(context);
      }
    }
  }

  static Future<void> awardCreateJob(
      {dynamic body, required String sellerID}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(Uri.parse(ApiClient().awardCreateJob),
        body: jsonEncode(body), headers: headers);
    final responseData = jsonDecode(response.body);
    debugPrint(' body $body');
    debugPrint('response body $responseData');

    if (responseData['status'] != null && responseData['status'] == 'Success') {

      UserInfoModel senderData = UserInfoModel();
      Map<String, dynamic>? userDetails;
      userDetails = await FirebaseAPIs().getSenderInfo(sellerID);
      if (userDetails!.isNotEmpty) {
        senderData.userId = userDetails["user_id"] ?? "";
        senderData.name = userDetails["name"] ?? "user";
        senderData.email = userDetails["email"];
        senderData.lastActive = userDetails["last_active"];
        senderData.image = userDetails["image"] ??
            "https://img.freepik.com/free-photo/young-man-with-glasses-bow-tie-3d-rendering_1142-43322.jpg?t=st=1720243349~exp=1720246949~hmac=313470ceb91cfcf0621b84a20f2738fbbd35f6c71907fcaefb6b0fd0b321c374&w=740";
        senderData.isOnline = userDetails["is_online"];
        senderData.userType = userDetails["user_type"];
        senderData.token = userDetails["token"];
        senderData.mobile = userDetails["mobile"];
        senderData.cid = userDetails["cid"];
        senderData.pushToken = userDetails["push_token"];
        // body["read"]="";
        Map<String, dynamic> orderNotificationData = body;
        orderNotificationData["job_id"] = responseData['job_id'].toString();
        orderNotificationData["buyer_name"] =
            ProfileScreenController.to.userInfo.value.name.toString();
        orderNotificationData["seller_name"] = senderData.name.toString();
        orderNotificationData["notification_title"] =
            "You Have a Confirm Order Request";
        orderNotificationData["created_time"] =
            DateTime.now().millisecondsSinceEpoch.toString();
        orderNotificationData["notification_msg"] =
            "${ProfileScreenController.to.userInfo.value.name.toString()} send you a request for confirm order of ${body["job_title"]}";
        FirebaseAPIs.sendNotificationData(
            orderNotificationData,
            senderData,
            "Confirm offer request",
            "${ProfileScreenController.to.userInfo.value.name.toString()} send you request for confirm order\nOffer title:${body["job_title"]}");
      }
      showCustomSnackbar(
          title: 'Success',
          message: responseData['message'],
          type: SnackBarType.success);

    } else {
      showCustomSnackbar(
          title: 'Failed',
          message:responseData['message'],
          type: SnackBarType.failed)
    ;
    }
  }

  static Future<void> completionReview(
      {dynamic body, required NotificationModel notification}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.put(Uri.parse(ApiClient().completionReview),
        body: jsonEncode(body), headers: headers);
    final responseData = jsonDecode(response.body);
    debugPrint(' body $body');
    debugPrint('response body $responseData');

    if (responseData['status'] != null && responseData['status'] == 'Success') {
      showCustomSnackbar(
          title: 'Success',
          message: "Your Review submitted successfully",
          type: SnackBarType.success);

      // jobStatus(notification: notification, isDialogScreen: false, title: "title", msg: "msg", idStatusUpdate: "COMPLETED");
      UserInfoModel senderData = UserInfoModel();
      Map<String, dynamic>? userDetails;
      userDetails =
          await FirebaseAPIs().getSenderInfo(notification.sellerId.toString());
      if (userDetails!.isNotEmpty) {
        senderData.userId = userDetails["user_id"] ?? "";
        senderData.name = userDetails["name"] ?? "user";
        senderData.email = userDetails["email"];
        senderData.lastActive = userDetails["last_active"];
        senderData.image = userDetails["image"] ??
            "https://img.freepik.com/free-photo/young-man-with-glasses-bow-tie-3d-rendering_1142-43322.jpg?t=st=1720243349~exp=1720246949~hmac=313470ceb91cfcf0621b84a20f2738fbbd35f6c71907fcaefb6b0fd0b321c374&w=740";
        senderData.isOnline = userDetails["is_online"];
        senderData.userType = userDetails["user_type"];
        senderData.token = userDetails["token"];
        senderData.mobile = userDetails["mobile"];
        senderData.cid = userDetails["cid"];
        senderData.pushToken = userDetails["push_token"];
        // body["read"]="";
        Map<String, dynamic> orderNotificationData = body;
        // orderNotificationData["total"]=
        orderNotificationData["job_id"] = notification.jobId.toString();
        orderNotificationData["seller_id"] = notification.sellerId.toString();
        orderNotificationData["buyer_id"] = notification.buyerId.toString();
        orderNotificationData["price"] = notification.price.toString();
        // orderNotificationData["quantity"]=notification.quantity.toString();
        orderNotificationData["buyer_name"] =
            ProfileScreenController.to.userInfo.value.name.toString();
        orderNotificationData["seller_name"] = senderData.name.toString();
        orderNotificationData["notification_title"] = "Congratulations.";
        orderNotificationData["created_time"] =
            DateTime.now().millisecondsSinceEpoch.toString();
        orderNotificationData["notification_msg"] =
            "${ProfileScreenController.to.userInfo.value.name.toString()} Successfully Received your ${notification.jobTitle.toString()} service";
        FirebaseAPIs.sendNotificationData(
            orderNotificationData,
            senderData,
            orderNotificationData["notification_title"].toString(),
            orderNotificationData["notification_msg"].toString());
        await FirebaseAPIs.updateJobStatus(
            ProfileScreenController.to.userInfo.value.userId.toString(),
            "COMPLETED",
            notification.notificationId.toString());
      }
    } else {
      showCustomSnackbar(
          title: 'Failed',
          message:"not submitted successfully",
          type: SnackBarType.failed);
    }
  }

  Future<void> getDmPath({required baseUrl}) async {
    try {
      String url = baseUrl;
      if (kDebugMode) {
        print('++++++++++get Dm path url :----$url');
      }
      final response = await http.get(Uri.parse(url));
      if (kDebugMode) {
        print('dm path Response data :----${response.body.toString()}');
      }
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == "success") {
        Boxes.getDmPathBox().put("BaseUrl", data['BaseUrl'].toString());
        print("${Boxes.getDmPathBox().get("BaseUrl")}");
      }
    } catch (e) {
      print("error in api call of dm path");
    }
  }
}
