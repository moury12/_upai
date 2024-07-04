import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/data/api/firebase_apis.dart';
import 'package:upai/presentation/ChatScreen/Model/message_model.dart';

import '../../../core/utils/app_colors.dart';

class ChatMessageTile extends StatelessWidget {
  const ChatMessageTile(
    BuildContext context, {
    super.key,
    required this.message,
    required this.receiverInfo,
  });
  final Message message;
  final UserInfoModel receiverInfo;

  @override
  Widget build(BuildContext context) {
    bool sendByMe = FirebaseAPIs.user["user_id"] == message.fromId.toString();
    if(!sendByMe)
      {
        if (message.read!.isEmpty) {
          FirebaseAPIs.updateMessageReadStatus(message);
        }
      }

    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        const SizedBox(width: 8,),
        sendByMe
            ? const Text("")
            : Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.strokeColor, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    height: 40,
                    width: 40,
                    imageUrl: receiverInfo.image!.toString(),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                        ImageConstant.receiverImg,
                        fit: BoxFit.cover),
                    errorWidget: (context, url, error) => Image.asset(
                        ImageConstant.receiverImg,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
        Flexible(
            child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.7),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(
                    color: sendByMe
                        ? const Color(0xFF404040)
                        : const Color(0xFFC5CEE0)),
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(16),
                    topLeft: const Radius.circular(16),
                    bottomRight: sendByMe
                        ? const Radius.circular(6)
                        : const Radius.circular(16),
                    bottomLeft: sendByMe
                        ? const Radius.circular(16)
                        : const Radius.circular(6)),
                color: sendByMe ? const Color(0xFF404040) : Colors.white),
            child: Text(
              message.msg.toString(),
              style: TextStyle(
                  color: sendByMe ? Colors.white : const Color(0xFF151C33)),
            ),
          ),
        )),
        // sendByMe
        //     ? CircleAvatar(
        //         //backgroundColor: const Color(0xFF404040),
        //         backgroundImage: AssetImage(ImageConstant.receiverImg),
        //       )
        //     : const Text(""),
      ],
    );
  }
}
