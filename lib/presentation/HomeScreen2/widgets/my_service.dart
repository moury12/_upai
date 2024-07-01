import 'package:flutter/material.dart';
import 'package:upai/presentation/ServiceDetails/service_details.dart';

class MyService extends StatelessWidget {
  const MyService({super.key});

  @override
  Widget build(BuildContext context) {
    var size =  MediaQuery.sizeOf(context);
    return Column(
      children: [
        InkWell(
          onTap: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ServiceDetails(),));
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
                        width: 66,
                        height: 66,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/dummyimage.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    'Service Title is here.',
                    style: TextStyle(
                      color: Color(0xFF3F3F3F),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  const Text(
                    'User Name',
                    style: TextStyle(
                      color: Color(0xFF817F7F),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      height: 0,
                    ),
                  ),
                  const Text(
                    '৳1000.00',
                    style: TextStyle(
                      color: Color(0xFF3F3F3F),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  // Center(
                  //   child: Container(
                  //     width: size.width,
                  //     height: 30,
                  //     clipBehavior: Clip.antiAlias,
                  //     decoration: ShapeDecoration(
                  //       color: const Color(0xFF3F3F3F),
                  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  //     ),
                  //     child: const Center(
                  //       child: Text(
                  //         'Book Now',
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 11,
                  //           fontFamily: 'Inter',
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}