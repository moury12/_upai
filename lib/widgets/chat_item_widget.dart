import 'package:flutter/material.dart';
import 'package:upai/core/utils/custom_text_style.dart';

import '../core/utils/image_path.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
     // contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 25,
        backgroundImage:AssetImage(ImageConstant.demoProfile),
      ),
      title: Text("Jhenny Wilson",style: AppTextStyle.bodyMedium,),
      subtitle: Text("Can you please do the work for me?",overflow: TextOverflow.ellipsis,),
       trailing: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Text("10:39"),
         ],
       ) ,
    );
  }
}
