import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/presentation/Service-details/widgets/client_review.dart';

class RatingListScreen extends StatelessWidget {
  final List<BuyerReviewList> buyerReviewList;
  final double overallRating;
  const RatingListScreen(
      {super.key, required this.buyerReviewList, required this.overallRating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        centerTitle: false,
        iconTheme: IconThemeData(size: defaultAppBarIcon),
        title: Text(
          '${buyerReviewList.length} reviews',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(12.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Overall rating',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(
                    Icons.star_rate_rounded,
                    size: 25.sp,
                  ),
                  Text(overallRating.toStringAsFixed(1),
                      style:
                          TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600))
                ],
              ),
              Divider(),
              ...List.generate(
                buyerReviewList.length,
                (index) => Padding(
                  padding:  EdgeInsets.only(bottom: 8.sp),
                  child: ClientReviewCard(
                    buyerReview: buyerReviewList[index],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
