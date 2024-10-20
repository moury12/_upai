import 'package:flutter/material.dart';
import 'package:upai/Model/offer_list_model.dart';
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
        title: Text(
          '${buyerReviewList.length} reviews',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Overall rating',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(
                    Icons.star_rate_rounded,
                    size: 25,
                  ),
                  Text(overallRating.toStringAsFixed(1),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
                ],
              ),
              Divider(),
              ...List.generate(
                buyerReviewList.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
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
