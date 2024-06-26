import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/presentation/Inbox/chat_screen.dart';
import 'package:upai/widgets/chat_item_widget.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12,right: 12,),
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: AppColors.textFieldBackGround,
                      filled: true,
                      hintText: "Search service you're looking for...",
                      hintStyle:
                          TextStyle(fontSize: 14, color: Colors.grey.shade500),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(6))),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return  Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.toNamed("/chatscreen");
                          },
                            child: const ChatItemWidget()),
                        // const Divider(),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
