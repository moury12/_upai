import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:upai/controllers/order_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/widgets/custom_text_field.dart';

class ReviewScreen extends StatefulWidget {
  static const String routeName = '/review';
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    Get.put(OrderController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: AppColors.strokeColor2,
        titlePadding: EdgeInsets.zero,

        title: Align(
          alignment: Alignment.topRight,
          child: IconButton(icon: Icon(Icons.cancel,color: Colors.black,), onPressed: () {
Navigator.pop(context);
          },),
        ),
        actionsAlignment: MainAxisAlignment.start,
        content: Column(mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rate our Service",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
    ),
            RatingBar(
              initialRating: 3.5,
              allowHalfRating: true,
              ratingWidget: RatingWidget(full: Icon(Icons.star_rounded), half: Icon(Icons.star_half_rounded), empty: Icon(Icons.star_border_rounded)),
              onRatingUpdate: (value) {},
            ),
            SizedBox(
              height: 8,
            ),

            Text(
              "Review",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
            ),
            SizedBox(
              height: 8,
            ),
            CustomTextField(
              hintText: 'Share your thoughts..',
              maxLines: 3,
            )
          ],
        ),
    actions: [ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black,foregroundColor: Colors.white),
        onPressed: () {
OrderController.to.completionReview();
Get.snackbar("Review", "Your Review submitted successfully");
Navigator.pop(context);
    }, child: Text('Submit review'))],);
  }
}