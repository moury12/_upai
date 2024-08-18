import 'package:flutter/material.dart';

double getResponsiveFontSize(BuildContext context, double baseFontSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  // Adjust the multiplier as needed for your design
  return baseFontSize * (screenWidth / 375); // 375 is the base width (e.g., iPhone 11)
}