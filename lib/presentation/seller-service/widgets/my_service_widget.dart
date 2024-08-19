import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/helper_function/helper_function.dart';

class MyServiceWidget extends StatelessWidget {
  final MyService? service;
  final OfferList? offerList;
  final Widget? button;
  const MyServiceWidget({super.key, this.service, this.offerList, this.button});

  @override
  Widget build(BuildContext context) {
    // Determine if we're using service or offerList
    final isService = service != null;

    return Container(

      // width: 200,
      padding: EdgeInsets.all(12),

      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: AppColors.strokeColor2, spreadRadius: 2, blurRadius: 2)
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image.asset(
            ImageConstant.productImage,
            height: 80,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Offer ID: ${isService ? service!.offerId : offerList?.offerId ?? ' '}',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                '${DateFormat('dd-MM-yyyy').format(DateTime.parse(isService ? service!.dateTime.toString() : offerList?.dateTime.toString() ?? ''))}',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  isService
                      ? service!.jobTitle ?? ''
                      : offerList?.jobTitle ?? '',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 14,
                width: 1,
                color: Colors.black,
              ),
              Expanded(
                child: Align(alignment: Alignment.centerRight,
                  child: Text(maxLines: 1,overflow: TextOverflow.ellipsis,
                    /*${isService ? service!.rateType ?? ' ' : offerList?.rateType ?? ' '}(*/
                    '৳ ${isService ? service!.rate : offerList?.rate ?? '0'}',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  isService
                      ? service!.serviceCategoryType ?? ''
                      : offerList?.serviceCategoryType ?? '',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600),
                ),
              ),
              Icon(
                CupertinoIcons.cart,
                size: 20,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                isService
                    ? service!.quantity.toString()
                    : offerList?.quantity.toString() ?? '0', maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              )
            ],
          ),
          button ??
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  isService
                      ? service!.description ?? ''
                      : offerList?.description ?? '',
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
                ),
              ),
        ],
      ),
    );
  }
}

class SellerStatusWidget extends StatelessWidget {
  const SellerStatusWidget({
    super.key,
    this.seller,
    this.title,
    this.value,
    this.color,
    this.icon,
  });

  final SellerProfileModel? seller;
  final String? title;
  final String? value;
  final Color? color;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: color!.withOpacity(.2),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: color ?? Colors.lightBlue, shape: BoxShape.circle),
                padding: EdgeInsets.all(4),
                child: Icon(
                  icon ?? Icons.attach_money,
                  color: Colors.white,
                  size: getResponsiveFontSize(context,15),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                title ?? 'Total Earning',
                style: TextStyle(fontSize: getResponsiveFontSize(context,12), fontWeight: FontWeight.w600),
              ))
            ],
          ),
          Text(
            value ?? '${seller!.sellerProfile!.totalEarning}',
            style: TextStyle(fontSize: getResponsiveFontSize(context,18), fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}
