import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/item_service_model.dart';
import 'package:upai/core/utils/image_path.dart';

class ItemService extends StatelessWidget {
  final ItemServiceModel singleItem;
   const ItemService({super.key, required this.singleItem});

  @override
  Widget build(BuildContext context) {
    var size =  MediaQuery.sizeOf(context);
    return Column(
      children: [
        InkWell(
          onTap: ()
          {
            Get.toNamed("/servicedetails");
          },
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            width:size.width*0.42,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
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
                      child: Container(
                        width: size.width,
                        height: 66,
                      child: Image(
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(ImageConstant.dummy);
                        },
                        image: NetworkImage(
                          singleItem.imageUrl.toString()),
                        fit: BoxFit.fill,
                      ),),
                    ),
                  ),
                  const SizedBox(height: 10,),
                   Text(
                    '${singleItem.title}',
                    style: const TextStyle(
                      color: Color(0xFF404040),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,

                    ),
                  ),
                   Text(
                    '${singleItem.userName}',
                    style: const TextStyle(
                      color: Color(0xFF817F7F),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                   Text(
                    '৳ ${singleItem.price}',
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
                      height: 30,
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