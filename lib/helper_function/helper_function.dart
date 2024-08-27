import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double getResponsiveFontSize(BuildContext context, double baseFontSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  // Adjust the multiplier as needed for your design
  return baseFontSize * (screenWidth / 423); // 375 is the base width (e.g., iPhone 11)
}
Future<dynamic> loadJsonFromAssets(String filePath) async{
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}