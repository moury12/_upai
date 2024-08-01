import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:upai/core/utils/prefs_utils.dart';
import '/core/errors/app_exception.dart';

class ApiClient {
  static const String _baseUrl = "http://192.168.0.211:8000/upai_api";

  String get loginUrl => '$_baseUrl/login';
  String get createUserUrl => '$_baseUrl/create_user';
  String get getCategoryList => '$_baseUrl/get_category_list';
  String get getOfferList => '$_baseUrl/get_offer_list';

  Future<dynamic> getData(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer ' '}',
      },
    );
    if (response.statusCode == 200) {
      String responseBody = response.body;
      return responseBody;
    } else {
      if (kDebugMode) {
        print('Error: ${response.statusCode}');
      }
      throw Exception('Error in getData => ${response.statusCode}');
    }
  }

  Future<dynamic> postData(String endpoint, Map<String, dynamic> data,
      {bool useBearerToken = true}) async {
    try {
      final headers = <String, String>{
        'Content-Type': 'application/json', // Add Content-Type header
      };
      if (useBearerToken) {
        headers['Authorization'] = 'Bearer ${PrefUtils().getAuthToken()}';
      }
      Response response = await http.post(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: headers.cast<String, String>(),
        body: json.encode(data),
      );
      var responseJson = _processResponse(response);
      return responseJson;
    } catch (e) {
      if (kDebugMode) {
        print("Error in postData: $e");
      }
      throw e;
    }
  }
}

_processResponse(Response response) async {
  switch (response.statusCode) {
    case 200:
      const SnackBar(content: Text('Success'), backgroundColor: Colors.green);
      var resJson = response.body;
      return resJson;
    case 400:
      const SnackBar(content: Text('Error'), backgroundColor: Colors.red);
      throw BadRequestException(
          response.body, response.request?.url.toString());
    case 401:
      const SnackBar(content: Text('Error'), backgroundColor: Colors.red);
      final Map<String, dynamic> errorData = json.decode(response.body);
      final String errorMessage = errorData['code'];
      throw UnauthorizedException(
          errorMessage, response.request?.url.toString());
    case 403:
      const SnackBar(
          content: Text('User/Password is not matched'),
          backgroundColor: Colors.red);
      final Map<String, dynamic> errorData = json.decode(response.body);
      final String errorMessage = errorData['code'];
      throw UnauthorizedException(
          errorMessage, response.request?.url.toString());
    case 404:
      const SnackBar(content: Text('Error'), backgroundColor: Colors.red);
      final Map<String, dynamic> errorData = json.decode(response.body);
      final String errorMessage = errorData['code'];
      throw DataNotFoundException(
          errorMessage, response.request?.url.toString());
    case 500:
    default:
      throw FetchDataException(
          "Error occurred with code: ${response.statusCode}",
          response.request?.url.toString());
  }
}
