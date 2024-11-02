import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/my_date_util.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/chat/Controller/chat_screen_controller.dart';
import 'package:upai/presentation/chat/Model/message_model.dart';
import 'package:upai/presentation/chat/Widgets/chat_message_tile.dart';
import 'package:upai/sampleresponse/suggest_msg_data.dart';
import 'package:upai/widgets/custom_text_field.dart';
import '../../core/utils/image_path.dart';
import 'Widgets/suggest_msg_widget.dart';

class ChatScreen extends StatelessWidget {
  // final String? name, photo, userName, chatRoomId;

  final UserInfoModel receiverInfo = Get.arguments;
  //final UserInfoModel receiverUserInfo=UserInfoModel();


  @override
  Widget build(BuildContext context) {
    UserInfoModel receiverUserData=receiverInfo;
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ChatScreenController>(builder: (ctrl) {
      return PopScope(
        canPop: !ctrl.showEmoji,
        onPopInvoked: (_) async {
          if (ctrl.showEmoji) {
            ctrl.showEmoji = false;
            ctrl.update();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
toolbarHeight:50.w,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,

            centerTitle: false,
            title: StreamBuilder(
              stream: FirebaseAPIs.getUserInfo(receiverInfo.userId.toString()),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final receiverData = data
                        ?.map((e) => UserInfoModel.fromJson(e.data()))
                        .toList() ??

                    [];

                if (receiverData.isNotEmpty) {
                  receiverUserData=receiverData[0];
                  return Row(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.strokeColor, width: 2)),
                        child: CachedNetworkImage(
                          height: 40.w,
                          width: 40.w,
                          imageUrl: receiverData[0].image!.toString(),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(
                              ImageConstant.senderImg,
                              fit: BoxFit.cover),
                          errorWidget: (context, url, error) => Image.asset(
                              ImageConstant.senderImg,
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      // CircleAvatar(
                      //   radius: 20,
                      //   backgroundImage: NetworkImage(receiverInfo.image.toString()),
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receiverData[0].name.toString(),
                            style:  TextStyle(fontSize: default14FontSize, color:Colors.black,height: 1.5),
                          ),

                          // receiverInfo.isOnline!
                          receiverData[0].isOnline!
                              ?  Row(
                                  children: [
                                    Icon(
                                      Icons.circle_rounded,
                                      size: 8.sp,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                          fontSize: default12FontSize,
                                          color: Colors.green,
                                          height: 1.5),
                                    ),
                                  ],
                                )
                              : Text(
                                  MyDateUtil.getLastActiveTime(
                                      context: context,
                                      lastActive: receiverData[0]
                                          .lastActive
                                          .toString()),
                                  style: TextStyle(
                                      fontSize: default12FontSize,
                                      color: Colors.grey,
                                      height: 1.5),
                                )
                        ],
                      ),
                    ],
                  );
                } else {
                  receiverUserData=receiverInfo;
                  return Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: AppColors.strokeColor, width: 2)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            height: 40,
                            width: 40,
                            imageUrl: receiverInfo.image!.toString(),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                                ImageConstant.senderImg,
                                fit: BoxFit.cover),
                            errorWidget: (context, url, error) => Image.asset(
                                ImageConstant.senderImg,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      // CircleAvatar(
                      //   radius: 20,
                      //   backgroundImage: NetworkImage(receiverInfo.image.toString()),
                      // ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receiverInfo.name.toString(),
                            style:  TextStyle(fontSize: default14FontSize, height: 1.5),
                          ),
                          receiverInfo.isOnline!
                              ?  Row(
                                  children: [
                                    Icon(
                                      Icons.circle_rounded,
                                      size: 8,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                          fontSize: default12FontSize,
                                          color: Colors.green,
                                          height: 1.5),
                                    ),
                                  ],
                                )
                              : Text(
                                  MyDateUtil.getLastActiveTime(
                                      context: context,
                                      lastActive:
                                          receiverInfo.lastActive.toString()),
                                  style: TextStyle(
                                      fontSize: default12FontSize,
                                      color: Colors.grey,
                                      height: 1.5),
                                )
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
            // title: Text(widget.name!),
            iconTheme: IconThemeData(size: defaultAppBarIconSize),
            actions: [
              InkWell(
                  onTap: () {
                    ctrl.makePhoneCall(receiverUserData.userId.toString());
                  },
                  child: Icon(Icons.call,color: AppColors.kprimaryColor,)),
              const SizedBox(
                width: 12,
              ),
              // InkWell(
              //     onTap: () {},
              //     child: SvgPicture.asset(
              //       ImageConstant.videoCallIcon,
              //     )),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseAPIs.getAllMessages(receiverInfo),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                    //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      ctrl.messageList = data
                              ?.map((e) => Message.fromJson(e.data()))
                              .toList() ??
                          [];

                      if (ctrl.messageList.isNotEmpty) {
                        return ListView.builder(
                            reverse: true,
                            itemCount: ctrl.messageList.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ChatMessageTile(
                                context,
                                message: ctrl.messageList[index],
                                receiverInfo: receiverUserData,
                              );

                              //return MessageCard(message: ctrl.messageList[index]);
                            });
                      } else {
                        return const Center(
                          child: Text('Say Hii! 👋',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                  }
                },
              )),
              SizedBox(
                height: 5,
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  //height: 80,
                  child: Column(
                    children: [
                      Divider(
                        color: AppColors.strokeColor,
                        height: 5,
                        thickness: 1.5,
                        endIndent: 0,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        color: Colors.white,
                        height: 40.w,
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: ListView.separated(
                          itemCount: suggestMsgList.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                          itemBuilder: (context, index) => InkWell(
                            onTap: (){
                              ctrl.messageController.text="${ctrl.messageController.text} ${suggestMsgList[index]}";
                            },
                            child:  SuggestMsgWidget(suggestMsg: suggestMsgList[index]),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(defaultPadding),
                        child: Row(
                          children: [GestureDetector(
                            child:Icon(Icons.sentiment_satisfied_alt,size: 20.sp,color: Colors.grey.shade700,),
                            onTap: () {
                              ctrl.showEmoji = !ctrl.showEmoji;
                              FocusManager.instance.primaryFocus
                                  ?.unfocus();

                              ctrl.update();
                            },
                          ),spaceWidth6,
                            Expanded(
                              child: CustomTextField(

                                maxLines: 4,
                                hintText:"type_a_message".tr,
                                controller: ctrl.messageController,
                                inputType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                suffixIcon:  GestureDetector(
                                  child:
                                  Image.asset(ImageConstant.attachmentIcon,),
                                  onTap: () async {
                                    FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                    if (result != null) {
                                      PlatformFile file = result.files.first;
                                      print(file.name);
                                      print(file.size);
                                      print(file.extension);
                                      print(file.path);
                                      ctrl.messageController.text = file.name;
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                ),

                              ),
                            ),


                            InkWell(
                              onTap: () {
                                if (ctrl.messageController.text.isNotEmpty) {
                                  if (ctrl.messageList.isEmpty) {
                                    //on first message (add user to my_user collection of chat user)
                                    FirebaseAPIs.sendFirstMessage(
                                        receiverUserData,
                                        ctrl.messageController.text
                                            .trim()
                                            .toString(),
                                        Type.text);
                                  } else {
                                    //simply send message
                                    FirebaseAPIs.sendMessage(
                                        receiverUserData,
                                        ctrl.messageController.text
                                            .trim()
                                            .toString(),
                                        Type.text);
                                  }
                                  ctrl.messageController.text = '';
                                }
                                // ctrl.update();
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.kprimaryColor,
                                //  backgroundImage: AssetImage(ImageConstant.sendIcon),
                                child: Image.asset(ImageConstant.sendIcon),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (ctrl.showEmoji)
                Expanded(
                  child: EmojiPicker(
                    onBackspacePressed: () {},
                    textEditingController: ctrl.messageController,
                    config: Config(
                      columns: 7,
                      emojiSizeMax: 28 * (Platform.isIOS ? 1.2 : 1.0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}


// Container(
// decoration: const BoxDecoration(color: Colors.white),
// child: ListView.builder(
// reverse: true,
// padding: const EdgeInsets.only(
// left: 16, right: 16, top: 8, bottom: 8),
// itemCount: 21,
// itemBuilder: (context, index) {
// // DocumentSnapshot ds = snapshot.data.docs[index];
// // return chatMessageTile(ds["message"], myUserName == ds["sendBy"]);
// return ChatMessageTile(context,
// message: index % 2 == 0
// ? "From side 1111111111111111111111111111111111111111111111111111111111111111111"
//     : "From Side 2222222222222222222222222222222",
// sendByMe: index % 2 == 0);
// },
// ),
// ),
