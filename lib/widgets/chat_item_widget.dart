import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';

import '../core/utils/image_path.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12,right: 12,bottom: 4,top: 4),
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.strokeColor2,width: 1)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
        child: ListTile(
         // contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 25,
            backgroundImage:AssetImage(ImageConstant.demoProfile),
          ),
          title: Text("Jhenny Wilson",style: AppTextStyle.bodyMediumBlackSemiBold,),
          subtitle: Text("Can you please do the work for me?",overflow: TextOverflow.ellipsis,),
           contentPadding: EdgeInsets.zero,
           trailing: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text("10:39",style: AppTextStyle.titleText,),
               const SizedBox(height: 5,),
               Container(
                 height: 18,
                 width: 18,

                 decoration: BoxDecoration(
                     color: Colors.black,
                   borderRadius: BorderRadius.circular(100),

                 ),
                 child: Center(child: Text("2",style: TextStyle(color: Colors.white),)),
               )
             ],
           ) ,
        ),
      ),
    );
  }
}
