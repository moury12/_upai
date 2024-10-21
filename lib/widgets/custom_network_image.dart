import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/presentation/full_screen_image.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final bool? imgPreview;
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height, this.imgPreview=false, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap:imgPreview==true? () {
          Get.to(FullScreenImage(imageUrl: imageUrl));
        }:null,
        child: CachedNetworkImage(
          height: height ?? null,
          width: width ?? null,
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
