import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/core/utils/my_date_util.dart';

class ClientReviewCard extends StatefulWidget {
  final BuyerReviewList buyerReview;
  const ClientReviewCard({
    super.key,
    required this.size, required this.buyerReview,
  });

  final Size size;

  @override
  State<ClientReviewCard> createState() => _ClientReviewCardState();
}

class _ClientReviewCardState extends State<ClientReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1.50, color: Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),

      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          width: widget.size.width * 0.8,
          child: Column(
            children: [
              SizedBox(
                width: widget.size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(ImageConstant.receiverImg),
                        ),
                        const SizedBox(width: 5,),
                        Column(
                          children: [
                            Text(widget.buyerReview.buyerName.toString(),
                                style: AppTextStyle.bodySmallblack),
                            Text(MyDateUtil.formatDate(widget.buyerReview.reviewDate.toString()),
                                style: AppTextStyle.titleTextSmallest),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.buyerReview.buyerReview.toString(),style: AppTextStyle.bodySmallGrey,),
                       Icon(Icons.star_rate_rounded,color: Colors.black87,size: 14,)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "Lorem ipsum dolor sit amet consectetur. Ornare pretium sit faucibus non massa sit. At integer nulla vel nisi. Turpis morbi vulputate placerat lacus pellentesque sed."
                    " Vel sit nibh in id dictum augue.Lorem ipsum dolor sit amet consectetur. Ornare pretium sit faucibus non massa sit. At integer nulla vel nisi. Turpis morbi vulputate placerat lacus pellentesque sed."
                    " Vel sit nibh in id dictum augue.",textAlign: TextAlign.justify,
                style: AppTextStyle.bodySmallGrey,
                overflow: TextOverflow.ellipsis, maxLines: 5,)
            ],
          ),
        ),
      ),
    );
  }
}