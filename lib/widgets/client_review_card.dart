import 'package:flutter/material.dart';
class ClientReviewCard extends StatelessWidget {
  const ClientReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ListTile(

        )
        // Container(
        //   width: 242,
        //   height: 155,
        //   clipBehavior: Clip.antiAlias,
        //   decoration: ShapeDecoration(
        //     shape: RoundedRectangleBorder(
        //       side: const BorderSide(width: 1.50, color: Color(0xFFE0E0E0)),
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //   ),
        //   child: Stack(
        //     children: [
        //       const Positioned(
        //         left: 50,
        //         top: 15,
        //         child: Text(
        //           'Client Name',
        //           style: TextStyle(
        //             color: Color(0xFF3F3F3F),
        //             fontSize: 11,
        //             fontFamily: 'Inter',
        //             fontWeight: FontWeight.w500,
        //             height: 0,
        //           ),
        //         ),
        //       ),
        //       const Positioned(
        //         left: 50,
        //         top: 32,
        //         child: Text(
        //           '22 Jan, 2023',
        //           style: TextStyle(
        //             color: Color(0xFF817F7F),
        //             fontSize: 10,
        //             fontFamily: 'Inter',
        //             fontWeight: FontWeight.w400,
        //             height: 0,
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         left: 164,
        //         top: 31,
        //         child: Container(
        //           height: 8,
        //           child: Stack(
        //             children: [
        //               Positioned(
        //                 left: 21,
        //                 top: 0,
        //                 child: Container(
        //                   width: 8,
        //                   height: 8,
        //                   padding: const EdgeInsets.only(
        //                     top: 0.07,
        //                     left: 0.01,
        //                     right: 0.01,
        //                     bottom: 0.30,
        //                   ),
        //                   clipBehavior: Clip.antiAlias,
        //                   decoration: const BoxDecoration(),
        //                   child: const Row(
        //                     mainAxisSize: MainAxisSize.min,
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: [
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               Positioned(
        //                 left: 31,
        //                 top: 0,
        //                 child: Container(
        //                   width: 8,
        //                   height: 8,
        //                   padding: const EdgeInsets.only(
        //                     top: 0.07,
        //                     left: 0.01,
        //                     right: 0.01,
        //                     bottom: 0.30,
        //                   ),
        //                   clipBehavior: Clip.antiAlias,
        //                   decoration: const BoxDecoration(),
        //                   child: const Row(
        //                     mainAxisSize: MainAxisSize.min,
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: [
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               Positioned(
        //                 left: 41,
        //                 top: 0,
        //                 child: Container(
        //                   width: 8,
        //                   height: 8,
        //                   padding: const EdgeInsets.only(
        //                     top: 0.07,
        //                     left: 0.01,
        //                     right: 0.01,
        //                     bottom: 0.30,
        //                   ),
        //                   clipBehavior: Clip.antiAlias,
        //                   decoration: const BoxDecoration(),
        //                   child: const Row(
        //                     mainAxisSize: MainAxisSize.min,
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: [
        //
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               Positioned(
        //                 left: 51,
        //                 top: 0,
        //                 child: Container(
        //                   width: 8,
        //                   height: 8,
        //                   padding: const EdgeInsets.only(
        //                     top: 0.07,
        //                     left: 0.01,
        //                     right: 0.01,
        //                     bottom: 0.30,
        //                   ),
        //                   clipBehavior: Clip.antiAlias,
        //                   decoration: const BoxDecoration(),
        //                   child: const Row(
        //                     mainAxisSize: MainAxisSize.min,
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: [
        //
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               Positioned(
        //                 left: 61,
        //                 top: 0,
        //                 child: Container(
        //                   width: 8,
        //                   height: 8,
        //                   padding: const EdgeInsets.only(
        //                     top: 0.07,
        //                     left: 0.01,
        //                     right: 0.01,
        //                     bottom: 0.30,
        //                   ),
        //                   clipBehavior: Clip.antiAlias,
        //                   decoration: const BoxDecoration(),
        //                   child: const Row(
        //                     mainAxisSize: MainAxisSize.min,
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: [
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               const Positioned(
        //                 left: 0,
        //                 top: 0,
        //                 child: Text(
        //                   '4.9',
        //                   style: TextStyle(
        //                     color: Color(0xFF404040),
        //                     fontSize: 11,
        //                     fontFamily: 'Inter',
        //                     fontWeight: FontWeight.w600,
        //                     height: 0,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       const Positioned(
        //         left: 12,
        //         top: 60,
        //         child: SizedBox(
        //           width: 219,
        //           height: 73,
        //           child: Text(
        //             'Lorem ipsum dolor sit amet consectetur. Ornare pretium sit faucibus non massa sit. At integer nulla vel nisi. Turpis morbi vulputate placerat lacus pellentesque sed. Vel sit nibh in id dictum augue.',
        //             style: TextStyle(
        //               color: Color(0xFF4D4D4D),
        //               fontSize: 11,
        //               fontFamily: 'Inter',
        //               fontWeight: FontWeight.w400,
        //               height: 0.13,
        //             ),
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         left: 10,
        //         top: 9,
        //         child: Container(
        //           width: 35,
        //           height: 35,
        //           decoration: const ShapeDecoration(
        //             color: Color(0xFFD9D9D9),
        //             shape: OvalBorder(),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}