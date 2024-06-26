import 'package:flutter/material.dart';
import 'package:upai/core/utils/custom_text_style.dart';

class CategotyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8,top: 5),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const ShapeDecoration(
              color: Color(0xFFD9D9D9),
              shape: OvalBorder(),
            ),
          ),
          SizedBox(height: 5,),
          Text(
            'Category 1',
            textAlign: TextAlign.center,
            style: AppTextStyle.titleTextSmallest,
            ),
        ],
      ),
    );
  }
}