import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/my_date_util.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/chat/Model/message_model.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
import 'package:upai/presentation/notification/controller/notification_controller.dart';

import '../../../core/utils/image_path.dart';

class InboxCardWidget extends StatelessWidget {
  final UserInfoModel receiverUserInfo;
  const InboxCardWidget({
    super.key,
    required this.receiverUserInfo,
  });

  @override
  Widget build(BuildContext context) {
    bool sendByMe = true;
    Message? message;
    UserInfoModel? receiverUserData;
    return Container(
        margin:  EdgeInsets.symmetric(horizontal: defaultPadding,vertical: default4Padding),
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.strokeColor2, width: 1)),
        child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: defaultPadding),
            child: StreamBuilder(
                stream: FirebaseAPIs.getUserInfo(
                    receiverUserInfo.userId.toString()),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                  final receiverData = data
                          ?.map((e) => UserInfoModel.fromJson(e.data()))
                          .toList() ??
                      [];

                  if (receiverData.isNotEmpty) {
                   receiverUserData = receiverData[0];
                    return StreamBuilder(
                      stream: FirebaseAPIs.getLastMessage(receiverUserData!),
                      builder: (context, snapshot) {
                        final data = snapshot.data?.docs;
                        final list = data
                                ?.map((e) => Message.fromJson(e.data()))
                                .toList() ??
                            [];
                        if (list.isNotEmpty) {
                          message = list[0];
                          sendByMe = message!.fromId.toString() ==
                              FirebaseAPIs.user['user_id'];
                          return
                          Row(children: [
                            Stack(children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.strokeColor,
                                        width: 2)),
                                child: CachedNetworkImage(
                                  height: 50.w,
                                  width: 50.w,
                                  imageUrl: receiverUserData!.image.toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image.asset(
                                      ImageConstant.senderImg,
                                      fit: BoxFit.cover),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(ImageConstant.senderImg,
                                          fit: BoxFit.cover),
                                ),
                              ),
                              //   CircleAvatar(
                              //   radius: 25,
                              //   backgroundImage:AssetImage(ImageConstant.demoProfile),
                              // ),
                              Positioned(
                                  right: 8,
                                  bottom: 3,
                                  child: receiverUserData!.isOnline!
                                      ? const UserActive()
                                      : const UserInactive())
                            ]),
                            defaultSizeBoxWidth,
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(
                                  receiverUserData!.name.toString(),
                                  style: AppTextStyle.bodyMediumBlackSemiBold(context),
                                ),
                                message != null
                                    ?sendByMe?
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  message!.type == Type.image
                                      ? "Image"
                                      : "You: ${message!.msg}",
                                  maxLines: 1,style: AppTextStyle.font12grey400(context),
                                )
                                    :message!.read!.isEmpty?
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  message!.type == Type.image
                                      ? "Image"
                                      : "${message!.msg}",
                                  maxLines: 1,style: AppTextStyle.unReadMsgStyle(context),
                                ):Text(
                                  overflow: TextOverflow.ellipsis,
                                  message!.type == Type.image
                                      ? "Image"
                                      : "${message!.msg}",
                                  maxLines: 1,style: AppTextStyle.font12grey400(context),
                                )
                                    :const Text(""),
                              ],),
                            ),Spacer(), Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  MyDateUtil.getLastMessageTime(
                                      context: context,
                                      time: message!.sent.toString()),
                                  style: AppTextStyle.titleText(context),
                                ),

                                sendByMe
                                    ? const SizedBox()
                                    : message!.read!.isEmpty
                                    ? const UnReadIndicator()
                                    : const SizedBox.shrink(),
                              ],
                            )
                          ],);

                        }
                        else {
                          return
                          Row(children: [
                            Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: AppColors.strokeColor,
                                        width: 2)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    height: 50.w,
                                    width: 50.w,
                                    imageUrl: receiverUserInfo.image.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Image.asset(
                                        ImageConstant.senderImg,
                                        fit: BoxFit.cover),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(ImageConstant.senderImg,
                                            fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ]),
                            defaultSizeBoxWidth,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  receiverUserInfo.name.toString(),
                                  style: AppTextStyle.bodyMediumBlackSemiBold(context),
                                ),
                            ],)
                          ],);

                        }
                      },
                    );
                  }
                  else {
                    return Row(children: [
                      Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: AppColors.strokeColor,
                                  width: 2)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              height: 50.w,
                              width: 50.w,
                              imageUrl: receiverUserInfo.image.toString(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                  ImageConstant.senderImg,
                                  fit: BoxFit.cover),
                              errorWidget: (context, url, error) =>
                                  Image.asset(ImageConstant.senderImg,
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ]),defaultSizeBoxWidth,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receiverUserInfo.name.toString(),
                            style: AppTextStyle.bodyMediumBlackSemiBold(context),
                          )
                        ],
                      )
                    ],);

                  }
                })));
  }
}



class UnReadIndicator extends StatelessWidget {
  const UnReadIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeController.to.isUnRead.value=false;
    return Container(
        height: 10.w,
        width: 10.w,
        decoration: BoxDecoration(
          color: AppColors
              .messageIndicatorColor,
          borderRadius:
              BorderRadius.circular(100),
        ),
        // child: const Center(child: Text("2",style: TextStyle(color: Colors.white),)),
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
      height:12.w,
      width: 12.w,
      decoration: BoxDecoration(
          color: const Color(0xFFC5CEE0),
          shape: BoxShape.circle,           border: Border.all(color: Colors.white, width: 1.5)),
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
      height:12.w,
      width: 12.w,
      decoration: BoxDecoration(
          color: Colors.green,
shape: BoxShape.circle,          border: Border.all(color: Colors.white, width: 1.5)),
    );
  }
}
