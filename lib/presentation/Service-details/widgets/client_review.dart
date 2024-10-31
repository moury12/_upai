import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/core/utils/my_date_util.dart';

import '../../Profile/profile_screen_controller.dart';

class ClientReviewCard extends StatefulWidget {
  final BuyerReviewList buyerReview;
  final int? maxLine;
  const ClientReviewCard({
    super.key,

    required this.buyerReview, this.maxLine,
  });



  @override
  State<ClientReviewCard> createState() => _ClientReviewCardState();
}

class _ClientReviewCardState extends State<ClientReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(

margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.50, color: AppColors.kprimaryColor.withOpacity(.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: ProfileScreenController.to.getServiceSellerProfileImageURL(widget.buyerReview.buyerId.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != "") {
                            return CircleAvatar(backgroundImage: NetworkImage(snapshot.data.toString()));
                          } else {
                            return CircleAvatar(
                                backgroundImage: AssetImage(
                              ImageConstant.receiverImg,
                            ));
                            // return Image.asset(
                            //   ImageConstant.senderImg,
                            //  height: 150.w,
                            //   width: 150.w,
                            //   fit: BoxFit.cover,
                            // );
                          }
                        } else {
                          return CircleAvatar(
                              backgroundImage: AssetImage(
                            ImageConstant.receiverImg,
                          ));
                        }
                      },
                    ),
                    const SizedBox(
                      width:12,
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.buyerReview.buyerName.toString(), style: AppTextStyle.bodySmallblack),
                        Text(MyDateUtil.formatDate(widget.buyerReview.reviewDate.toString()), style: AppTextStyle.titleTextSmallest),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(
                      Icons.star_rate_rounded,
                      color: AppColors.kprimaryColor,
                      size: 20.sp,
                    ),Text(
                      widget.buyerReview.buyerRating.toString(),
                      style: AppTextStyle.bodySmallGrey,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

           widget.maxLine!=null? Text(
              widget.buyerReview.buyerReview.toString(),
              textAlign: TextAlign.justify,
              style: AppTextStyle.bodySmallGrey,
              overflow: TextOverflow.visible,
              maxLines: widget.maxLine??null,
            ):ReadMoreText(
             widget.buyerReview.buyerReview.toString(),
             style: AppTextStyle.bodySmallGrey400,
             textAlign: TextAlign.start,
             trimMode: TrimMode.Line,
             trimLines: 3,
             //colorClickableText: Colors.pink,
             trimCollapsedText: 'Show more',
             trimExpandedText: ' Show less',
             moreStyle:  TextStyle(
                 fontSize: 12.sp,
                 fontWeight: FontWeight.bold,
                 color: Colors.green),
             lessStyle:  TextStyle(
                 fontSize: 12.sp,
                 fontWeight: FontWeight.bold,
                 color: Colors.grey),
           ),
          ],
        ),
      ),
    );
  }
}
