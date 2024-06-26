import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';

class ClientReviewCard extends StatelessWidget {
  const ClientReviewCard({
    super.key,
    required this.size,
  });

  final Size size;

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
          width: size.width * 0.8,
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                            Text("Client Name",
                                style: AppTextStyle.bodySmallblack),
                            Text("22 Jan, 2023",
                                style: AppTextStyle.titleTextSmallest),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("4.6",style: AppTextStyle.bodySmallGrey,),
                        RatingBarIndicator(
                          rating: 4.4,
                          itemBuilder: (context, index) =>
                              Icon(
                                Icons.star,
                                color: AppColors.colorLightBlack,
                              ),
                          itemCount: 5,
                          itemSize: 14.0,
                          direction: Axis.horizontal,
                        ),
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