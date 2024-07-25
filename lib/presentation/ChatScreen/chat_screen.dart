import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/TestData/suggest_msg_data.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/my_date_util.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/ChatScreen/Controller/chat_screen_controller.dart';
import 'package:upai/presentation/ChatScreen/Model/message_model.dart';
import 'package:upai/presentation/ChatScreen/Widgets/chat_message_tile.dart';

import '../../core/utils/image_path.dart';
import 'Widgets/suggest_msg_widget.dart';

class ChatScreen extends StatelessWidget {
  // final String? name, photo, userName, chatRoomId;

  final UserInfoModel receiverInfo = Get.arguments;

  @override
  Widget build(BuildContext context) {
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
            leadingWidth: 28,
            elevation: 1,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            centerTitle: false,
            title: StreamBuilder(
              stream: FirebaseAPIs.getUserInfo(receiverInfo),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final receiverData = data
                        ?.map((e) => UserInfoModel.fromJson(e.data()))
                        .toList() ??
                    [];
                if (receiverData.isNotEmpty) {
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
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),

                          // receiverInfo.isOnline!
                          receiverData[0].isOnline!
                              ? const Row(
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
                                          fontSize: 12,
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
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      height: 1.5),
                                )
                        ],
                      ),
                    ],
                  );
                } else {
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
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                          receiverInfo.isOnline!
                              ? const Row(
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
                                          fontSize: 12,
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
                                  style: const TextStyle(
                                      fontSize: 12,
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
                // Get.offAllNamed("/inbox");
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => const InboxScreen()),
                //   (route) => false,
                // );
              },
            ),
            actions: [
              InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    ImageConstant.audioCallIcon,
                  )),
              const SizedBox(
                width: 12,
              ),
              InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    ImageConstant.videoCallIcon,
                  )),
              const SizedBox(
                width: 16,
              ),

              // Container(
              //   width: 70,
              //   color: Colors.red,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       IconButton(
              //           onPressed: (){}, icon: SvgPicture.asset(ImageConstant.audioCallIcon,)),
              //       IconButton(onPressed: (){}, icon: SvgPicture.asset(ImageConstant.videoCallIcon))
              //     ],
              //   ),
              // )
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
                                receiverInfo: receiverInfo,
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
                        height: 40,
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
                      SizedBox(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLines: 4,
                                    textInputAction: TextInputAction.newline,
                                    keyboardType: TextInputType.multiline,
                                    controller: ctrl.messageController,
                                    onTap: () {
                                      if (ctrl.showEmoji) {
                                        ctrl.showEmoji = false;
                                        ctrl.update();
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Type a message",
                                      hintStyle: TextStyle(color: Colors.grey.shade500),
                                      suffixIcon: GestureDetector(
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
                                      prefixIcon: GestureDetector(
                                        child: Image.asset(ImageConstant.smileEmoji,),
                                        onTap: () {
                                          ctrl.showEmoji = !ctrl.showEmoji;
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();

                                          ctrl.update();
                                        },
                                      ),
                                     // contentPadding: const EdgeInsets.all(4),
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey.shade100),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    if (ctrl.messageController.text.isNotEmpty) {
                                      if (ctrl.messageList.isEmpty) {
                                        //on first message (add user to my_user collection of chat user)
                                        FirebaseAPIs.sendFirstMessage(
                                            receiverInfo,
                                            ctrl.messageController.text
                                                .trim()
                                                .toString(),
                                            Type.text);
                                      } else {
                                        //simply send message
                                        FirebaseAPIs.sendMessage(
                                            receiverInfo,
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
                                    backgroundColor: const Color(0xFF404040),
                                    //  backgroundImage: AssetImage(ImageConstant.sendIcon),
                                    child: Image.asset(ImageConstant.sendIcon),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
