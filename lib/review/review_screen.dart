import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/Model/notification_model.dart';
import 'package:upai/controllers/order_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/helper_function/helper_function.dart';
import 'package:upai/widgets/custom_button.dart';
import 'package:upai/widgets/custom_text_field.dart';

class ReviewScreen extends StatefulWidget {
  final NotificationModel notificationModel;
  static const String routeName = '/review';
  const ReviewScreen({super.key, required this.notificationModel});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController reviewTE = TextEditingController();
  double ratingValue = 2.5;
  @override
  void initState() {
    Get.put(OrderController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
      ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(
            Icons.cancel,
            color: AppColors.kPrimaryColor,
            size: defaultAppBarIconSize,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "rate_our_service".tr,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: defaultTitleFontSize),
            ),
            RatingBar(
              initialRating: ratingValue,
              allowHalfRating: true,
              glowColor: AppColors.kPrimaryColor,
              unratedColor: AppColors.kPrimaryColor,
              itemSize: 24.sp,
              ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star_rounded,
                    color: AppColors.kPrimaryColor,
                  ),
                  half: Icon(
                    Icons.star_half_rounded,
                    color: AppColors.kPrimaryColor,
                  ),
                  empty: Icon(
                    Icons.star_border_rounded,
                    color: AppColors.kPrimaryColor,
                  )),
              onRatingUpdate: (value) {
                ratingValue = value;
                print(ratingValue);
              },
            ),
            SizedBox(
              height: 8.w,
            ),
            Text(
              "review".tr,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: default14FontSize),
            ),
            SizedBox(
              height: 8,
            ),
            CustomTextField(
              controller: reviewTE,
              hintText: 'share_your_thoughts'.tr,
              maxLines: 3,
            )
          ],
        ),
      ),
      actions: [
        CustomButton(
          text: 'submit_review'.tr,
          onTap: () {
            if (reviewTE.value.text.isEmpty) {
              showCustomSnackbar(
                  title: 'alert'.tr,
                  message: "share_your thoughts_first".tr,
                  type: SnackBarType.alert);
            } else {
              OrderController.to.completionReview(
                  reviewTE.text.trim().toString(),
                  ratingValue.toString(),
                  widget.notificationModel);
              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }
}
