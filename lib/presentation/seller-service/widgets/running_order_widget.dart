import 'package:flutter/material.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/helper_function/helper_function.dart';
class RunningOrderWidget extends StatelessWidget {
  const RunningOrderWidget({
    super.key,
    required this.runningOrder,
  });

  final RunningOrder runningOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.all(12),
    //width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: AppColors.strokeColor2,
            spreadRadius: 2,
            blurRadius: 2)
      ],
      borderRadius: BorderRadius.circular(15),
    ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.asset(
              ImageConstant.runningOrderImage,
              height: getResponsiveFontSize(context,100),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row( mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Job id: ${runningOrder.jobId ?? 'job id'}',
                        style: TextStyle(
                            fontSize: getResponsiveFontSize(context,10),
                            fontWeight: FontWeight.w500)),Text(
                        '${runningOrder.awardDate ?? ''}',
                        style: TextStyle(
                            fontSize: getResponsiveFontSize(context,10),
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                          runningOrder.jobTitte ?? 'job title',
                          style: TextStyle(
                              fontSize: getResponsiveFontSize(context,14),
                              fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),

                    Text(
                        "৳ ${runningOrder.taotal ?? '0.00'}",
                        style: TextStyle(
                            fontSize: getResponsiveFontSize(context,16),
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                Text('Description:',
                    style: TextStyle(
                        fontSize: getResponsiveFontSize(context,10),
                        fontWeight: FontWeight.w500)),
                Text(
                  runningOrder.description ?? '',
                  style: TextStyle(
                      fontSize: getResponsiveFontSize(context,8),
                      fontWeight: FontWeight.w400),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                    '${runningOrder.rateType ?? ' '}(${runningOrder.rate})',
                    style: TextStyle(
                        fontSize: getResponsiveFontSize(context,8),
                        fontWeight: FontWeight.w400)),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Quantity: ${runningOrder.quanrity ?? ''}',
                        style: TextStyle(
                            fontSize: getResponsiveFontSize(context,10),
                            fontWeight: FontWeight.w500)),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20),
                          color: Colors.lightBlue
                              .withOpacity(.5)),
                      padding: EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Text(
                          '${runningOrder.status ?? ''}',
                          style: TextStyle(
                              fontSize: getResponsiveFontSize(context,10),
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
