import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/presentation/full_screen_image.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final Widget? errorWidget;
  final bool? imgPreview;
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.imgPreview = false,
    this.width, this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: imgPreview == true
            ? () {
                Get.to(FullScreenImage(imageUrl: imageUrl));
              }
            : null,
        child: CachedNetworkImage(
          height: height,
          width: width ?? double.infinity,
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: height,
                width: width ?? double.infinity,
                color: Colors.white,
              )),
          errorWidget: (context, url, error) =>errorWidget?? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: height,
                width: width ?? double.infinity,
                color: Colors.white,
              )) /*Center(child: Image.asset(ImageConstant.dummy, height: height,
            width: width,))*/
          ,
        ),
      ),
    );
  }
}
