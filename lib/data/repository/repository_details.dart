import 'dart:developer';

import '/data/api/api_client.dart';
import '/core/errors/error_controller.dart';

import 'repository_interface.dart';

class RepositoryData with ErrorController implements RepositoryInterface {
  final apiClient = ApiClient();

  // @override
  // Future<List<ProductDetailsModel>> returnData() async {
  //   var res = await rootBundle.loadString("assets/response.json");
  //   var data = productDetailsModelFromJson(res);
  //   print(data.length);
  //   return data;
  // }

  @override
  Future<dynamic> login(String userName, String password) async {
    Map<String, dynamic> body = {"username": userName, "password": password};
    log(body.toString());
    try {
      var response =
          await apiClient.postData("auth/login", body, useBearerToken: false);
      // var loginResponse = loginResponseModelFromJson(response.);
      print(response);
      return response;
    } catch (e) {
      handleError(e);
      print(e.toString());
      throw Exception('Error in login: $e');
    }
  }

  @override
  Future register(Object userName, String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<List> returnData() {
    // TODO: implement returnData
    throw UnimplementedError();
  }

  @override
  Future updateProfile(String firstName, String lastName) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

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
