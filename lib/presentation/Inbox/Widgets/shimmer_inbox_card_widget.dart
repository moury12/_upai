import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:upai/core/utils/app_colors.dart';

class ShimmerInboxCardWidget extends StatelessWidget {
  const ShimmerInboxCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 4, top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.strokeColor2, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[300],
            ),
            title: Container(
              width: double.infinity,
              height: 16,
              color: Colors.grey[300],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 8),
                Container(
                  width: 100.w,
                  height:12.w,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 8),
                Container(
                  width: 80.w,
                  height:12.w,
                  color: Colors.grey[300],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50.w,
                  height:12.w,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 8),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.grey[300],
                ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
