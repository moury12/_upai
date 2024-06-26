import 'dart:io';
import 'dart:math';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/Inbox/Widgets/chat_message_tile.dart';

import '../../core/utils/image_path.dart';
import '../Inbox/inbox.dart';

class ChatScreen extends StatefulWidget {
  // final String? name, photo, userName, chatRoomId;

  const ChatScreen({
    super.key,
    // required this.photo,
    // required this.name,
    // required this.userName,
    // required this.chatRoomId
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  TextEditingController messageController = TextEditingController();
  String? messageId;
  String? chatRoomId;
  bool _showEmoji = false;

  // String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
  //     length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  // Stream? messageStream;
  // bool isTyped = false;

  // String getChatRoomId(String a, String b) {
  //   if (a.compareTo(b) < 0) {
  //     return "$a\_$b";
  //   } else {
  //     return "$b\_$a";
  //   }
  // }

  // addMessage(bool sendClicked) {
  //   if (messageController != "") {
  //     print("aaaaaaaaaaaaaaaaaa");
  //     String message = messageController.text;
  //     messageController.clear();
  //     DateTime dateTime = DateTime.now();
  //     String formattedDate = DateFormat("h:mma").format(dateTime);
  //     Map<String, dynamic> messageInfo = {
  //       "message": message,
  //       "sendBy": myUserName,
  //       "ts": formattedDate,
  //       "time": FieldValue.serverTimestamp(),
  //       "imageUrl": myPhoto
  //     };
  // if(messageId == ""){
  //   messageId = getRandomString(12);
  // }
  // FireStoreDatabase()
  //     .addMessage(chatRoomId!, getRandomString(12), messageInfo)
  //     .then((value) {
  //   Map<String, dynamic> lastMessageInfo = {
  //     "lastMessage": message,
  //     "lastMessageSendTs": formattedDate,
  //     "time": FieldValue.serverTimestamp(),
  //     "lastMessageSendBy": myUserName
  //   };
  //   FireStoreDatabase()
  //       .updateLastMessageSend(chatRoomId!, lastMessageInfo);
  //   if (sendClicked) {
  //     messageId = "";
  //   }
  // });
  //   }
  // }

  // Widget chatMessage() {
  //   return StreamBuilder(
  //     stream: messageStream,
  //     builder: (context, AsyncSnapshot snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(
  //             child: CircularProgressIndicator(color: Colors.black));
  //       } else if (snapshot.hasError) {
  //         return Text('Error: ${snapshot.error}');
  //       } else if (snapshot.hasData) {
  //         return ListView.builder(
  //           reverse: true,
  //           padding: const EdgeInsets.only(bottom: 90, top: 130),
  //           itemCount: snapshot.data.docs.length,
  //           itemBuilder: (context, index) {
  //             DocumentSnapshot ds = snapshot.data.docs[index];
  //             return chatMessageTile(ds["message"], myUserName == ds["sendBy"]);
  //           },
  //         );
  //       } else {
  //         return const Center(
  //           child: Text("No Message found!"),
  //         );
  //       }
  //     },
  //   );
  // }

  // Widget chatMessageTile(String message, bool sendByMe) {
  //   return chatMessageTile(message, sendByMe);
  // }

  // getAndSetMessages() async {
  //   messageStream =
  //   await FireStoreDatabase().getChatRoomMessages(widget.chatRoomId!);
  // }

  // Future<void> loadData() async {
  //   chatRoomId = getChatRoomId(widget.userName!, myUserName);
  //   await getAndSetMessages();
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      // loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: !_showEmoji,
      onPopInvoked: (_) async {
        if (_showEmoji) {
          setState(() => _showEmoji = !_showEmoji);
        } else {
        Get.back();
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
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(ImageConstant.demoProfile),
              ),
              const SizedBox(
                width: 10,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Super Client",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  Row(
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
                            fontSize: 12, color: Colors.green, height: 1.5),
                      ),
                    ],
                  ),
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
              onTap: (){},
                child: SvgPicture.asset(ImageConstant.audioCallIcon,)),
            const SizedBox(width: 12,),
            InkWell(
              onTap: (){},
                child: SvgPicture.asset(ImageConstant.videoCallIcon,)),
            const SizedBox(width: 16,),
      
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
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    // DocumentSnapshot ds = snapshot.data.docs[index];
                    // return chatMessageTile(ds["message"], myUserName == ds["sendBy"]);
                    return chatMessageTile(context,
                        message: index % 2 == 0
                            ? "From side 1111111111111111111111111111111111111111111111111111111111111111111"
                            : "From Side 2222222222222222222222222222222",
                        sendByMe: index % 2 == 0);
                  },
                ),
              ),
            ),
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
              margin: const EdgeInsets.only(left: 8,right: 8),
              child: ListView.separated(
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
                            side: BorderSide(color: AppColors.strokeColor)
                          ),
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
                  itemCount: 3,
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

                            controller: messageController,
                            onTap: () {
                              if(_showEmoji)
                                {
                                  _showEmoji= false;
                                  setState(() {
                                  });
                                }
                            },
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              suffixIcon: GestureDetector(
                                child: Image.asset(ImageConstant.attachmentIcon),
                                onTap: () async {

                                  FilePickerResult? result = await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                    PlatformFile file = result.files.first;
                                    print(file.name);
                                    print(file.size);
                                    print(file.extension);
                                    print(file.path);
                                    messageController.text=file.name;
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                              ),
                              prefixIcon: GestureDetector(
                                child: Image.asset(ImageConstant.smileEmoji),
                                onTap: () {
                                  _showEmoji = !_showEmoji;
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {
                                  });
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
                  ],
                ),
              ),
            ),
            if (_showEmoji)
              Expanded(
                child: EmojiPicker(
                  onBackspacePressed: (){},
                  textEditingController:messageController,
                  config: Config(
                    columns: 7,
                      emojiSizeMax: 28 *
                          (Platform.isIOS
                              ? 1.2
                              : 1.0),
                ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
