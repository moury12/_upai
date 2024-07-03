import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/ChatScreen/Model/message_model.dart';
import 'package:upai/presentation/ChatScreen/Widgets/chat_message_tile.dart';
import 'package:upai/presentation/ChatScreen/Controller/chat_screen_controller.dart';

import '../../core/utils/image_path.dart';

class ChatScreen extends StatelessWidget {
  // final String? name, photo, userName, chatRoomId;

  final UserInfoModel receiverInfo = Get.arguments;

  ChatScreen({
    super.key,
    // required this.photo,
    // required this.name,
    // required this.userName,
    // required this.chatRoomId
  });

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
            leadingWidth: 32,
            elevation: 1,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            centerTitle: false,
            title: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.strokeColor,width: 2)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: receiverInfo.image.toString(),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(ImageConstant.receiverImg, fit: BoxFit.cover),
                      errorWidget: (context, url, error) => Image.asset(ImageConstant.receiverImg, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
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
                      receiverInfo.userName.toString(),
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    receiverInfo.isOnline!
                        ? Row(
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
                        : Row(
                            children: [
                              Icon(
                                Icons.circle_rounded,
                                size: 8,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Offline",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    height: 1.5),
                              ),
                            ],
                          )
                  ],
                ),
              ],
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
                      return const SizedBox();

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
                              return ChatMessageTile(context,
                                  message: ctrl.messageList[index], receiverInfo: receiverInfo,);

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
              Divider(
                color: AppColors.strokeColor,
                height: 5,
                thickness: 1.5,
                //
                // // thickness: .5,
                // // indent: 100,
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
                    itemCount: 9,
                    padding: EdgeInsets.zero,
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 11.52, vertical: 3.84),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF7F9FC),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.72),
                                side: BorderSide(color: AppColors.strokeColor)),
                          ),
                          child: const Text(
                            'How can I send my CV?',
                            style: TextStyle(
                              color: Color(0xFF3F3F3F),
                              fontSize: 13,
                              fontFamily: 'Epilogue',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          // height: 70,
                          // width: size.width / 1.20,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: ctrl.messageController,
                              onTap: () {
                                if (ctrl.showEmoji) {
                                  ctrl.showEmoji = false;
                                  ctrl.update();
                                  // setState(() {});
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Type a message",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                suffixIcon: GestureDetector(
                                  child:
                                      Image.asset(ImageConstant.attachmentIcon),
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
                                  child: Image.asset(ImageConstant.smileEmoji),
                                  onTap: () {
                                    ctrl.showEmoji = !ctrl.showEmoji;
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    ctrl.update();
                                    // setState(() {});
                                  },
                                ),
                                contentPadding: const EdgeInsets.all(4),
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
                            // IconButton(
                            //   onPressed: () {
                            //     // messageController.text.isNotEmpty ? addMessage(true) : null;
                            //   },
                            //   icon: Icon(
                            //     Icons.send,
                            //     color:messageController!=null ? Colors.white : Colors.white,size: 18,
                            //   ),
                            // ),
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
