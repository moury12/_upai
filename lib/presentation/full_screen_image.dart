import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/widgets/custom_network_image.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,foregroundColor: Colors.black,),
      body:  Center(
          child: CustomNetworkImage(imageUrl: imageUrl),
        ),

    );
  }
}
