import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/category_list_model.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/LoginScreen/login_screen.dart';
import '../../Model/user_info_model.dart';
import '/data/api/api_client.dart';
import '/core/errors/error_controller.dart';

import 'repository_interface.dart';
import 'package:http/http.dart' as http;

class RepositoryData {
  late List<CategoryList> catList = [];
  final apiClient = ApiClient();
  final box = Hive.box('userInfo');
  // @override
  // Future<List<ProductDetailsModel>> returnData() async {
  //   var res = await rootBundle.loadString("assets/response.json");
  //   var data = productDetailsModelFromJson(res);
  //   print(data.length);
  //   return data;
  // }
  Future<dynamic> login(String CID, String userMobile, String password) async {
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
        userInfo.name =data['user_info']['name'].toString();
        userInfo.userId=data["user_info"]["user_id"];
        userInfo.email=data['user_info']['email'].toString();
        userInfo.mobile =data['user_info']['mobile'].toString();
        userInfo.token =data['token'].toString();
        await box.put('user',userInfo.toJson());
        print("value is  : ${box.get("user")}");
        print("&&&&&&&&&&&&&&&&&&&");
        print(box.values);
        FirebaseAPIs.currentUser();
        if(!await FirebaseAPIs.userExists())
          {
            FirebaseAPIs.createUser(userInfo.toJson());
            print("user creating");
            Get.offAndToNamed("/defaultscreen");

          }
        else
          {
            Get.offAndToNamed("/defaultscreen");
          }

      } else {
        Get.snackbar(data["status"], data["message"],
            colorText: Colors.white, backgroundColor: Colors.red);
      }
      // var loginResponse = loginResponseModelFromJson(response.);
      print(response);
      return response;
    } catch (e) {
      // handleError(e);
      print(e.toString());
      throw Exception('Error in login: $e');
    }
  }

  Future<void> createUser(String cId, String userName, String userPass,
      String userMobile, String userEmail) async {
    String url = ApiClient().createUserUrl;
    print("url is =>$url");

   try{
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
     } else if (data["message"] == "All ready this user exist in the database") {
       Get.snackbar("Failed", "All ready this user exist in the database",
           colorText: Colors.red, backgroundColor: Colors.white);
     }
   }
   catch(e)
    {
      // handleError(e);
      print(e.toString());
      throw Exception('Error in login: $e');
    }
  }
  Future<List<CategoryList>> getCategoryList({
    required String token,
    context,
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
        print('Response data :----${response.body}');
      }
      // var data = jsonDecode(response.body);
      final data = jsonDecode(response.body.toString());
      if (data['status'] == "Success") {

        print("skjdfklsdjf");
        catList =categoryListModelFromJson(response.body).categoryList!;
        print(catList);
        // var areaData = data["area-list"] as List;
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.green,content: Text("Successfull")));

        return catList;
      }
      else
      {
        return catList;
      }
    }

    catch(e)
    {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.red,content: Text("Error:"+e.toString())));
      return catList;
    }


  }

// Future<void> getCategoryList(String cId, String userName, String userPass,
  //     String userMobile, String userEmail) async {
  //   String url = ApiClient().createUserUrl;
  //   print("url is =>$url");
  //
  //   var response = await http.post(
  //     Uri.parse(url),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({
  //       "cid": cId,
  //       "user_name": userName,
  //       "user_pass": userPass,
  //       "email": userEmail,
  //       "mobile": userMobile
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     print("success");
  //   }
  //   final data = jsonDecode(response.body.toString());
  //   if (data["message"] == "successfully user create") {
  //     Get.snackbar("Success", "User Created Successfully",
  //         colorText: Colors.green, backgroundColor: Colors.white);
  //     Get.offAll(() => const LoginScreen());
  //   } else if (data["message"] == "All ready this user exist in the database") {
  //     Get.snackbar("Failed", "All ready this user exist in the database",
  //         colorText: Colors.red, backgroundColor: Colors.white);
  //   }
  // }
  //
  // @override
  // Future register(Object userName, String email, String password) {
  //   // TODO: implement register
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<List> returnData() {
  //   // TODO: implement returnData
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future updateProfile(String firstName, String lastName) {
  //   // TODO: implement updateProfile
  //   throw UnimplementedError();
  // }

  // @override
  // Future<RegisterResponseModel> register(String userName, String email, String password) async {
  //   Map<String, dynamic> body = {"username": userName, "email": email, "password": password};
  //   try {
  //     var response = await apiClient.postData("wp/v2/users/register", body, useBearerToken: false);
  //     var registerResponse = registerResponseModelFromJson(response);
  //     return registerResponse;
  //   } catch (e) {
  //     handleError(e);
  //     throw Exception('Error in Register: $e');
  //   }
  // }

  // @override
  // Future<ProfileUpdateResponseModel> updateProfile(String firstName, String lastName) async {
  //   Map<String, dynamic> jwtUserInfo = JwtHelper().parseJwt(PrefUtils().getAuthToken());
  //   String userId = jwtUserInfo['data']['user']['id'];
  //   Map<String, dynamic> body = {
  //     "first_name": firstName,
  //     "last_name": lastName,
  //   };
  //   try {
  //     var response = await apiClient.postData("wp/v2/users/$userId", body, useBearerToken: true);
  //     var updatedProfileResponse = profileUpdateResponseModelFromJson(response);
  //     return updatedProfileResponse;
  //   } catch (e) {
  //     handleError(e);
  //     throw Exception('Error in Profile Update: $e');
  //   }
  // }
}
