import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/offer_list_model.dart';
import 'package:upai/core/utils/image_path.dart';

class OfferService extends StatelessWidget {
  final OfferList offer;
  final EdgeInsets? margin;
  final double? width;
   const OfferService({super.key, required this.offer, this.margin, this.width});

  @override
  Widget build(BuildContext context) {
    var size =  MediaQuery.sizeOf(context);
    return Column(
      children: [
        InkWell(
          onTap: ()
          {
            print("going to service page");
            Get.toNamed("/servicedetails",arguments: offer);
          },
          child: Container(
            margin: margin?? EdgeInsets.only(right: 10),
            width:width??size.width*0.42,
            clipBehavior: Clip.antiAlias,

            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1.50, color: Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      // width: 156,
                      // height: 85,
                      clipBehavior: Clip.antiAlias,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFF3F3F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: size.width,
                        height: 70,
                      child: Image(
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(ImageConstant.dummy);
                        },
                        image: const NetworkImage(
                          "https://cdn.prod.website-files.com/6410ebf8e483b5bb2c86eb27/6410ebf8e483b5758186fbd8_ABM%20college%20mobile%20app%20dev%20main.jpg"),
                        fit: BoxFit.fill,
                      ),),
                    ),
                  ),
                  const SizedBox(height: 10,),
                   Text(
                     maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    '${offer.jobTitle}',
                    style: const TextStyle(
                      color: Color(0xFF404040),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,

                    ),
                  ),
                   Text(
                    '${offer.userName}',
                    style: const TextStyle(
                      color: Color(0xFF817F7F),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                   Text(
                    '৳ ${offer.rate}',
                    style: const TextStyle(
                      color: Color(0xFF3F3F3F),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Center(
                    child: Container(
                      width: size.width,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF3F3F3F),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Center(
                        child: Text(
                          'Book Now',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}