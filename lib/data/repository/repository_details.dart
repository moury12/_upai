import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/LoginScreen/login_screen.dart';
import '../../Model/user_info_model.dart';
import '../../presentation/Profile/profile_screen_controller.dart';
import '/data/api/api_client.dart';
import '/core/errors/error_controller.dart';

import 'repository_interface.dart';
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
  Future<void> login(
      String CID, String userMobile, String password, String userType) async
  {
    String url = ApiClient().loginUrl;
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {"cid": CID, "user_mobile": userMobile, "user_pass": password}),
      );
      print("object");
      final data = jsonDecode(response.body);
      if (data["status"].toString() == 'Success') {
        print("Successfully");
        // data["user_info"]["name"];

        UserInfoModel userInfo = UserInfoModel();
        userInfo.cid = CID;
        userInfo.name = data['user_info']['name'].toString();
        userInfo.userId = data["user_info"]["user_id"];
        userInfo.email = data['user_info']['email'].toString();
        userInfo.mobile = data['user_info']['mobile'].toString();
        userInfo.token = data['token'].toString();
        userInfo.userType = userType;
        await box.put('user', json.encode(userInfo.toJson()));
        print("value is  : ${box.get("user")}");
        print("&&&&&&&&&&&&&&&&&&&");
        print(box.values);
        //FirebaseAPIs.currentUser();
        if (!await FirebaseAPIs.userExists()) {
          FirebaseAPIs.createUser(userInfo.toJson());
          print("user creating");
          Get.offAndToNamed("/defaultscreen");
        } else {
          Get.offAndToNamed("/defaultscreen");
        }
      } else {
        Get.snackbar(data["status"], data["message"],
            colorText: Colors.white, backgroundColor: Colors.pink);
      }
      // var loginResponse = loginResponseModelFromJson(response.);
      print(response);
    } catch (e) {
      // handleError(e);
      print(e.toString());
      Get.snackbar("Failed", e.toString());
      //throw Exception('Error in login: $e');
    }
  }

  Future<void> createUser(String cId, String userName, String userPass,
      String userMobile, String userEmail) async {
    String url = ApiClient().createUserUrl;
    print("url is =>$url");

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "cid": cId,
          "user_name": userName,
          "user_pass": userPass,
          "email": userEmail,
          "mobile": userMobile
        }),
      );
      if (response.statusCode == 200) {
        print("success");
      }
      final data = jsonDecode(response.body.toString());
      if (data["message"] == "successfully user create") {
        Get.snackbar("Success", "User Created Successfully",
            colorText: Colors.green, backgroundColor: Colors.white);
        Get.offAll(() => const LoginScreen());
      } else if (data["message"] ==
          "All ready this user exist in the database") {
        Get.snackbar("Failed", "All ready this user exist in the database",
            colorText: Colors.red, backgroundColor: Colors.white);
      }
    } catch (e) {
      // handleError(e);
      print(e.toString());
      throw Exception('Error in login: $e');
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
      debugPrint('seller profile $responseData');
      if(responseData['status']!=null&&responseData['status']=="Success"){
        sellerProfileModel =SellerProfileModel.fromJson(responseData);
      }else{
        Get.snackbar('Failed', 'Failed to load data');
      }
      return sellerProfileModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryList>> getCategoryList({
    required String token,
  }) async {
    try {
      String url =
          "${ApiClient().getCategoryList}?cid=upai&user_mobile=0190001&name=md rabbi2";
      if (kDebugMode) {
        print('++++++++++get area list url :----$url');
        print('Token : ${token}');
      }

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print('Response category data :----${response.body}');
      }
      // var data = jsonDecode(response.body);
      final data = jsonDecode(response.body.toString());
      if (data['status'] == "Success") {
        print("skjdfklsdjf");
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

  Future<List<OfferList>> getOfferList({
    required String token,
    required String mobile,
    required String name,
  }) async {
    try {
      String url =
          "${ApiClient().getOfferList}?cid=upai&user_mobile=$mobile&name=$name";
      if (kDebugMode) {
        print('++++++++++get Offer list url :----$url');
        print('Token : $token');
      }

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print('Response data :----${response.body}');
      }
      // var data = jsonDecode(response.body);
      final data = jsonDecode(response.body.toString());
      if (data['status'] == "Success") {
        print("skjdfklsdjf");
        offerList = offerListModelFromJson(response.body).offerList!;
        print(offerList);
        // var areaData = data["area-list"] as List;
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.green,content: Text("Successfull")));

        return offerList;
      } else {
        return offerList;
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.red,content: Text("Error:"+e.toString())));
      return offerList;
    }
  }

  static Future<void> createOffer({dynamic body}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(Uri.parse(ApiClient().createOffer),
        body: jsonEncode(body), headers: headers);
    final responseData = jsonDecode(response.body);
    debugPrint(' body $body');
    debugPrint('response body $responseData');

    if (responseData['status'] != null && responseData['status'] == 'Success') {
      Get.snackbar('Success', responseData['Message']);
    } else {
      Get.snackbar('Error', 'Failed to create offer');
    }
  }

  static Future<void> jobStatus({dynamic body}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(Uri.parse(ApiClient().jobStatus),
        body: jsonEncode(body), headers: headers);
    final responseData = jsonDecode(response.body);
    debugPrint(' body $body');
    debugPrint('response body $responseData');

    if (responseData['status'] != null && responseData['status'] == 'Success') {
      Get.snackbar('Success', responseData['message']);
    } else {
      Get.snackbar('Error', 'Failed');
    }
  }

  static Future<void> awardCreateJob({dynamic body,required String sellerID}) async {
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
      Get.snackbar('Success', '${responseData['message']} job id is ${responseData['job_id']}');
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
        body["read"]="";

        FirebaseAPIs.sendNotificationData(body,senderData,"Confirm offer request","${ProfileScreenController.to.userInfo.name.toString()} send you request for confirm order\nOffer ID:${body["offer_id"]}");
      }
    } else {
      Get.snackbar('Error', 'Failed ${responseData['message']}');
    }
  }

  static Future<void> completionReview({dynamic body}) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(Uri.parse(ApiClient().completionReview),
        body: jsonEncode(body), headers: headers);
    final responseData = jsonDecode(response.body);
    debugPrint(' body $body');
    debugPrint('response body $responseData');

    if (responseData['status'] != null && responseData['status'] == 'Success') {
      Get.snackbar('Success', responseData['message']);
    } else {
      Get.snackbar('Error', 'Failed');
    }
  }
}
