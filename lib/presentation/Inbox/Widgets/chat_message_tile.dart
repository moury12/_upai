import 'package:flutter/material.dart';
import 'package:upai/core/utils/image_path.dart';

class ChatMessageTile extends StatelessWidget {
  const ChatMessageTile(BuildContext context, {
    super.key,
    required this.message, required this.sendByMe,
  });

  final String message;
  final bool sendByMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        sendByMe
            ? const Text("")
            : CircleAvatar(
          radius: 16,
          //backgroundColor: const Color(0xFF404040),
          backgroundImage: AssetImage(ImageConstant.senderImg),
        ),
        Flexible(
            child: ConstrainedBox(
              constraints:  BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width*0.7),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: sendByMe ? const Color(0xFF404040) : const Color(0xFFC5CEE0)),
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
                  message,
                  style:
                  TextStyle(color: sendByMe ? Colors.white : const Color(0xFF151C33)),
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