import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/my_date_util.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/ChatScreen/Model/message_model.dart';

import '../../../core/utils/image_path.dart';

class InboxCardWidget extends StatelessWidget {
   final UserInfoModel userInfoModel;
     const InboxCardWidget({super.key, required this.userInfoModel,});
  @override
  Widget build(BuildContext context) {
    Message? message;
    return Container(
      margin: const EdgeInsets.only(left: 12,right: 12,bottom: 4,top: 4),
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.strokeColor2,width: 1)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
        child: StreamBuilder(
          stream: FirebaseAPIs.getLastMessage(userInfoModel),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list =
                data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
            if (list.isNotEmpty)
              {
                message = list[0];

              }
            return ListTile(
              // contentPadding: EdgeInsets.zero,
              leading: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: AppColors.strokeColor,width: 2)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          height: 50,
                          width: 50,
                          imageUrl: userInfoModel.image.toString(),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(ImageConstant.dummy, fit: BoxFit.cover),
                          errorWidget: (context, url, error) => Image.asset(ImageConstant.dummy, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    //   CircleAvatar(
                    //   radius: 25,
                    //   backgroundImage:AssetImage(ImageConstant.demoProfile),
                    // ),
                    Positioned(
                        right: 8,
                        bottom: 3,
                        child: userInfoModel.isOnline! ? const UserActive() : const UserInactive()
                    )
                  ]

              ),
              title: Text(userInfoModel.userName.toString(),style: AppTextStyle.bodyMediumBlackSemiBold,),
              subtitle: message==null? const Text(""):Text(message!.type==Type.image?"Image":message!.msg.toString()),
              contentPadding: EdgeInsets.zero,
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text( MyDateUtil.getLastMessageTime(
                      context: context, time:message!.sent.toString()),style: AppTextStyle.titleText,),
                  const SizedBox(height: 5,),
                  Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),

                    ),
                    child: const Center(child: Text("2",style: TextStyle(color: Colors.white),)),
                  )
                ],
              ) ,
            );




          },
        )
      ),
    );
  }
}

class UserInactive extends StatelessWidget {
  const UserInactive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: const Color(0xFFC5CEE0),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white,width: 1.5)
      ),
    );
  }
}
class UserActive extends StatelessWidget {
  const UserActive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.white,width: 1.5)
      ),
    );
  }
}