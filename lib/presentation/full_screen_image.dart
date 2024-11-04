import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/widgets/custom_network_image.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    double appBarIconSize = ScreenUtil().screenHeight < ScreenUtil().screenWidth? 14.sp : defaultAppBarIconSize;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,foregroundColor: Colors.black,iconTheme: IconThemeData(size: appBarIconSize),),
      body:  Center(
          child: CustomNetworkImage(imageUrl: imageUrl),
        ),

    );
  }
}
