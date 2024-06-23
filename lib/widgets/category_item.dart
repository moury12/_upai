import 'package:flutter/material.dart';

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
            style: TextStyle(
              color: Color(0xFF817F7F),
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}