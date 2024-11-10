import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';

class RateByCat extends StatelessWidget {
  final String rateCat;
  final String rating;

  const RateByCat({
    super.key,
    required this.rateCat,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rateCat,style: AppTextStyle.bodySmallblack(context),),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 16,
                color: AppColors.colorLightBlack,
              ),
              Text(
                rating,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}